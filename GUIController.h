/* GUIController */

#import <Cocoa/Cocoa.h>
#import "INAppStoreWindow.h"
#import <WebKit/WebKit.h>


@interface GUIController : NSObject
{
    IBOutlet id CholesteralLabel;
    IBOutlet id FileMenu;
    IBOutlet id FoodListsNSTableView;
    IBOutlet NSTableColumn * FoodNameColumn;
    IBOutlet NSTableColumn * MixNameColumn;
    IBOutlet NSTableColumn * CalNameCalumn;
    IBOutlet id FoodNSTableView;
	IBOutlet NSTableColumn * FoodQuantityTableColumn;
    IBOutlet NSTableColumn * FoodRatingTableColumn;
    IBOutlet NSTableColumn * FoodDateTableColumn;
    IBOutlet id GraphPanelWinNSView;
    IBOutlet id mainWindow;
    IBOutlet NSView * NutritionPanelWinNSView;
    IBOutlet id myScrollView;
    IBOutlet id finalView;
    IBOutlet NSTableView *tableView;
    IBOutlet id MainWindow;
    IBOutlet id backView;
    IBOutlet id NutritionPanelWinBackgroundNSView;
    IBOutlet id myBackView;
    IBOutlet id finalBackView;
    IBOutlet id Finishedbutton;
    IBOutlet id PrintView;
    
    IBOutlet id lowerGraphView;
    
    IBOutlet id window;
    IBOutlet id webView;
}
- (IBAction)pagesetup:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)loadWebsite:(id)sender;
- (IBAction)loadFacebook:(id)sender;
- (IBAction)loadTwitter:(id)sender;
- (IBAction)loadSupport:(id)sender;
- (IBAction)loadEmaildev:(id)sender;
- (IBAction)ShowHideGraphPanel:(id)sender;
- (IBAction)ShowHideNutritionPanel:(id)sender;
- (IBAction)ResizeCols:(id)sender;

@property (assign) IBOutlet INAppStoreWindow *window;
@property (assign) IBOutlet INTitlebarView *titleView;
@property (assign) IBOutlet WebView *webView;

-(void)ShowGraphPanel;
-(void)HideGraphPanel;

@end
