//
//  TVCell.h
//  iOS Interview
//
//  Created by Qui on 17/07/17.
//  Copyright © 2017 w.e.b. All rights reserved.
//

//==============================================================================
#pragma mark -
#pragma mark Imports
//==============================================================================

#import <UIKit/UIKit.h>


//==============================================================================
#pragma mark -
#pragma mark Protocols & enumerations
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark @class & @protocol definitions
//==============================================================================




//==============================================================================
#pragma mark -
#pragma mark Public interface (usable outside of class)
//==============================================================================

@interface TVCell : UITableViewCell {
	
	// Instance variables (without properties)
	
	
}

// IBOutlet properties
/**
 *	Label storing the title of a chapter
 */
@property (nonatomic, weak) IBOutlet UILabel *todoLabel;

@property (nonatomic, weak) IBOutlet UITextField *itemText;

// Other properties


// Class methods


// Instance methods


@end
