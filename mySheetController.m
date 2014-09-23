//
//  mySheetController.m
//  BeFit
//
//  Created by Jon Brown on 9/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "mySheetController.h"

@implementation mySheetController


- (IBAction)doneRegister:(id)sender
{
	[regSheet orderOut:nil];
    [NSApp endSheet:regSheet];
	
}


- (IBAction)launchOwn:(id)sender
{
    [NSApp beginSheet:ownSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
	NSURL *FileURL = [NSURL URLWithString:@"http://jonbrown.org/download/mobile-store.html"];
	[[purchaseWindow mainFrame] loadRequest:[NSURLRequest requestWithURL:FileURL]];
	[[[purchaseWindow mainFrame] frameView] setAllowsScrolling:YES];
	[purchaseWindow setNeedsDisplay:YES];
	
}

- (IBAction)doneOwn:(id)sender
{
	[ownSheet orderOut:nil];
    [NSApp endSheet:ownSheet];
	
	[NSApp beginSheet:thanksSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
}

- (IBAction)launchThanks:(id)sender
{
    [NSApp beginSheet:thanksSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
	
}

- (IBAction)doneThanks:(id)sender
{
	[thanksSheet orderOut:nil];
    [NSApp endSheet:thanksSheet];
	
}

- (IBAction)launchAgreesheet:(id)sender
{
    [NSApp beginSheet:agreeSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
}

- (IBAction)doneAgree:(id)sender
{
	[ [ NSUserDefaults standardUserDefaults ] setObject: @"Agreed" forKey: @"License Agreement" ];
	[agreeSheet orderOut:nil];
	[ mainWindow center ];
	[ mainWindow makeKeyAndOrderFront: self ];
    [NSApp endSheet:agreeSheet];
}


- (IBAction)doneDisagree:(id)sender
{
	
	[agreeSheet orderOut:nil];
	[NSApp endSheet:agreeSheet];
	[ [ NSApplication sharedApplication ] terminate: self ];
}


- (IBAction)launchStore:(id)sender
{
	
	[ownSheet orderOut:nil];
    [NSApp endSheet:ownSheet];
	
    [NSApp beginSheet:regSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
	NSURL *FileURL = [NSURL URLWithString:@"http://jonbrown.org/download/mobile-store.html"];
	[[purchaseWindow mainFrame] loadRequest:[NSURLRequest requestWithURL:FileURL]];
	[[[purchaseWindow mainFrame] frameView] setAllowsScrolling:YES];
	[purchaseWindow setNeedsDisplay:YES];
}

- (IBAction)launchLost:(id)sender
{
	
	[ownSheet orderOut:nil];
    [NSApp endSheet:ownSheet];
	
    [NSApp beginSheet:regSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
	NSURL *FileURL = [NSURL URLWithString:@"http://jonbrown.org/download/mobile-pass.html"];
	[[purchaseWindow mainFrame] loadRequest:[NSURLRequest requestWithURL:FileURL]];
	[[[purchaseWindow mainFrame] frameView] setAllowsScrolling:YES];
	[purchaseWindow setNeedsDisplay:YES];

	
}




- (IBAction)launchPref:(id)sender
{
    [NSApp beginSheet:prefSheet modalForWindow:mainWindow
        modalDelegate:self didEndSelector:NULL contextInfo:nil];
	
	
}

- (IBAction)donePref:(id)sender
{
	[prefSheet orderOut:nil];
    [NSApp endSheet:prefSheet];
	
}
@end
