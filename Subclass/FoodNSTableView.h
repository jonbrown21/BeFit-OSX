/* FoodNSTableView */

#import <Cocoa/Cocoa.h>

@interface FoodNSTableView : NSTableView
{
    IBOutlet id FoodController;
    IBOutlet id FoodListController;
    IBOutlet id window;
    IBOutlet id myView;

}
@property (nonatomic, strong) IBOutlet NSTableView *myTableView;
@end
