#import "FoodListNSTableView.h"
#import "FoodDragSupportBase.h"

@implementation FoodListNSTableView

    -(void)awakeFromNib
    {
    //Register for drag operations
    [ self registerForDraggedTypes: [ NSArray arrayWithObject: FoodDataDragType ] ];

    }

    - (void)DeleteSelectedObjectInTableView:(id)sender
    {
    [ FoodListController remove: sender ];

    //This was just for testing other row heights can be removed
    //[ self setRowHeight: [ self rowHeight ] + 1 ];
    }



//- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
//{
//    NSLog(@"row =%ld",row);
//    JBDCustomRow *rowView = [[JBDCustomRow alloc]init];
//    return rowView;
//}

@end

