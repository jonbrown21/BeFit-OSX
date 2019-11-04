#import "BeFit_AppDelegate.h"
#import "PrioritySplitViewDelegate.h"
#import "mySheetController.h"
#import "FoodListArrayController.h"
#import "FoodArrayController.h"
#import "GUIController.h"
#import "FoodNSTableView.h"
#import "FoodDragSupportBase.h"
#import "UAAppReviewManager.h"
#import "PFMoveApplication.h"
#import "iTableColumnHeaderCell.h"
#import "BeFit-Swift.h"

#if TRIAL || WEBSITE
//#import "RMAppDelegate+Trial.h"
#import <Paddle/Paddle.h>
#endif

#define LEFT_VIEW_INDEX 0
#define LEFT_VIEW_PRIORITY 2
#define LEFT_VIEW_MINIMUM_WIDTH 200.0
#define MAIN_VIEW_INDEX 1
#define MAIN_VIEW_PRIORITY 0
#define MAIN_VIEW_MINIMUM_WIDTH 735.0

@implementation BeFit_AppDelegate
@synthesize CalorieScrollView = _CalorieScrollView;
@synthesize webData;


/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "BeFit" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

//- (NSString *)applicationSupportFolder
//{
//	NSArray * paths;
//
//	paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
//	if([paths count] > 0 )
//	{
//		return( [paths objectAtIndex: 0] );
//	}
//
//	/* else, return a path to the resource directory */
//	return [[NSBundle mainBundle] resourcePath];
//}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle and all of the 
    framework bundles.
 */

// Setup the UA App Review Manager


+ (void)initialize {
    [BeFit_AppDelegate setupUAAppReviewManager];
}

+ (void)setupUAAppReviewManager {
    
#if WEBSITE || TRIAL || STORE
    
    [UAAppReviewManager setAppID:@"854891012"]; // 854891012 is the BeFit Free iTunes Code
    
#else
    
    [UAAppReviewManager setAppID:@"402924047"]; // 402924047 is the BeFit iTunes Code
    
#endif
    
    [UAAppReviewManager setDebug:YES];
}


// Trigger the UA App Review Manager


- (IBAction)presentStandardPrompt:(id)sender {
    
    [UAAppReviewManager showPromptWithShouldPromptBlock:^(NSDictionary *trackingInfo) {
        // This is the block syntx for showing prompts.
        // It lets you decide if it should be shown now or not based on
        // the UAAppReviewManager trackingInfo or any other factor.
        NSLog(@"UAAppReviewManager trackingInfo: %@", trackingInfo);
        // Don't show the prompt now, but do it from the buttons in the example app.
        return YES;
    }];
    
    // YES here means it is ok to show, it is the only override to Debug == YES.
    [UAAppReviewManager userDidSignificantEvent:YES];
}

- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
    NSMutableSet *allBundles = [[NSMutableSet alloc] init];
    [allBundles addObject: [NSBundle mainBundle]];
    [allBundles addObjectsFromArray: [NSBundle allFrameworks]];
    
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: [allBundles allObjects]];
    //[allBundles release];
    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The folder for the store is created, 
    if necessary.)
 */


#if TRIAL || STORE

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *pathString = [paths objectAtIndex:0];
    NSError *err = nil;
    NSString *applicationSupportFolder = [pathString stringByAppendingPathComponent: @"BeFit Trial"];
    
    NSFileManager *fileManager;
    //NSString *applicationSupportFolder = nil;
	NSString *dataFilePath;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    //applicationSupportFolder = [self applicationSupportFolder];
    //NSString *aappSupportFolder = [applicationSupportFolder stringByAppendingPathComponent: @"BeFit"];
    
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:applicationSupportFolder withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
	dataFilePath = [applicationSupportFolder stringByAppendingPathComponent: @"BeFit2D.dat"];
    
    
	if( NO == [[ NSFileManager defaultManager ] fileExistsAtPath: dataFilePath ] )
	{
        
		[[ NSFileManager defaultManager ] copyPath: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"BeFit2D.dat"]
                                            toPath: dataFilePath handler: NULL ];
        
	}
    
    url = [NSURL fileURLWithPath:dataFilePath];
	if( url )
	{
		persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
        
        NSDictionary *options = @{
                                  NSMigratePersistentStoresAutomaticallyOption : @YES,
                                  NSInferMappingModelAutomaticallyOption : @YES
                                  };
        
		
		if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error]){
            
			[[NSApplication sharedApplication] presentError:error];
		}
        
        
	}
    return persistentStoreCoordinator;
}

