//
//  PreferenceWindow.m
//  Foodie
//
//  Created by Jon Brown on 3/18/13.
//  Copyright (c) 2013 Jon Brown. All rights reserved.
//

#import "PreferenceWindow.h"
#import "MASPreferencesWindowController.h"
#import "GeneralPreferencesViewController.h"
#import "AdvancedPreferencesViewController.h"
#import "UpdatePreferenceViewController.h"

@implementation PreferenceWindow


#pragma mark -

- (IBAction)openPreferences:(id)sender
{
    
    [self.preferencesWindowController showWindow:nil];
    
}


#pragma mark - Public accessors

- (NSWindowController *)preferencesWindowController
{
    if (_preferencesWindowController == nil)
    {
        NSViewController *generalViewController = [[GeneralPreferencesViewController alloc] init];
        NSViewController *advancedViewController = [[AdvancedPreferencesViewController alloc] init];
        NSViewController *updateViewController = [[UpdatePreferenceViewController alloc] init];
        
        
        
#ifdef TRIAL
        
    NSArray *controllers = [[NSArray alloc] initWithObjects:generalViewController, updateViewController, nil];

#elif WEBSITE
    
    NSArray *controllers = [[NSArray alloc] initWithObjects:generalViewController, updateViewController, nil];
        
#elif STORE
        
    NSArray *controllers = [[NSArray alloc] initWithObjects:generalViewController, nil];

#else
        
    NSArray *controllers = [[NSArray alloc] initWithObjects:generalViewController, nil];
        
        
#endif
        
        
        
        
       // [generalViewController release];
      //  [advancedViewController release];
     //   [updateViewController release];
        
        NSString *title = NSLocalizedString(@"Preferences", @"Common title for Preferences window");
        _preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
      //  [controllers release];
    }
    return _preferencesWindowController;
}


- (void) awakeFromNib
{
    
    
    [prefwindow setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"Black"]]];
    
}


@end
