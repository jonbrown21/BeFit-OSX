#import "GUIController.h"
#import "AddGramsValueTransformer.h"
#import "AddMGValueTransformer.h"
#import "BeFitGraphOpenGLView.h"
#import "mySheetController.h"
#import "iTableColumnHeaderCell.h"
#import "INAppStoreWindow.h"
#import "INWindowButton.h"
#import <WebKit/WebKit.h>

@implementation GUIController
@synthesize window;
@synthesize webView;




- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    self.window.closeButton = closeButton;
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.window.zoomButton = button;
}






- (IBAction)ShowHideNutritionPanel:(id)sender
{
	
	//Change whatever the current setting is for the nutrition panel's hide/show value
	[ NutritionPanelWinNSView setHidden: ![ NutritionPanelWinNSView isHidden ] ];
	
	//Show/Hide the nutrition panel
	NSRect CurrentFrame = [ FoodNSTableView frame ];
	
	if ( [ NutritionPanelWinNSView isHidden ] )
	{
		NSRect FrameToUse = CurrentFrame;
		
		FrameToUse.size.width = FrameToUse.size.width + [ NutritionPanelWinNSView frame ].size.width;
		[ FoodNameColumn setWidth: [ FoodNameColumn width ] + [ NutritionPanelWinNSView frame ].size.width ];
		
		[ FoodNSTableView setFrame: FrameToUse ];
		
		NSRect GraphFrame = [ GraphPanelWinNSView frame ];
		GraphFrame.size.width = GraphFrame.size.width + [ NutritionPanelWinNSView frame ].size.width;
		[ GraphPanelWinNSView setFrame: GraphFrame ];
		
		NSRect OpenGLFrame = [ webView frame ];
		OpenGLFrame.size.width = GraphFrame.size.width;
		[ GraphPanelWinNSView setFrame: OpenGLFrame ];
        
	}
	else
	{
		NSRect FrameToUse = CurrentFrame;
		
		FrameToUse.size.width = FrameToUse.size.width - [ NutritionPanelWinNSView frame ].size.width;
		[ FoodNameColumn setWidth: [ FoodNameColumn width ] - [ NutritionPanelWinNSView frame ].size.width ];
		
		[ FoodNSTableView setFrame: FrameToUse ];
		
		NSRect GraphFrame = [ GraphPanelWinNSView frame ];
		GraphFrame.size.width = GraphFrame.size.width - [ NutritionPanelWinNSView frame ].size.width;
		[ GraphPanelWinNSView setFrame: GraphFrame ];
        
		NSRect OpenGLFrame = [ webView frame ];
		OpenGLFrame.size.width = GraphFrame.size.width;
		[ GraphPanelWinNSView setFrame: OpenGLFrame ];
        
	}
}


-(BOOL)changeableColumnIsEditable
{
	return( NO );
}



- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	
	//Sent when the food list changes we need to redraw the individual food table here to avoid drawing artifacts
	//Really this shouldn't be needed but seems Mac OS X might have a bug here at least on Tiger.
	[ FoodNSTableView setNeedsDisplay: YES ];
	
	if( [ FoodListsNSTableView selectedRow ] == 0 )
	{
		[ FoodQuantityTableColumn setHidden: YES ];
        [ FoodRatingTableColumn setHidden: YES ];
        [ FoodDateTableColumn setHidden: YES ];
	} else {
		[ FoodQuantityTableColumn setHidden: NO ];
        [ FoodRatingTableColumn setHidden: NO ];
        [ FoodDateTableColumn setHidden: YES ];
	}
    
}

-(void)doNothing
{
	
	//What did you think this did?
}



-(void)ShowGraphPanel
{
	
	//Show the graph panel
	if ( [ GraphPanelWinNSView isHidden ] )
	{ [ self ShowHideGraphPanel: self ]; }
}



-(void)HideGraphPanel
{
	
	//Hide the graph panel
	if ( ![ GraphPanelWinNSView isHidden ] )
	{ [ self ShowHideGraphPanel: self ]; }
}


