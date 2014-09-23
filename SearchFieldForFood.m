#import "SearchFieldForFood.h"

@implementation SearchFieldForFood

-(void)awakeFromNib
   {
//   NSMenu *cellMenu = [[[NSMenu alloc] initWithTitle:@"Search Menu"] autorelease];
//
//   NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:@"Recent Searches"
//                        action:NULL keyEquivalent:@""] autorelease];
//
//   [item setTag:NSSearchFieldRecentsTitleMenuItemTag];
//
//   [cellMenu insertItem:item atIndex:0];
//
//   [[self cell] setSearchMenuTemplate:cellMenu];

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
