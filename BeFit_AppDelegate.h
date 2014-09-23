#import <Cocoa/Cocoa.h>
#import "LNClipView.h"
#import "PreferenceWindow.h"
#import "MCViewFlipController.h"
#import "ITProgressBar.h"

#ifdef TRIAL
#import <Sparkle/Sparkle.h>
#import <OpenFeedback/OpenFeedback.h>
#elif defined WEBSITE
#import <Sparkle/Sparkle.h>
#import <OpenFeedback/OpenFeedback.h>
#endif

@class PrioritySplitViewDelegate;
@class OpenFeedback;

@interface BeFit_AppDelegate : NSObject <NSApplicationDelegate>
{
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

    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    
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

@property (strong) IBOutlet LNScrollView *CalorieScrollView;
@property (nonatomic) NSInteger focusedAdvancedControlIndex;
@property (assign) IBOutlet ITProgressBar *progressBar;
@property(nonatomic,retain)NSMutableData *webData;


@end
