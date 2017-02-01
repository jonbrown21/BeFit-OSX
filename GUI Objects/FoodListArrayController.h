/* FoodListArrayController */

#import <Cocoa/Cocoa.h>

@interface FoodListArrayController : NSArrayController <NSAlertDelegate>
{
    IBOutlet id addFood;
}

-(BOOL)libraryIsSelected;
-(void)doRemove;

@end
