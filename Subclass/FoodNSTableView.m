#import "FoodNSTableView.h"
#import "FoodDragSupportBase.h"
#import "FoodListArrayController.h"
#import "iTableColumnHeaderCell.h"
#import "CustomCornerView.h"
#import "BeFit-Swift.h"

@implementation FoodNSTableView

- (void)_setupHeaderCell
{
    for (NSTableColumn* column in [self tableColumns]) {
        NSTableHeaderCell* cell = [column headerCell];
        iTableColumnHeaderCell* newCell = [[iTableColumnHeaderCell alloc] initWithCell:cell];
        [column setHeaderCell:newCell];
    }
    
}

- (void)_setupCornerView
{
    NSView* cornerView = [self cornerView];
    CustomCornerView* newCornerView =
    [[CustomCornerView alloc] initWithFrame:cornerView.frame];
    [self setCornerView:newCornerView];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _setupHeaderCell];
        [self _setupCornerView];
    }
    return self;
}



// Register for drag operations

    -(void)awakeFromNib
    {
        
    [self registerForDraggedTypes:[NSArray arrayWithObject: FoodDataDragType]];

    }

// Draw the flat color selection of the NSTableView

    - (void)highlightSelectionInClipRect:(NSRect)theClipRect
    {

    // this method is asking us to draw the hightlights for
    // all of the selected rows that are visible inside theClipRect

    // 1. get the range of row indexes that are currently visible
    // 2. get a list of selected rows
    // 3. iterate over the visible rows and if their index is selected
    // 4. draw our custom highlight in the rect of that row.

    NSRange aVisibleRowIndexes = [self rowsInRect:theClipRect];
    NSIndexSet* aSelectedRowIndexes = [self selectedRowIndexes];
    long aRow = aVisibleRowIndexes.location;
    long anEndRow = aRow + aVisibleRowIndexes.length;
    NSGradient* gradient;
    NSColor* pathColor;

    // if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
    if (self == [[self window] firstResponder] && [[self window] isMainWindow] && [[self window] isKeyWindow])
    {

    gradient = [[NSGradient alloc] initWithColorsAndLocations:
             [NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0], 0.0,
             [NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0], 1.0, nil];

    pathColor = [NSColor colorWithDeviceRed:(float)128/255 green:(float)157/255 blue:(float)194/255 alpha:1.0];

    }
    else
    {

    gradient = [[NSGradient alloc] initWithColorsAndLocations:
             [NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0], 0.0,
             [NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0], 1.0, nil]; //160 80

    pathColor = [NSColor colorWithDeviceRed:(float)186/255 green:(float)192/255 blue:(float)203/255 alpha:1.0];

    }

// draw highlight for the visible, selected rows

    for (aRow; aRow < anEndRow; aRow++) {

    if([aSelectedRowIndexes containsIndex:aRow])
    {
    NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 0, 0); //first is horizontal, second is vertical
    NSBezierPath * path = [NSBezierPath bezierPathWithRect:aRowRect]; //6.0

    [gradient drawInBezierPath:path angle:90];

    }
    }

    }

// we need to override this to return nil
// or we'll see the default selection rectangle when the app is running
// in any OS before leopard

// you can also return a color if you simply want to change the table's default selection color

    - (id)_highlightColorForCell:(NSCell *)cell
    {
    return nil;
    }


// Dont let people delete stuff that shouldnt be deleted.

    - (void)DeleteSelectedObjectInTableView:(id)sender
    {

    NSArray* CurrentlySelectedFoodLists = [ FoodListController selectedObjects ];
    NSEnumerator *FoodListEnumerator = [CurrentlySelectedFoodLists objectEnumerator];

    //We can remove a food unless it is in the library   
    FoodList* CurrentFoodList;

    NSArray* selectedObjects = [FoodController selectedObjects];
    NSLog(@"%@", [selectedObjects objectAtIndex:0]);

    NSEntityDescription *entity = [selectedObjects objectAtIndex:0];
    NSLog(@"%@", [entity valueForKey:@"userDefined"]);

    Boolean FoodsCanBeRemoved = YES;

    
        
    int user = [[entity valueForKey:@"userDefined"] intValue];
    

    while (CurrentFoodList = [FoodListEnumerator nextObject])
    {
    if ( [ [ CurrentFoodList valueForKey: @"orderIndex" ] intValue ] == 0 )
    {

         if ([[ entity valueForKey:@"userDefined" ] intValue] == 0) {
             FoodsCanBeRemoved = NO;
         }
    }

    }

    if ( FoodsCanBeRemoved )
    {
    [FoodController remove:sender];
    }
    else
    {
    NSBeep();
    }
    }


    - (void)textDidEndEditing:(NSNotification *)aNotification
    {
    NSArray * currentlySelectedFoodLists = [ FoodListController selectedObjects ];
    FoodList * currentFoodList;

    if(( NULL != currentlySelectedFoodLists ) && ( [ currentlySelectedFoodLists count ] > 0 ))
    {
    currentFoodList = [ currentlySelectedFoodLists objectAtIndex: 0 ];
    }
        [self.myTableView reloadData];
    }


@end
