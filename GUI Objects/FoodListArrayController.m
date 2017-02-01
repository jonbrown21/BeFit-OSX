#import "FoodListArrayController.h"
#import "FoodList.h"

@implementation FoodListArrayController

-(void)awakeFromNib
   {

       
   //Sorting at startup
   NSSortDescriptor* SortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderIndex" 
                                           ascending:YES selector:@selector(compare:)];
   [self setSortDescriptors:[NSArray arrayWithObject:SortDescriptor]];
   
   //need to initialize the array
   [super awakeFromNib];
   }

-(void)doRemove {
    
}

-(BOOL)libraryIsSelected
   {
   NSArray* CurrentlySelectedFoodLists = [ self selectedObjects ];
   
   NSEnumerator *FoodListEnumerator = [CurrentlySelectedFoodLists objectEnumerator];
   
   //Library is always at order index zero 
   FoodList* CurrentFoodList;
   Boolean LibraryIsSelected = NO;
       
   
   while (CurrentFoodList = [FoodListEnumerator nextObject]) 
      {
      if ( [ [ CurrentFoodList valueForKey: @"orderIndex" ] intValue ] == 0 || [ [ CurrentFoodList valueForKey: @"orderIndex" ] intValue ] == 1 )
         {
         LibraryIsSelected = YES;
         
         }
      }
      
   return( LibraryIsSelected );
   }
   





- (void) reindexEntries
   {

   // Note: use a temporary array since modifying an item in arrangedObjects
   //directly will cause the sort to trigger thus throwing off
   //the re-indexing.

   int count = (int)[[self arrangedObjects] count];

   NSArray *tmpArray = [NSArray arrayWithArray:[self arrangedObjects]];
   
   int Index;

   for(Index = 0; Index < count ; Index++)
      {
      id entry = [tmpArray objectAtIndex:Index];

      [entry setValue:[NSNumber numberWithInt:Index] forKey:@"orderIndex"];
      }
   }
   
   
   
- (void)remove:(id)sender
   {
   if ( ![self libraryIsSelected ] )
      {
          NSBeep();
          NSAlert *alert = [[NSAlert alloc] init];
          [alert addButtonWithTitle:@"Delete"];
          [alert addButtonWithTitle:@"Cancel"];
          [alert setMessageText:@"Do you really want to delete this food list?"];
          [alert setInformativeText:@"Deleting this food list cannot be undone."];
          [alert setAlertStyle:NSWarningAlertStyle];
          [alert setDelegate:self];
          [alert respondsToSelector:@selector(doRemove)];
          [alert beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];

      }
   else
      {
      NSBeep();
      }
   }
   


- (void)insertObject:(id)object atArrangedObjectIndex:(unsigned long)index
   {
   
   [object setValue:[NSNumber numberWithInt:(int)index] forKey:@"orderIndex"];

   [super insertObject:object atArrangedObjectIndex:index];

   [self reindexEntries];
   }




-(void)alertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void*)contextInfo {
    if (returnCode ==  NSAlertFirstButtonReturn) {
        [super remove:self];
         [self reindexEntries];
    }
}

@end
