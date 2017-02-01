//
//  CustomLevelIndicatorCell.m
//  BeFit
//
//  Created by Jon Brown on 11/19/14.
//
//

#import "CustomLevelIndicatorCell.h"

@implementation CustomLevelIndicatorCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    
    double level = (self.floatValue - self.minValue)/(self.maxValue- self.minValue);
    if (level > 1.0){level = 1.0;}
    //NSLog(@"Level: %a", level);
    
    NSColor *GreenColor = [NSColor colorWithCalibratedRed:0.152 green:0.682 blue:0.37 alpha:1.0f];
    NSColor *YellowColor = [NSColor colorWithCalibratedRed:0.411 green:0.643 blue:0.796 alpha:1.0f];
    NSColor *RedColor = [NSColor colorWithCalibratedRed:0.752 green:0.233 blue:0.164 alpha:1.0f];
    
    NSColor *fillColor;
    if(self.floatValue > self.criticalValue)
        fillColor = RedColor;
    else if(self.floatValue > self.warningValue)
        fillColor = YellowColor;
    else
        fillColor = GreenColor;
    
    //NSLog(@"Level: %a", self.criticalValue);
    
    NSRect levelRect = NSInsetRect(cellFrame, 2, 1);
    levelRect.size.width = levelRect.size.width * level;
    NSBezierPath * levelPath = [NSBezierPath bezierPathWithRoundedRect:levelRect xRadius:3 yRadius:3];
    [fillColor setFill];
    [levelPath fill];
    NSBezierPath * indicatorPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(cellFrame, 2, 1) xRadius:3 yRadius:3];
    [indicatorPath setLineWidth:0.15];
    [[NSColor grayColor] setStroke];
    [indicatorPath stroke];
    
}

@end
