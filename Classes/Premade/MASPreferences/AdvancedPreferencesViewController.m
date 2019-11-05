
#import "AdvancedPreferencesViewController.h"

/*
@implementation AdvancedPreferencesViewController


#pragma mark -

- (id)init
{
    return [super initWithNibName:@"AdvancedPreferencesView" bundle:nil];
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"AdvancedPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:@"Sped"];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"Widget", @"Toolbar item name for the Widget preference pane");
}

- (void) awakeFromNib
{
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  regpref = [defaults objectForKey:@"reg-code"];
    
    
    // Read default prefrences for member name
    if (regpref == (id)[NSNull null] || regpref.length == 0 ) {
        
        [regName setStringValue:@""];
        
    } else {
        
        [regName setStringValue:regpref];
        
        [InstallButton setTitle:@"Widgets Already Installed"];
        [InstallButton setEnabled: NO];
    }
}

@end
*/