#else

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        
        
        return persistentStoreCoordinator;
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *pathString = [paths objectAtIndex:0];
    NSError *err = nil;
    NSString *applicationSupportFolder = [pathString stringByAppendingPathComponent: @"BeFit"];
    
    NSFileManager *fileManager;
    //NSString *applicationSupportFolder = nil;
	NSString *dataFilePath;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    //applicationSupportFolder = [self applicationSupportFolder];
    //NSString *aappSupportFolder = [applicationSupportFolder stringByAppendingPathComponent: @"BeFit"];
    
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [[NSFileManager defaultManager] createDirectoryAtPath:applicationSupportFolder withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
	dataFilePath = [applicationSupportFolder stringByAppendingPathComponent: @"BeFit2.dat"];
    
    
	if( NO == [[ NSFileManager defaultManager ] fileExistsAtPath: dataFilePath ] )
	{
        
		[[ NSFileManager defaultManager ] copyPath: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"BeFit2.dat"]
                                            toPath: dataFilePath handler: NULL ];
        
	}
    
    url = [NSURL fileURLWithPath:dataFilePath];
    
	if( url )
	{
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        
		persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
        
	
		if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error]){
            
			[[NSApplication sharedApplication] presentError:error];
		}    
	}
    
    return persistentStoreCoordinator;
}


#endif



/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}


/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    

        
        
        
    [myProgress startAnimation:self];
    [NSApp beginSheet:SaveWindow modalForWindow:window modalDelegate:self didEndSelector:NULL contextInfo:nil];
    NSTimer *tm=[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(closePanel:) userInfo:nil repeats:NO];
    
}



- (void)labelSave:(NSTimer*)labelSave
{

    [SavingLabel setStringValue:@""];
    
}

- (void)contSave:(NSTimer*)autoSave
{
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        abort();
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(labelSave:) userInfo:nil repeats:NO];
    
    
   [SavingLabel setStringValue:@"SAVING..."];
    
}

- (void)closePanel:(NSTimer *)theTimer
{
    [SaveWindow orderOut:nil];
    [NSApp endSheet:SaveWindow];
}

- (void)closedPanel:(NSTimer *)theTimer
{
    [SendWindow orderOut:nil];
    [NSApp endSheet:SendWindow];
}


-(BOOL)checkInternet
{
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.google.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    if ([NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil])
        return TRUE;
    return FALSE;
}


