

#import <Cocoa/Cocoa.h>
#import "MCViewFlipController.h"

@interface FlipAnimationAppDelegate : NSObject <NSApplicationDelegate> {

    IBOutlet id frontView;
    IBOutlet id backView;
    IBOutlet id hostView;
    MCViewFlipController *flipController;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)flip:(id)sender;

@end
