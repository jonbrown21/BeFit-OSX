//
//  RightGraphView.m
//  BeFit
//
//  Created by Jon Brown on 12/3/13.
//
//

#import "RightGraphView.h"

@implementation RightGraphView


-(void)drawGraphFromFood
{
    
    //Convert the into an Integer
    
    NSString *item1 = [textField stringValue];
    NSString *item2 = [textField2 stringValue];
    NSString *item3 = [textField3 stringValue];
    NSString *item4 = [textField4 stringValue];
    NSString *item5 = [textField5 stringValue];
    NSString *item6 = [textField6 stringValue];
    NSString *item7 = [textField7 stringValue];
    NSString *item8 = [textField8 stringValue];
    NSString *item9 = [textField9 stringValue];

    
    //pass that to webview with javascript
    NSString *javascriptString = [NSString stringWithFormat:@"graphFunction('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", item1, item2, item3, item4, item5, item6, item7, item8, item9];
    
    [self stringByEvaluatingJavaScriptFromString:javascriptString];
    
    
    
}

- (void) drawRect: (NSRect) rect
{
    
    [ self drawGraphFromFood ];
    
    
}

- (void)awakeFromNib
{
    
    [FoodListArrayController addObserver:self forKeyPath:@"selection"
                          options: NSKeyValueObservingOptionNew  context:NULL];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqual:@"selection"])
    {
        [ self setNeedsDisplay: YES ];
    }
}

@end