- (void)onlineCheck:(NSTimer*)labelCheck
{
    
    if ([self checkInternet]) {
        
        NSImage *notConnected = [NSImage imageNamed:@"Green"];
        [isOnline setImage: notConnected] ;
        
        [isOnline setToolTip:@"Online"];
        [isOnline setNeedsDisplay:YES];
        
    } else {
        
        
        NSImage *isConnected = [NSImage imageNamed:@"Grey"];
        [isOnline setImage: isConnected] ;
        
        [isOnline setToolTip:@"Offline"];
        [isOnline setNeedsDisplay:YES];
        
    }
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [BeFit_AppDelegate setupUAAppReviewManager];
    
    
    NSImage *isConnected = [NSImage imageNamed:@"Grey"];
    [isOnline setImage: isConnected] ;
    
    [isOnline setToolTip:@"Offline"];
    [isOnline setNeedsDisplay:YES];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  lbspref = [defaults objectForKey:@"goal-name"];
    double yourLong = [lbspref doubleValue];
    
    // Calories Level Ind.
    
    [LevelInd setMaxValue:yourLong];
    [LevelInd setWarningValue:(yourLong/3)];
    [LevelInd setCriticalValue:(yourLong/2)];
    
    // Cholesterol and Carbs Level Ind.
    
    [LevelInd2 setMaxValue:300];
    [LevelInd2 setWarningValue:(300/3)];
    [LevelInd2 setCriticalValue:(300/2)];
    
    
    [LevelInd3 setMaxValue:300];
    [LevelInd3 setWarningValue:(300/3)];
    [LevelInd3 setCriticalValue:(300/2)];
    
    // Protein Ind.
    
    [LevelInd4 setMaxValue:50];
    [LevelInd4 setWarningValue:(50/3)];
    [LevelInd4 setCriticalValue:(50/2)];
    
    // Sodium Ind.
    
    [LevelInd5 setMaxValue:2400];
    [LevelInd5 setWarningValue:(2400/3)];
    [LevelInd5 setCriticalValue:(2400/2)];
    
    // Fiber Ind.
    
    [LevelInd6 setMaxValue:25];
    [LevelInd6 setWarningValue:(25/3)];
    [LevelInd6 setCriticalValue:(25/2)];
    
    // Total Fat Ind.
    
    [LevelInd7 setMaxValue:50];
    [LevelInd7 setWarningValue:(50/3)];
    [LevelInd7 setCriticalValue:(50/2)];
    
    
    
    // Present Rating Window if needed.
    
    [UAAppReviewManager showPromptIfNecessary];
    
    
    // Set Default Preference Values
    //NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  flipin = [defaults objectForKey:@"flipPref"];
    [defaults setBool:0 forKey:@"flipPref"];
    
    int myInt = [flipin intValue];
    
    NSLog(@"Flip Preferencess: %@", flipin);

    // Check if Trial and if so ask if they want to move this app to applications folder.
    
    #if TRIAL || WEBSITE
    PFMoveToApplicationsFolderIfNecessary();
    [openFeedback presentFeedbackPanelIfCrashed];
    
    // Check if Trial and if so present expired message
    
    Paddle *paddle = [Paddle sharedInstance];
    [paddle setProductId:@"520775"];
    [paddle setVendorId:@"25300"];
    [paddle setApiKey:@"411430c46d02e5a5bc45c309068cd6e7"];
 
    NSDictionary *productInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"4.99", kPADCurrentPrice,
                                 @"Jon Brown Designs", kPADDevName,
                                 @"USD", kPADCurrency,
                                 @"BeFit", kPADProductName,
                                 @"30", kPADTrialDuration,
                                 @"Thanks for downloading a trial of BeFit for Mac", kPADTrialText,
                                 @"icon_512x512.png", kPADProductImage, //Image file in your project
                                 nil];
    
    [[Paddle sharedInstance] startLicensing:productInfo timeTrial:YES withWindow:window];
    
    #endif
    
    
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(onlineCheck:) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(contSave:) userInfo:nil repeats:YES];
    
    [self.CalorieScrollView setPattern:[NSImage imageNamed:@"Black"]];
    
    
	splitViewDelegate = [[PrioritySplitViewDelegate alloc] init];
    
	[splitViewDelegate
     setPriority:LEFT_VIEW_PRIORITY
     forViewAtIndex:LEFT_VIEW_INDEX];
	[splitViewDelegate
     setMinimumLength:LEFT_VIEW_MINIMUM_WIDTH
     forViewAtIndex:LEFT_VIEW_INDEX];
	[splitViewDelegate
     setPriority:MAIN_VIEW_PRIORITY
     forViewAtIndex:MAIN_VIEW_INDEX];
	[splitViewDelegate
     setMinimumLength:MAIN_VIEW_MINIMUM_WIDTH
     forViewAtIndex:MAIN_VIEW_INDEX];
	
	[splitView setDelegate:splitViewDelegate];
	
    [window center];
    [window makeKeyAndOrderFront: self];
    
    // Trigger the UA App Review Manager

    flipController = [[MCViewFlipController alloc] initWithHostView:hostView frontView:frontView backView:backView];
    
}

