/* FoodArrayController */

#import <Cocoa/Cocoa.h>
#import "FoodTableDragSupport.h"

@interface FoodArrayController : NSArrayController <NSAlertDelegate>
{
	IBOutlet	NSPopUpButton			*mPopupButton;
	IBOutlet	NSTextField				*mCaloriesField;
	IBOutlet	NSTextField				*mCaloriesFromFatField;
	IBOutlet	NSTextField				*mTotalFatField;
	IBOutlet	NSTextField				*mTotalFatPercentageField;
	IBOutlet	NSTextField				*mSaturatedFatField;
	IBOutlet	NSTextField				*mSaturatedFatPercentageField;
	IBOutlet	NSTextField				*mCholesterolField;
	IBOutlet	NSTextField				*mCholesterolPercentageField;
	IBOutlet	NSTextField				*mSodiumField;
	IBOutlet	NSTextField				*mSodiumPercentageField;
	IBOutlet	NSTextField				*mTotalCarbohydrateField;
	IBOutlet	NSTextField				*mTotalCarbPercentageField;
	IBOutlet	NSTextField				*mDietaryFiberField;
	IBOutlet	NSTextField				*mDietaryFiberPercentageField;
	IBOutlet	NSTextField				*mSugarField;
	IBOutlet	NSTextField				*mProteinField;
	IBOutlet	NSTextField				*mAmountPerServingField;
	IBOutlet	FoodTableDragSupport	*mDragSupport;
}

- (int) selectionIndex;
- (BOOL) setSelectedObjects: (NSArray *) objects;
- (BOOL) setSelectionIndex: (int) index;
- (IBAction) servingSizeChanged:(id) sender;

@end
