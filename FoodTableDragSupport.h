/* FoodTableDragSupport */

#import <Cocoa/Cocoa.h>

@interface FoodTableDragSupport : NSObject
{
	NSTableView *mDisplayedTableView;
}

- (NSTableView *)currentlyDisplayedTableView;

@end
