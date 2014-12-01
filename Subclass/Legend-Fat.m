//
//  Legend-Fat.m
//  BeFit
//
//  Created by Jon Brown on 11/9/14.
//
//

#import "Legend-Fat.h"

@implementation Legend_Fat

- (void)drawRect:(NSRect)dirtyRect {
    // Get the graphics context that we are currently executing under
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    
    // Save the current graphics context settings
    [gc saveGraphicsState];
    
    // Set the color in the current graphics context for future draw operations
    NSColor *CalColor = [NSColor colorWithCalibratedRed:0.17 green:0.61 blue:0.41 alpha:1.0f];
    
    [CalColor setStroke];
    [CalColor setFill];
    
    // Create our circle path
    NSRect rect = NSMakeRect(5, 5, 5, 5);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
}

@end
