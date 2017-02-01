/* FoodListTableDropSupport */

#import <Cocoa/Cocoa.h>

@interface FoodListTableDropSupport : NSObject
{
    IBOutlet id ApplicationDelegate;
}
@property (nonatomic, strong) IBOutlet NSTableView *myTableView;
@end