-(IBAction)flip:(id)sender
{
    
    [flipController flip:self];
    
    NSPoint pt = NSMakePoint(0.0, [[backScrollView documentView]
                                   bounds].size.height);
    [[backScrollView documentView] scrollPoint:pt];
    
    
    NSPoint pt2 = NSMakePoint(0.0, [[myScrollView documentView]
                                   bounds].size.height);
    [[myScrollView documentView] scrollPoint:pt2];
    
    //We can remove a food unless it is in the library
    FoodList* CurrentFoodList;
    
    NSArray* selectedObjects = [FoodTableView selectedObjects];
    NSLog(@"%@", [selectedObjects objectAtIndex:0]);
    
    NSEntityDescription *entity = [selectedObjects objectAtIndex:0];
    NSLog(@"%@", [entity valueForKey:@"userDefined"]);
    
    
    int user;
    user = (int)[ entity valueForKey:@"userDefined" ];
    
    if ([[ entity valueForKey:@"userDefined" ] doubleValue] == 0) {
        [submitFood setEnabled:NO];
    } else {
        [submitFood setEnabled:YES];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSString*  flipin = [defaults objectForKey:@"flipPref"];
        int flipValue = [flipin doubleValue];
        
        NSInteger integValue = [submitFood state];
        
        
        NSLog(@"Checkbox Status: %ld", (long)integValue);
        NSLog(@"Flip Preference: %d", flipValue);
        
        
        if (flipValue == 1 && integValue == 1) {
            
            [self SendFood:self];
            
            self.progressBar.animates = self.progressBar.animates;
            [self.progressBar.animator setFloatValue:0];
            
            [NSApp beginSheet:SendWindow modalForWindow:window modalDelegate:self didEndSelector:NULL contextInfo:nil];
            
            NSTimer *aTimer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
            
            NSRunLoop *runner = [NSRunLoop currentRunLoop];
            [runner addTimer:aTimer forMode: NSDefaultRunLoopMode];
            
            
            NSTimer *tm=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(closedPanel:) userInfo:nil repeats:NO];
        }

        
        
        
    }
    
    
    
}

- (void)timerFired:(NSTimer*)theTimer
{
    if(!([self.progressBar.animator floatValue] == 1))
    {
        [theTimer isValid]; //recall the NSTimer
        //implement your methods
        
        [self.progressBar.animator setFloatValue:1];
        NSTimer *bTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerHid:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer:bTimer forMode: NSDefaultRunLoopMode];
    }
    else
    {
        [theTimer invalidate]; //stop the NSTimer
        
    }
    
}

- (void)timerHid:(NSTimer*)theTimer
{
    [self.progressBar.animator setFloatValue:0];
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        abort();
    }
    

}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        abort();
    }
    
    
	[splitView setDelegate:nil];
	//[splitViewDelegate release];
}

/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication*)sender
{
    if (!managedObjectContext) return NSTerminateNow;
    
    if (![managedObjectContext commitEditing]) {
        
        return NSTerminateCancel;
    }
    
    if (![managedObjectContext hasChanges]) return NSTerminateNow;
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        BOOL result = [sender presentError:error];
        if (result) return NSTerminateCancel;
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting.  Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        int answer = (int)[alert runModal];
        alert = nil;
        if (answer == NSAlertAlternateReturn) return NSTerminateCancel;
        
    }
    
    return NSTerminateNow;
}


