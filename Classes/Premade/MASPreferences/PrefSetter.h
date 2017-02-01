//
//  PrefSetter.h
//  BeFit
//
//  Created by Jon Brown on 1/5/14.
//
//

#import <Foundation/Foundation.h>

@interface PrefSetter : NSObject <NSApplicationDelegate>
{
    IBOutlet id prefslider;
    IBOutlet id sliderValueLabel;
}

@property (nonatomic, retain) NSString *textValue;

@end
