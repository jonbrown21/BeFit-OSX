//
//  UpdatePreferenceController.m
//  BeFit
//
//  Created by Jon Brown on 1/2/14.
//
//

#import "UpdatePreferenceViewController.h"

@implementation UpdatePreferenceViewController

- (id)init
{
    return [super initWithNibName:@"UpdatePreferencesView" bundle:nil];
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)viewIdentifier
{
    return @"UpdatePreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:@"Update"];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"Update", @"Toolbar item name for the Update preference pane");
}

- (void) awakeFromNib
{
    
    
    NSColor *color = [NSColor redColor];
    NSMutableAttributedString *colorTitle =
    [[NSMutableAttributedString alloc] initWithAttributedString:[button attributedTitle]];
    
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    
    [colorTitle addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:titleRange];
    
    [button setAttributedTitle:colorTitle];

}

@end
