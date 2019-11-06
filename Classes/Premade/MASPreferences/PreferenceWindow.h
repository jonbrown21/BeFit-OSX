//
//  PreferenceWindow.h
//  Foodie
//
//  Created by Jon Brown on 3/18/13.
//  Copyright (c) 2013 Jon Brown. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceWindow : NSWindowController

{
    IBOutlet id prefwindow;    
    NSWindowController *_preferencesWindowController;
    
}

- (IBAction)openPreferences:(id)sender;

@end
