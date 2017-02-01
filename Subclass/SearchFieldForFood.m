#import "SearchFieldForFood.h"

@implementation SearchFieldForFood

-(void)awakeFromNib
   {

    NSMenu *cellMenu = [[NSMenu alloc] initWithTitle:@"Search Menu"];

    NSMenuItem *item;

    item = [[NSMenuItem alloc] initWithTitle:@"Recents"

                                action:NULL

                                keyEquivalent:@""];

    [item setTag:NSSearchFieldRecentsMenuItemTag];

    [cellMenu insertItem:item atIndex:0];

    id searchCell = [self cell];

    [searchCell setSearchMenuTemplate:cellMenu];

   }
   
@end
