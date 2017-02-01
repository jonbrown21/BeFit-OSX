//
//  whiteBackground.m
//  BeFit
//
//  Created by Jon Brown on 11/10/14.
//
//

#import "whiteBackground.h"

@implementation whiteBackground

- (void)drawRect:(NSRect)dirtyRect {
    
    
    NSColor *backColor = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0f];
    
    [backColor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}


@end
