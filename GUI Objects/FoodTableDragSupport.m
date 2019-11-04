#import "FoodTableDragSupport.h"
#import "FoodDragSupportBase.h"
#import "BeFit-Swift.h"

@implementation FoodTableDragSupport

//Need to implement data source routines so we include them
- (int)numberOfRowsInTableView:(NSTableView *)aTableView 
{
	mDisplayedTableView = aTableView;
	return 0; // return 0 so the table view will fall back to getting data from its binding
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex 
{
	return nil;  // return nil so the table view will fall back to getting data from its binding 
}

- (NSTableView *)currentlyDisplayedTableView
{
	return mDisplayedTableView;
}

- (BOOL)tableView:(NSTableView*)tableView 
        writeRows:(NSArray*)rows 
        toPasteboard:(NSPasteboard*)pboard
{
    // Get array controller
    NSDictionary*       bindingInfo;
    NSArrayController*  arrayController;
    bindingInfo = [tableView infoForBinding:NSContentBinding];
    arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    // Get arranged objects, they are managed object
    NSArray*    arrangedObjects;
    arrangedObjects = [arrayController arrangedObjects];
    
    // Collect URI representation of managed objects
    NSMutableArray* objectURIs;
    NSEnumerator*   enumerator;
    NSNumber*       rowNumber;
    objectURIs = [NSMutableArray array];
    enumerator = [rows objectEnumerator];
    while (rowNumber = [enumerator nextObject]) {
        int row;
        row = [rowNumber intValue];
        if (row >= [arrangedObjects count]) {
            continue;
        }
        
        // Get URI representation of managed object
        NSManagedObject*    object;
        NSManagedObjectID*  objectID;
        NSURL*              objectURI;
        object = [arrangedObjects objectAtIndex:row];
        objectID = [object objectID];
        objectURI = [objectID URIRepresentation];
        
        [objectURIs addObject:objectURI];
    }
    
    // Set them to paste board
    [pboard declareTypes:[NSArray arrayWithObject:FoodDataDragType] owner:nil];
    [pboard setData:[NSArchiver archivedDataWithRootObject:objectURIs] forType:FoodDataDragType];
    
    return YES;
}

@end
