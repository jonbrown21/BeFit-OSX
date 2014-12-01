//
//  subBar.m
//  BeFit
//
//  Created by Jon Brown on 11/29/13.
//
//

#import "subBar.h"

@implementation subBar

    - (void)setLineColor:(NSColor *)color {
    if (color != lineColor) {
        NSColor *myColor = [NSColor colorWithCalibratedRed:0.42 green:0.42 blue:0.42 alpha:1.0f];
        lineColor = myColor;
        [self setNeedsDisplay:YES]; /// We changed what we'd draw, invalidate our drawing.
        }
    }

    - (void)mouseDown:(NSEvent *)mouseDown {
    clickCount = (clickCount == 6) ? 0 : (clickCount + 1);
    CGFloat hue = clickCount / 6.0;
    [self setLineColor:[NSColor colorWithCalibratedHue:hue saturation:1.0 brightness:1.0 alpha:1.0]];
    }

    - (void)drawRect:(NSRect)dirtyRect {
    NSRect wholeRect = [self bounds];
    NSColor *myColor = [NSColor colorWithCalibratedRed:0.42 green:0.42 blue:0.42 alpha:1.0f];

    NSBezierPath *line = [NSBezierPath bezierPath];
    [line moveToPoint:NSMakePoint(0, wholeRect.size.height)];
    [line lineToPoint:NSMakePoint(wholeRect.size.width, wholeRect.size.height)];
    [line setLineWidth:1.0]; /// Make it easy to see
    [myColor set]; /// Make future drawing the color of lineColor.
    [line stroke];
    }

@end
