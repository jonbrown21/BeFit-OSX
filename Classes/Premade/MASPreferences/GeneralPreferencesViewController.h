//
// This is a sample General preference pane
//

#import "MASPreferencesViewController.h"

@interface GeneralPreferencesViewController : NSViewController <MASPreferencesViewController>
{
    IBOutlet id lbsName;
    IBOutlet id feetname;
    IBOutlet id inchname;
    IBOutlet id kgname;
    IBOutlet id cmname;
    IBOutlet id agename;
    IBOutlet id gendername;
    IBOutlet id prefslider;
    IBOutlet id sliderValueLabel;
    IBOutlet id gendercheck;
    IBOutlet id metricheck;
    IBOutlet id bmiValue;
    IBOutlet id weightGoals;
    IBOutlet id lifeStyle;
    IBOutlet id Answer;
    IBOutlet id Recomend;
    IBOutlet id formattedSliderValue;
    
}

- (IBAction)setWeightLBS:(id)sender;
- (IBAction)setFeet:(id)sender;
- (IBAction)setInches:(id)sender;

- (IBAction)setKG:(id)sender;
- (IBAction)setCM:(id)sender;
- (IBAction)setAge:(id)sender;
- (IBAction)setMetric:(id)sender;

- (IBAction)setGoals:(id)sender;
- (IBAction)setLifestyle:(id)sender;
- (IBAction)setRecomendation:(id)sender;


@end
