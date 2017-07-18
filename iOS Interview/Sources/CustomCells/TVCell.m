//
//  TVCell.m
//  iOS Interview
//
//  Created by Qui on 17/07/17.
//  Copyright © 2017 w.e.b. All rights reserved.
//

//==============================================================================
#pragma mark -
#pragma mark Imports
//==============================================================================

#import "TVCell.h"


//==============================================================================
#pragma mark -
#pragma mark Local define statements
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark Private interface (usable only within class)
//==============================================================================

@interface TVCell() {
	
	// Instance variables (without properties)
	
	
}

// IBOutlet properties


// Other properties


// Instance methods


@end


//==============================================================================
#pragma mark -
#pragma mark Implementation
//==============================================================================

@implementation TVCell

//==============================================================================
#pragma mark -
#pragma mark Class methods and overwritten methods
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark Getter and setter methods
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark Cell lifecycle
//==============================================================================

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        _itemText.hidden = NO;
        _todoLabel.hidden = YES;
    } else {
        _itemText.hidden = YES;
        _todoLabel.hidden = NO;
    }
}

//==============================================================================
#pragma mark -
#pragma mark Common methods
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark Memory management
//==============================================================================




@end
