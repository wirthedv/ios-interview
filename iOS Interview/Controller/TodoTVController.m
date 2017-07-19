//
//  TodoTVController.m
//  iOS Interview
//
//  Created by Qui on 17/07/17.
//  Copyright © 2017 w.e.b. All rights reserved.
//

//==============================================================================
#pragma mark -
#pragma mark Imports
//==============================================================================

#import "TodoTVController.h"
#import "AppDelegate.h"
#import "TVCell.h"

//==============================================================================
#pragma mark -
#pragma mark Local define statements
//==============================================================================

/**
 *	Macro for identifier of a reusable table view cell
 */
#define TV_CELL_PROTOTYPE_ID @"TV Cell"

//==============================================================================
#pragma mark -
#pragma mark Private interface (usable only within class)
//==============================================================================

@interface TodoTVController () <UITableViewDelegate, UITableViewDataSource> {
    // Instance variables (without properties)
}

// IBOutlet properties
/**
 *	Table view showing an overview
 */
@property (nonatomic, weak) IBOutlet UITableView *todoTV;

// Other properties
/**
 *	Stores information
 */
@property (nonatomic, strong) NSMutableArray *todoList;
/**
 *	References the index path of the last selected cell within the property @ref todoTV respectively @ref chapterCV
 */
@property (nonatomic, strong) NSIndexPath *selectedCell;

// Instance methods

@end

//==============================================================================
#pragma mark -
#pragma mark Implementation
//==============================================================================

@implementation TodoTVController

-(void)record {
    [[NSUserDefaults standardUserDefaults] setObject:self.todoList forKey:@"todoList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)restore {
    self.todoList = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"todoList"]];
}


- (void)setUpToolbar {
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"To Do List";
}


- (void)loadTodoList {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    if (filePath != nil) {
        NSData *content = [NSData dataWithContentsOfFile:filePath];
        
        _todoList = [[NSMutableArray alloc] init];
        _todoList = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:nil];
        
        [self record];
    }
}

//==============================================================================
#pragma mark -
#pragma mark View lifecycle
//==============================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"todoList"] count] < 2) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"todoList"];
        [self loadTodoList];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"todoList"] != nil) {
        [self restore];
    } else {
        [self loadTodoList];
    }
    
    [self setUpToolbar];
}

/**
 *	Adapts the user interface to the current orientation by triggering a method call of
 *	@ref adaptUIToOrientation: and deselects the last selected row within the property @ref todoTV.
 *
 *	@param animated Indicates whether or not the view's appearance is animated
 */
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.selectedCell) {
        [self.todoTV deselectRowAtIndexPath:self.selectedCell animated:YES];
        self.selectedCell = nil;
    }
}

/**
 *	Makes the property @ref todoTV flash its scroll indicators.
 *
 *	@param animated Indicates whether or not the view's appearance is animated
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ((self.todoTV.rowHeight * [self.todoList count]) > self.todoTV.frame.size.height) {
        self.todoTV.bounces = YES;
        [self.todoTV performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:0.0];
    }
    
}

//==============================================================================
#pragma mark -
#pragma mark Table view data source methods
//==============================================================================

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else {
        [self setUpToolbar];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.todoList count];
}

/**
 *	Configures the cells of the property @ref todoTV subject to section and row.
 *
 *	@param indexPath Index path for current section and row
 *
 *	@returns The cell for the current index path
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVCell *cell = (TVCell *)[tableView dequeueReusableCellWithIdentifier:TV_CELL_PROTOTYPE_ID];
    cell.tag = indexPath.row;
    
    NSString *todoElement = self.todoList[indexPath.row];
    
    // Configuring cell specific settings
    cell.todoLabel.textColor = kColorBlack;
    cell.todoLabel.text = todoElement;
    cell.itemText.text = [self.todoList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *stringToMove = [self.todoList objectAtIndex:fromIndexPath.row];
    [self.todoList removeObjectAtIndex:fromIndexPath.row];
    [self.todoList insertObject:stringToMove atIndex:toIndexPath.row];
    
    [self record];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoList removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self record];
    }
}

//==============================================================================
#pragma mark -
#pragma mark Table view delegate methods
//==============================================================================

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setUpToolbar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

//==============================================================================
#pragma mark -
#pragma mark Storyboard Segue
//==============================================================================

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

//==============================================================================
#pragma mark -
#pragma mark Memory management
//==============================================================================

/**
 *	Specifies actions for when the view controller receives a low memory warning:
 *	- Release the view if it doesn't have a superview
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
