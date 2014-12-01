//
//  sideFooter.m
//  BeFit
//
//  Created by Jon Brown on 11/30/13.
//
//

#import "sideFooter.h"
#import <QuartzCore/QuartzCore.h>

@implementation sideFooter

- (void)drawRect:(NSRect)dirtyRect {
    
    
//    NSColor *backColor = [NSColor colorWithCalibratedRed:0.80 green:0.83 blue:0.86 alpha:1.0f];
//    
//    [backColor setFill];
//    NSRectFill(dirtyRect);
//    [super drawRect:dirtyRect];
    
    
    CALayer *backgroundLayer = [CALayer layer];
    [backgroundLayer setBackgroundColor:CGColorCreateGenericRGB(0.80, 0.83, 0.86, 1.0f)]; //RGB plus Alpha Channel
    
    
    [self setLayer:backgroundLayer];
    [self setWantsLayer:YES];
    }

@end