-(void)awakeFromNib
{
    
    //Set Done Button Color
    
    NSColor *color = [NSColor whiteColor];
    
    NSMutableAttributedString *colorTitle =
    [[NSMutableAttributedString alloc] initWithAttributedString:[Finishedbutton attributedTitle]];
    
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    
    [colorTitle addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:titleRange];
    
    [Finishedbutton setAttributedTitle:colorTitle];
    
    
    NSScrollView *sv = [FoodNSTableView enclosingScrollView];
    [sv setScrollerStyle: NSScrollerStyleOverlay];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
    [[[webView mainFrame] frameView] setAllowsScrolling:NO];
    [[webView mainFrame] loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
    [webView setDrawsBackground:NO];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"foodgraph" ofType:@"html"];
    NSString *html2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    [[[lowerGraphView mainFrame] frameView] setAllowsScrolling:NO];
    [[lowerGraphView mainFrame] loadHTMLString:html2 baseURL:[[NSBundle mainBundle] resourceURL]];
    [lowerGraphView setDrawsBackground:NO];
    
    
    /* set preference defaults */
    [[NSUserDefaults standardUserDefaults] registerDefaults:
     [NSDictionary dictionaryWithObject: [NSNumber numberWithBool: YES]
                                 forKey: @"NSDisabledCharacterPaletteMenuItem"]];
    
    self.window.trafficLightButtonsLeftMargin = 10.0;
    self.window.centerTrafficLightButtons = NO;
    self.window.centerFullScreenButton = NO;
    self.window.titleBarHeight = 80.0;
    self.window.trafficLightButtonsTopMargin = 10;
    self.window.fullScreenButtonRightMargin = 5;
    self.window.fullScreenButtonTopMargin = 5;
    self.window.showsTitle = YES;
    self.titleView.frame = self.window.titleBarView.bounds;
    self.titleView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.window.titleBarView addSubview:self.titleView];
    
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];
    
    
    
    
    
    [tableView reloadData];
    
    NSRect frame = tableView.headerView.frame;
    frame.size.height = 17;
    tableView.headerView.frame = frame;
	
    NSArray *columns = [tableView tableColumns];
    NSEnumerator *cols = [columns objectEnumerator];
    NSTableColumn *col = nil;
    
    iTableColumnHeaderCell *iHeaderCell;
    
    while (col = [cols nextObject]) {
        iHeaderCell = [[iTableColumnHeaderCell alloc]
                       initTextCell:[[col headerCell] stringValue]];
        [col setHeaderCell:iHeaderCell];
        [iHeaderCell release];
    }
	
	
	[mainWindow setDelegate:self];
    
	
	//Setting this so we can disable items in the menu
	[ FileMenu setAutoenablesItems: NO ];
	
	
	//Add the nutrition panel to the window
    [myScrollView setDocumentView:finalView];
    
    NSPoint pt = NSMakePoint(0.0, [[myScrollView documentView]
                                   bounds].size.height);
    [[myScrollView documentView] scrollPoint:pt];
    
	
    
	[ NutritionPanelWinNSView setNeedsDisplay: TRUE ];
	
	
	[ GraphPanelWinNSView setNeedsDisplay: TRUE ];
	
	//Register the value transformers
	AddGramsValueTransformer* GramsTransformer = [ [ [ AddGramsValueTransformer alloc ] init ] autorelease ];
	
	[ NSValueTransformer setValueTransformer: GramsTransformer forName: @"addGrams" ];
	
	AddMGValueTransformer* MGTransformer = [ [ [ AddMGValueTransformer alloc ] init ] autorelease ];
	
	[ NSValueTransformer setValueTransformer: MGTransformer forName: @"addMG" ];
	
	[ self HideGraphPanel ];
    
    
    
    
    
    
    //Add the nutrition panel to the window
	
	
	
    
	[myBackView setDocumentView:finalBackView];
    
    
    [myBackView setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"black_linen_v2.png"]]];
    
    
}

- (void)windowWillClose:(NSNotification *)aNotification {
	[NSApp terminate:self];
}




-(IBAction)loadSupport:(id)sender{
	
	NSURL *url=[NSURL URLWithString:@"http://www.jonbrown.org/support/#bfit"];
	[[NSWorkspace sharedWorkspace] openURL:url];
	
}





