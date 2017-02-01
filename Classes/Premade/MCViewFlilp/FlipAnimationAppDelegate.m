
#import "FlipAnimationAppDelegate.h"

@implementation FlipAnimationAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	flipController = [[MCViewFlipController alloc] initWithHostView:hostView frontView:frontView backView:backView];

    
}

-(IBAction)flip:(id)sender
{
    [flipController flip:self];
}

@end
