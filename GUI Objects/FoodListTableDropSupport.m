#import "FoodListTableDropSupport.h"
#import "Food.h"
#import "FoodList.h"
#import "FoodDragSupportBase.h"
#import "GUIController.h"

@implementation FoodListTableDropSupport

//Need to implement data source routines so we include them
- (int)numberOfRowsInTableView:(NSTableView *)aTableView 
   {
    return 0; // return 0 so the table view will fall back to getting data from its binding
   }



- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex 
   {
    return nil;  // return nil so the table view will fall back to getting data from its binding 
   }



- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)operation
   {
   
   //Only allow dropping on lists not between
   if ( operation == NSTableViewDropOn )
      {
      return NSDragOperationCopy;
      }
   else
      {
      return NSDragOperationNone;
      }
   }



- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)operation 
   {
	BOOL success = NO;
   
   NSDictionary *infoForBinding = [tableView infoForBinding:NSContentBinding];

   if (infoForBinding == nil) 
      { return( NO ); }
   
   //Get array of all food lists
   NSArrayController *arrayController = [infoForBinding valueForKey:NSObservedObjectKey];

   //Get our food list
   FoodList* FoodListToModify = [[arrayController arrangedObjects] objectAtIndex:row];

   if ( FoodListToModify == nil )
      { return( NO ); }
      
   //Food list internal set
   NSMutableSet* FoodsSet = [FoodListToModify mutableSetValueForKey:@"foods"];
      
   NSManagedObjectContext *context = [ApplicationDelegate managedObjectContext];

   if ( context == nil )
      { return( NO ); }
     

    // Get object URIs from paste board
    NSData* data = [[info draggingPasteboard] dataForType:FoodDataDragType];
    NSArray* objectURIs = [NSUnarchiver unarchiveObjectWithData:data];
    if (!objectURIs) 
      { return NO; }
    
   NSEnumerator* enumerator = [objectURIs objectEnumerator];

   NSURL* currentObjectURI;

    while (currentObjectURI = [enumerator nextObject]) 
      {
      
      // Get managed object
      NSManagedObjectID* objectID = [[context persistentStoreCoordinator]
                                          managedObjectIDForURIRepresentation:currentObjectURI];

      Food* FoodObjectExtracted = (Food*) [context objectWithID:objectID];
      if ( FoodObjectExtracted == NULL )
         { continue; }
         
      [ FoodsSet addObject: FoodObjectExtracted ];

      success = YES;
        
      }
       
      [self.myTableView reloadData];
   return( success );
       
   }


@end
