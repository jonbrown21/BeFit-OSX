//
//  AMDarkButton.m
//  Button
//
//  Created by ampatspell on 5/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDarkButtonCell.h"


@implementation AMDarkButtonCell

- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView
{
    NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
    CGContextRef contextRef = [ctx graphicsPort];
    
    NSData *data = [image TIFFRepresentation];
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if(source) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
        CFRelease(source);
        
        CGContextSaveGState(contextRef);
        {
            NSRect rect = NSOffsetRect(frame, 0.0f, 1.0f);
            CGFloat white = [self isHighlighted] ? 0.2f : 0.35f;
            CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
            [[NSColor colorWithDeviceWhite:white alpha:1.0f] setFill];
            NSRectFill(rect);
        } 
        CGContextRestoreGState(contextRef);
        
        CGContextSaveGState(contextRef);
        {
            NSRect rect = frame;
            CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
            [[NSColor colorWithDeviceWhite:0.1f alpha:1.0f] setFill];
            NSRectFill(rect);
        } 
        CGContextRestoreGState(contextRef);        
                
        CFRelease(imageRef);
    }
}


- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
    
    CGFloat roundedRadius = 3.0f;
    
    BOOL outer = NO;
    BOOL background = NO;
    BOOL stroke = YES;
    BOOL innerStroke = NO;
    
    if(outer) {
        [ctx saveGraphicsState];
        NSBezierPath *outerClip = [NSBezierPath bezierPathWithRoundedRect:frame xRadius:roundedRadius yRadius:roundedRadius];
        [outerClip setClip];

        NSGradient *outerGradient = [[NSGradient alloc] initWithColorsAndLocations:
                                     [NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.0f, 
                                     [NSColor colorWithDeviceWhite:0.21f alpha:1.0f], 1.0f, 
                                     nil];
        
        [outerGradient drawInRect:[outerClip bounds] angle:90.0f];
        [ctx restoreGraphicsState];
    }
     
    if(background) {
        [ctx saveGraphicsState];
        NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.0f, 2.0f) xRadius:roundedRadius yRadius:roundedRadius];
        [backgroundPath setClip];
        
        NSGradient *backgroundGradient = [[NSGradient alloc] initWithColorsAndLocations:
                                          [NSColor colorWithDeviceWhite:0.17f alpha:1.0f], 0.0f, 
                                          [NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.12f, 
                                          [NSColor colorWithDeviceWhite:0.27f alpha:1.0f], 0.5f, 
                                          [NSColor colorWithDeviceWhite:0.30f alpha:1.0f], 0.5f, 
                                          [NSColor colorWithDeviceWhite:0.42f alpha:1.0f], 0.98f, 
                                          [NSColor colorWithDeviceWhite:0.50f alpha:1.0f], 1.0f, 
                                          nil];
        
        [backgroundGradient drawInRect:[backgroundPath bounds] angle:270.0f];
        [ctx restoreGraphicsState];
    }
    
    if(stroke) {
        [ctx saveGraphicsState];
        [[NSColor colorWithDeviceWhite:0.5f alpha:1.0f] setStroke];
        [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 1.5f, 1.5f) xRadius:roundedRadius yRadius:roundedRadius] stroke];
        [ctx restoreGraphicsState];
    }
    
    if(innerStroke) {
        [ctx saveGraphicsState];
        [[NSColor colorWithDeviceWhite:1.0f alpha:0.05f] setStroke];
        [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.5f, 2.5f) xRadius:roundedRadius yRadius:roundedRadius] stroke];
        [ctx restoreGraphicsState];        
    }
    
    if([self isHighlighted]) {
        [ctx saveGraphicsState];
        [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.0f, 2.0f) xRadius:roundedRadius yRadius:roundedRadius] setClip];
        [[NSColor colorWithCalibratedWhite:0.0f alpha:0.35] setFill];
        NSRectFillUsingOperation(frame, NSCompositeSourceOver);
        [ctx restoreGraphicsState];
    }
}

@end
