//
//  WebView.h
//
//  Created by Jon Brown on 9/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WebView : NSView {
    IBOutlet id UIDelegate;
    IBOutlet id downloadDelegate;
    IBOutlet id frameLoadDelegate;
    IBOutlet id policyDelegate;
    IBOutlet id resourceLoadDelegate;
}
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)makeTextLarger:(id)sender;
- (IBAction)makeTextSmaller:(id)sender;
- (IBAction)makeTextStandardSize:(id)sender;
- (IBAction)reload:(id)sender;
- (IBAction)stopLoading:(id)sender;
- (IBAction)takeStringURLFrom:(id)sender;
- (IBAction)toggleContinuousSpellChecking:(id)sender;
- (IBAction)toggleSmartInsertDelete:(id)sender;
@end