-(IBAction)loadEmaildev:(id)sender{
	NSURL *url=[NSURL URLWithString:@"mailto:jon@jonbrown.org?subject=BeFit%20Feedback&body=Feedback"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}



-(IBAction)loadWebsite:(id)sender{
	NSURL *url=[NSURL URLWithString:@"http://osx.iusethis.com/app/befit"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}


-(IBAction)loadFacebook:(id)sender{
	NSURL *url=[NSURL URLWithString:@"http://www.facebook.com/sharer.php?s=100&p[url]=http://www.jonbrown.org/befit/&p[title]=BeFit&p[summary]=BeFit+is+the+ultimate+calorie+tracking+tool.+Based+on+the+nutrition+data+for+the+foods+that+you+eat.+Enter+the+coupon+code+%23BF2014+and+get+BeFit+at+30%25+off+for+a+limited+time%21"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

-(IBAction)loadTwitter:(id)sender{
	NSURL *url=[NSURL URLWithString:@"http://twitter.com/share?url=http%3A%2F%2Fwww.jonbrown.org%2Fbefit%2F&via=JonBrownDesigns&text=BeFit+is+the+ultimate+calorie+tracking+tool.+Based+on+the+nutrition+data+for+the+foods+that+you+eat.+Enter+the+coupon+code+%23BF2014+and+get+BeFit+at+30%25+off+for+a+limited+time%21"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)ShowHideGraphPanel:(id)sender
{
	
	//Change whatever the current setting is for the graph panel's hide/show value
	[ GraphPanelWinNSView setHidden: ![ GraphPanelWinNSView isHidden ] ];
	
	//Show/Hide the graph panel
	NSRect CurrentFrame = [ FoodNSTableView frame ];
	
	//We don't adjust the full height since one pixel is hidden of the graph panel
	float HeightToAdjust = [ GraphPanelWinNSView frame ].size.height - 1;
	
	if ( [ GraphPanelWinNSView isHidden ] )
	{
		NSRect FrameToUse = CurrentFrame;
		
		FrameToUse.size.height = FrameToUse.size.height + HeightToAdjust;
		FrameToUse.origin.y = FrameToUse.origin.y - HeightToAdjust;
		
		[ FoodNSTableView setFrame: FrameToUse ];
	}
	else
	{
		NSRect FrameToUse = CurrentFrame;
		
		FrameToUse.size.height = FrameToUse.size.height - HeightToAdjust;
		FrameToUse.origin.y = FrameToUse.origin.y + HeightToAdjust;
		
		[ FoodNSTableView setFrame: FrameToUse ];
	}
	
	[ FoodNSTableView setNeedsDisplay: TRUE ];
	[ GraphPanelWinNSView setNeedsDisplay: TRUE ];
}


- (IBAction)print:(id)sender {
    
    NSPrintOperation* printOperation = [NSPrintOperation printOperationWithView:PrintView];
    [printOperation setCanSpawnSeparateThread:YES];
    [printOperation runOperationModalForWindow:[self window] delegate:MainWindow didRunSelector:nil contextInfo:nil];
    
}

- (IBAction)pagesetup:(id)sender {
    
    
    NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
    NSPageLayout *pageLayout = [NSPageLayout pageLayout];
    
    
    [pageLayout beginSheetWithPrintInfo:printInfo modalForWindow:[self window] delegate:MainWindow didEndSelector:@selector(pageLayoutDidEnd:returnCode:contextInfo:) contextInfo:nil];
    
    
    //runs the model for the page layout UI.  It saves the global copy of printInfo in printOperation, which can be used to make decisions
    
    
}

- (void)pageLayoutDidEnd:(NSPageLayout *)pageLayout returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
    if (returnCode == NSOKButton)
    {
    }
}


- (IBAction)ResizeCols:(id)sender {
    
    [tableView setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
    
    [FoodNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [CalNameCalumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [FoodQuantityTableColumn setResizingMask:NSTableColumnUserResizingMask];
    [FoodRatingTableColumn setResizingMask:NSTableColumnUserResizingMask];
    [FoodDateTableColumn setResizingMask:NSTableColumnUserResizingMask];
    
    //[FoodNameColumn sizeToFit];
    [CalNameCalumn setWidth:70];
    [MixNameColumn setWidth:70];
    [FoodQuantityTableColumn setWidth:70];
    [FoodRatingTableColumn setWidth:100];
    [FoodDateTableColumn setWidth:100];
    
    [FoodNameColumn setWidth:400];
}



@end