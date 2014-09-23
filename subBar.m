//
//  subBar.m
//  BeFit
//
//  Created by Jon Brown on 11/29/13.
//
//

#import "subBar.h"

@implementation subBar

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSImage *pattern = [NSImage imageNamed:@"subbar.png"];
    NSDrawThreePartImage([self bounds], pattern, pattern, pattern, NO,
                         NSCompositeSourceOver, 1, NO);
}

@end
