/* FoodNSTableView */

#import <Cocoa/Cocoa.h>

@interface FoodNSTableView : NSTableView
{
    IBOutlet id FoodController;
    IBOutlet id FoodListController;
    IBOutlet id submitFoods;
    IBOutlet id cell;
	IBOutlet NSTextField * mItemsCaloriesLabel;
}
@end
