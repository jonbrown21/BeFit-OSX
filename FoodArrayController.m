#import "FoodArrayController.h"
#import "FoodNSTableView.h"
#import "Food.h"
#import "BeFit_AppDelegate.h"

@implementation FoodArrayController

-(void)awakeFromNib
{
    

    
    
	//Sorting at startup
	NSSortDescriptor* SortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" 
										   ascending:YES selector:@selector(compare:)];
	[self setSortDescriptors:[NSArray arrayWithObject:SortDescriptor]];

	[mPopupButton setHidden: YES];
	//need to initialize the array
	[super awakeFromNib];
}


-(void)remove:(id)sender {
    NSBeep();
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Delete"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Do you really want to delete this food item?"];
    [alert setInformativeText:@"Deleting this food item cannot be undone."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert setDelegate:self];
    [alert respondsToSelector:@selector(doRemove)];
    [alert beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

-(void)alertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void*)contextInfo {
    if (returnCode ==  NSAlertFirstButtonReturn) {
        // We want to remove the saved image along with the bug
        FoodNSTableView *bug = [[self selectedObjects] objectAtIndex:0];
        NSString *name = [bug valueForKey:@"name"];
        [super remove:self];
    }
}

-(void) add:(id)sender {
    
    BeFit_AppDelegate* flipMethod = (BeFit_AppDelegate*)[[NSApplication sharedApplication]delegate];
    
    NSManagedObject *newItem = [self newObject];
    //do object set up here...
    [self addObject:newItem];
    
    [flipMethod flip:self];
    
    
}

- (int) selectionIndex
{
	int		index;
	
	index = [ super selectionIndex ];
	// NSLog( [ NSString stringWithFormat: @"selectionIndex is %d", index ] );
	return index;
}

- (BOOL) setSelectedObjects: (NSArray *) objects
{
	BOOL okay;
	
	// NSLog( [ NSString stringWithFormat: @"selectionObjects is %lu", (unsigned long)[ objects count ]] );
	okay = [ super setSelectedObjects: objects ];
	return okay;
}

- (BOOL) setSelectionIndex: (int) index
{
	BOOL okay;
	
	// NSLog( [ NSString stringWithFormat: @"selectionIndex is %d", index ] );
	okay = [ super setSelectionIndex: index ];
	return okay;
}

- (void) updateTableEntry
{
	FoodNSTableView * tableView;
	NSIndexSet * selectedRows;
	int firstSelectedRow;
	
	tableView = (FoodNSTableView *) [ mDragSupport currentlyDisplayedTableView ];
	if( NULL != tableView )
	{
		selectedRows = [ tableView selectedRowIndexes ];
		if(( NULL != selectedRows ) && ( [ selectedRows count ] > 0 ))
		{
			firstSelectedRow = [ selectedRows firstIndex ];
			
			/* now we know what row is selected, let's reload the data for this row*/
			[tableView setNeedsDisplayInRect:[tableView rectOfRow:firstSelectedRow]];
			[tableView textDidEndEditing: NULL];
            
		}
	}
}

- (IBAction) servingSizeChanged:(id) sender
{
    FoodNSTableView * tableView;
	NSArray * selectedObjects;
	Food * food;
	int indexOfSelectedItem;
	int formerIndex;
    tableView = (FoodNSTableView *) [ mDragSupport currentlyDisplayedTableView ];
    
	if( sender == mPopupButton )
	{
		selectedObjects = [ self selectedObjects ];
		food = [ selectedObjects objectAtIndex: 0 ];
		formerIndex = [ food indexOfServingBeingDisplayed ];
		indexOfSelectedItem = [ mPopupButton indexOfSelectedItem ];
		if( indexOfSelectedItem != formerIndex )
		{
			[ food setIndexOfServingBeingDisplayed: indexOfSelectedItem ];
			[ mAmountPerServingField setStringValue: [ food servingAmountValue ]];
			[ mCaloriesField setStringValue: [ NSString stringWithFormat: @"%ld", [ food caloriesLongValue ]]];
			[ mCaloriesFromFatField setStringValue: [ food caloriesFromFatValue ]];
			[ mTotalFatField setStringValue: [ food totalFatValue ]];
			[ mSaturatedFatField setStringValue: [ food saturatedFatValue ]];
			[ mSaturatedFatPercentageField setStringValue: [ food saturatedFatPercent ]];
			[ mCholesterolField setStringValue: [ food cholesterolValue ]];
			[ mCholesterolPercentageField setStringValue: [ food cholesterolPercent ]];
			[ mSodiumField setStringValue: [ food sodiumValue ]];
			[ mSodiumPercentageField setStringValue: [ food sodiumPercent ]];
			[ mTotalCarbohydrateField setStringValue: [ food carbsValue ]];
			[ mTotalCarbPercentageField setStringValue: [ food carbsPercent ]];
			[ mDietaryFiberField setStringValue: [ food dietaryFiberValue ]];
			[ mDietaryFiberPercentageField setStringValue: [ food dietaryFiberPercent ]];
			[ mSugarField setStringValue: [ food sugarsValue ]];
			[ mProteinField setStringValue: [ food proteinValue ]];
			[ self updateTableEntry ];
            

		}
	}
}

- (BOOL)setSelectionIndexes:(NSIndexSet *)indexes
{
	BOOL okay;
	int firstIndex;
	NSArray *selectedObjects;
	NSString * servingAmountValue;
	Food * food;
	
	okay = [ super setSelectionIndexes: indexes ];
	
	if( [ indexes count ] == 1 )
	{
		firstIndex = [ indexes firstIndex ];
		
		if( mPopupButton )
		{			
			[ mPopupButton removeAllItems ];
			selectedObjects = [ self selectedObjects ];
			food = [ selectedObjects objectAtIndex: 0 ];
			servingAmountValue = [ food servingAmount1Value ];
			if(( NULL != servingAmountValue ) && ( [ servingAmountValue length ] > 1 ))
			{
				[mPopupButton setHidden: NO];
			
				[ mPopupButton addItemWithTitle: servingAmountValue ];
				servingAmountValue = [ food servingAmount2Value ];
				if(( NULL != servingAmountValue ) && ( [ servingAmountValue length ] > 1 ))
					[ mPopupButton addItemWithTitle: servingAmountValue];
				[ mPopupButton selectItemAtIndex: [ food indexOfServingBeingDisplayed ]];
			} else {
				[mPopupButton setHidden: YES];
			}
		}
	}
	
	return okay;
}

@end
