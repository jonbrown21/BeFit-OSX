//
//  RightGraphView.m
//  BeFit
//
//  Created by Jon Brown on 12/3/13.
//
//

#import "RightGraphView.h"

@implementation RightGraphView

    - (void)awakeFromNib
    {
    [FoodListArrayController addObserver:self forKeyPath:@"selection"
                         options: NSKeyValueObservingOptionNew  context:NULL];

    }

    -(void)drawGraphFromFood
    {
    //Convert the into an Integer

    NSString *item1 = [textField stringValue]; // Name of Food
    NSString *item2 = [textField2 stringValue]; // Calories
    NSString *item3 = [textField3 stringValue]; // Total Fat
    NSString *item4 = [textField4 stringValue]; // Saturated Fat
    NSString *item5 = [textField5 stringValue]; // Cholesterol
    NSString *item6 = [textField6 stringValue]; // Sodium
    NSString *item7 = [textField7 stringValue]; // Dietary Fiber
    NSString *item8 = [textField8 stringValue]; // Sugars
    NSString *item9 = [textField9 stringValue]; // Protein
    NSString *item10 = [textField10 stringValue]; // Carbs
    NSString *item11 = [textField11 stringValue]; // Vitamin C
    NSString *item12 = [textField12 stringValue]; // Iron %
    NSString *item13 = [textField13 stringValue]; // Calcium %
    NSString *item14 = [textField14 stringValue]; // Protein %
    NSString *item15 = [textField15 stringValue]; // Vitamin E
    NSString *item16 = [textField16 stringValue]; // Monounsaturated Fat
    NSString *item17 = [textField17 stringValue]; // Polyunsaturated Fat
    NSString *item18 = [textField18 stringValue]; // Fat from Cals
    NSString *item19 = [textField19 stringValue]; // Iron
    NSString *item20 = [textField20 stringValue]; // Calcium
    NSString *item21 = [textField21 stringValue]; // Protein
    NSString *item22 = [textField22 stringValue]; // Vitamin A
    NSString *item23 = [textField23 stringValue]; // Cal %
    NSString *item24 = [textField24 stringValue]; // Trans Fat
    NSString *item25 = [textField25 stringValue]; // Rating
    NSString *item26 = [textField26 stringValue]; // PintCats
        
    NSString *calfromfat = [CalFromFat stringValue];
    NSString *carbsperc = [CarbsPerc stringValue];
        
//        if ([item24 doubleValue] < 0) {
//            item24 = @"1";
//        } else if ([item24 doubleValue] == 0) {
//            item24 = @"1";
//        }
        
    //pass that to webview with javascript
    NSString *javascriptString = [NSString stringWithFormat:@"graphFunction('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item16, item17, item18, item19, item20, item11, item22, item15];
        
    NSString *javascriptStringCal = [NSString stringWithFormat:@"graphFunctionDCal('%@', '%@', '%@','%@','%@')", item2, item3, item4, item5, item23];
        
    NSString *javascriptStringCalPrint = [NSString stringWithFormat:@"graphFunctionDCalPrint('%@', '%@', '%@','%@','%@')", item2, item3, item4, item5, item23];
        
    NSString *javascriptStringCarb = [NSString stringWithFormat:@"graphFunctionDCarb('%@', '%@', '%@','%@','%@')", item6, item7, item10, item8, carbsperc];
        
    NSString *javascriptStringVit = [NSString stringWithFormat:@"graphFunctionDVit('%@', '%@', '%@','%@','%@')", item11, item9, item12, item13, item14];
    
    NSString *javascriptStringFull = [NSString stringWithFormat:@"updateGage(%@)", item25];
    NSString *javascriptStringFullTxt = [NSString stringWithFormat:@"changeTxt('%@')", item26];
        
        
    //NSLog(@"%@", javascriptStringFull);
        
    [self stringByEvaluatingJavaScriptFromString:javascriptString];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringFull];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringFullTxt];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringCal];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringCalPrint];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringCarb];
    [self stringByEvaluatingJavaScriptFromString:javascriptStringVit];
    }

    - (void) drawRect: (NSRect) rect
    {
    [ self drawGraphFromFood ];
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
