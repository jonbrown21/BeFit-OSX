//
//  mySheetController.h
//  BeFit
//
//  Created by Jon Brown on 9/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface mySheetController : NSWindowController
{
    IBOutlet id regSheet;
	IBOutlet id thanksSheet;
	IBOutlet id ownSheet;
	IBOutlet id agreeSheet;
    IBOutlet id mainWindow;
	IBOutlet id purchaseWindow;
	IBOutlet id prefSheet;
}

- (IBAction)doneRegister:(id)sender;

- (IBAction)launchOwn:(id)sender;
- (IBAction)doneOwn:(id)sender;


- (IBAction)launchThanks:(id)sender;
- (IBAction)doneThanks:(id)sender;

- (IBAction)launchPref:(id)sender;
- (IBAction)donePref:(id)sender;

- (IBAction)launchStore:(id)sender;
- (IBAction)launchLost:(id)sender;

- (IBAction)launchAgreesheet:(id)sender;
- (IBAction)doneAgree:(id)sender;
- (IBAction)doneDisagree:(id)sender;




@end
