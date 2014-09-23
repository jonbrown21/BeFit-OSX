//
//  sideFooter.m
//  BeFit
//
//  Created by Jon Brown on 11/30/13.
//
//

#import "sideFooter.h"

@implementation sideFooter

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
    NSImage *pattern = [NSImage imageNamed:@"blueback.png"];
    NSDrawThreePartImage([self bounds], pattern, pattern, pattern, NO,
                         NSCompositeSourceOver, 1, NO);
}


@end
