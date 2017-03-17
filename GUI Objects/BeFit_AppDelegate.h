#import <Cocoa/Cocoa.h>
#import "LNClipView.h"
#import "PreferenceWindow.h"
#import "MCViewFlipController.h"
#import "ITProgressBar.h"
#import "ANSegmentedControl.h"
#import "Food.h"

#ifdef TRIAL
#import <Sparkle/Sparkle.h>
#import <OpenFeedback/OpenFeedback.h>
#elif defined WEBSITE
#import <Sparkle/Sparkle.h>
#import <OpenFeedback/OpenFeedback.h>
#endif

@class PrioritySplitViewDelegate;
@class OpenFeedback;

@interface BeFit_AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDelegate>
{
    IBOutlet id LevelInd;
    IBOutlet id LevelInd2;
    IBOutlet id LevelInd3;
    IBOutlet id LevelInd4;
    IBOutlet id LevelInd5;
    IBOutlet id LevelInd6;
    IBOutlet id LevelInd7;
    IBOutlet id Cals;
    IBOutlet id SaveWindow;
    IBOutlet id SendWindow;
    IBOutlet NSProgressIndicator *myProgress;
    IBOutlet NSWindow *window;
    IBOutlet id SavingLabel;
    IBOutlet NSSplitView *splitView;    
    IBOutlet id isOnline;
    IBOutlet id FoodTableView;
    IBOutlet id submitFood;
    IBOutlet OpenFeedback *openFeedback;
	PrioritySplitViewDelegate *splitViewDelegate;
    ANSegmentedControl *segment;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    IBOutlet id showStore;
    IBOutlet NSArrayController* arrayController_;
    IBOutlet NSTableView* tableView_;
    
    IBOutlet id frontView;
    IBOutlet id backView;
    IBOutlet id hostView;
    MCViewFlipController *flipController;
    
    IBOutlet id backScrollView;
    IBOutlet id myScrollView;
    IBOutlet id PrintView;
    IBOutlet id food_name;
    IBOutlet id calories;
    IBOutlet id protein;
    IBOutlet id carbohydrates;
    IBOutlet id dietary_fiber;
    IBOutlet id sugar;
    IBOutlet id calcium;
    IBOutlet id iron;
    IBOutlet id sodium;
    IBOutlet id vitC;
    IBOutlet id vitA;
    IBOutlet id vitE;
    IBOutlet id saturated_fat;
    IBOutlet id monounsaturated_fat;
    IBOutlet id polyunsaturated_fat;
    IBOutlet id cholesterol;
    IBOutlet id gmwt1;
    IBOutlet id gmwt_desc1;
    NSMutableData *webData;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)flip:(id)sender;
- (IBAction)hideStore:(id)sender;
- (IBAction)showStore:(id)sender;

@property (strong) IBOutlet LNScrollView *CalorieScrollView;
@property (nonatomic) NSInteger focusedAdvancedControlIndex;
@property (assign) IBOutlet ITProgressBar *progressBar;
@property(nonatomic,retain)NSMutableData *webData;
@end