- (IBAction)SendFood:(id)sender {
    
    
    
    NSString *food_name2 = [food_name stringValue];
    double calories2 = [calories doubleValue];
    double protein2 = [protein doubleValue];
    double carbohydrates2 = [carbohydrates doubleValue];
    double dietary_fiber2 = [dietary_fiber doubleValue];
    double sugar2 = [sugar doubleValue];
    double calcium2 = [calcium doubleValue];
    double iron2 = [iron doubleValue];
    double sodium2 = [sodium doubleValue];
    double vitC2 = [vitC doubleValue];
    double vitA2 = [vitA doubleValue];
    double vitE2 = [vitE doubleValue];
    double saturated_fat2 = [saturated_fat doubleValue];
    double monounsaturated_fat2 = [monounsaturated_fat doubleValue];
    double polyunsaturated_fat2 = [polyunsaturated_fat doubleValue];
    double cholesterol2 = [cholesterol doubleValue];
    double gmwt12 = [gmwt1 doubleValue];
    NSString *gmwt_desc12 = [gmwt_desc1 stringValue];
    
    
    if ([self checkInternet]) {
        
        
        
        // Register Reg Code
        
        NSLog(@"web request started");
        NSString *post = [NSString stringWithFormat:@"food_name=%@&calories=%f&protein=%f&carbohydrates=%f&dietary_fiber=%f&sugar=%f&calcium=%f&iron=%f&sodium=%f&vitC=%f&vitA=%f&vitE=%f&saturated_fat=%f&monounsaturated_fat=%f&polyunsaturated_fat=%f&cholesterol=%f&gmwt1=%f&gmwt_desc1=%@", food_name2, calories2, protein2, carbohydrates2, dietary_fiber2, sugar2, calcium2, iron2, sodium2, vitC2, vitA2, vitE2, saturated_fat2, monounsaturated_fat2, polyunsaturated_fat2, cholesterol2, gmwt12, gmwt_desc12];
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
        NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
        
        NSLog(@"Post data: %@", post);
        
        NSMutableURLRequest *request = [NSMutableURLRequest new];
        [request setURL:[NSURL URLWithString:@"http://products.jonbrown.org/tracker/customer_befit.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if(theConnection) {
            webData = [NSMutableData data];
            
            NSLog(@"connection initiated");
        }
        
        
    } else {
        
        NSLog(@"Offline");
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"You need to be online to save custom food entries to the cloud."];
        [alert runModal];
     
    }
}
         
         
         
         
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
     [webData appendData:data];
     NSLog(@"connection received data");
 }
 
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
     NSLog(@"connection received response");
     NSHTTPURLResponse *ne = (NSHTTPURLResponse *)response;
     if([ne statusCode] == 200) {
         NSLog(@"connection state is 200 - all okay");
     } else {
         NSLog(@"connection state is NOT 200");
     }
 }
 
 -(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
     NSLog(@"Conn Err: %@", [error localizedDescription]);
 }
 
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection {
     NSLog(@"Conn finished loading");
//     NSString *html2 = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//     NSLog(@"OUTPUT:: %@", html2);
     
 }


#pragma mark -
#pragma mark NSTableViewDelegate
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn
{
    iTableColumnHeaderCell* cell = nil;
    BOOL ascending;
    NSInteger priority;
    
    for (NSTableColumn* column in [tableView tableColumns]) {
        
        cell  = (iTableColumnHeaderCell*)[column headerCell];
        
        if (column == tableColumn) {
            ascending = [[[arrayController_ sortDescriptors] objectAtIndex:0] ascending];
            priority = 0;
        } else {
            priority = 1;
        }
        
        [cell setSortAscending:ascending priority:priority];
    }
}

#pragma mark -
#pragma mark Printing Variables

- (NSString *)goalPref
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  lbspref = [defaults objectForKey:@"goal-name"];

    return [NSString stringWithFormat: @"%@ / per day", lbspref ];
    //return lbspref;
    
}

- (NSString *)goalsPref
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *lbspref = [defaults objectForKey:@"goals-name"];
    long yourLong = [lbspref longLongValue];
    //NSLog(@"Value of goals: %ld", yourLong);
    
    NSString * lbsString;
    
    if (yourLong == 0) {
        lbsString = @"Loose Weight";
    } else if (yourLong == 1)
    {
        lbsString = @"Gain Weight";
    } else if (yourLong < 0 ) {
        lbsString = @"Undefined";
    } else {
        lbsString = @"Maintain Weight";
    }
    
    return lbsString;
    
}

- (void)windowWillClose:(NSNotification *)aNotification {
    [NSApp terminate:self];
}

- (IBAction)showStore:(id)sender
{
    [NSApp beginSheet:showStore modalForWindow:window modalDelegate:self didEndSelector:NULL contextInfo:nil];
    
}

- (IBAction)hideStore:(id)sender
{
    [showStore orderOut:nil];
    [NSApp endSheet:showStore];
    
}


@end
