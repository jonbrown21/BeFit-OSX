//
//  PrefSetter.m
//  BeFit
//
//  Created by Jon Brown on 1/5/14.
//
//

#import "PrefSetter.h"

@implementation PrefSetter

-(void)awakeFromNib
{
    [prefslider setTarget:self]; // assume the handler is [self sliderDidMove:]
    [prefslider setAction:@selector(sliderDidMove:)];

    NSNumberFormatter *slidervalueFormatter = [[NSNumberFormatter alloc] init];
    [slidervalueFormatter setFormat: @"#,###;0;(#,##0)"];
    [[sliderValueLabel cell] setFormatter:slidervalueFormatter];

    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  goalPrefs = [defaults objectForKey:@"goal-name"];
    
    // Read default prefrences for member name
    if (goalPrefs == (id)[NSNull null] || goalPrefs.length == 0 ) {
        
        [prefslider setStringValue:@"2000"];
        [sliderValueLabel setStringValue:@"2000"];
        
    } else {
        
        [prefslider setStringValue:goalPrefs];
        [sliderValueLabel setStringValue:goalPrefs];
    }
    
}

- (IBAction)sliderDidMove:(id)sender {
    
    NSSlider *slider = sender;
    double textValue = [slider doubleValue];
    [sliderValueLabel setDoubleValue:textValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *sliderPreferenceValue = [prefslider stringValue];
    
    if (sender == prefslider)
    {
        [defaults setObject:sliderPreferenceValue forKey:@"goal-name"];
        
    }
    
}

@end
