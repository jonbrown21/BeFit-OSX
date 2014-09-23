//
//  SearchFieldforLists.m
//  BeFit
//
//  Created by Jon Brown on 11/30/13.
//
//

#import "SearchFieldforLists.h"

@implementation SearchFieldforLists

-(void)awakeFromNib
{
    
    NSMenu *cellMenu = [[NSMenu alloc] initWithTitle:@"Filter Menu"];
    
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
