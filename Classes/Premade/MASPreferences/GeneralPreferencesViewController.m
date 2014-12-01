
#import "GeneralPreferencesViewController.h"

@implementation GeneralPreferencesViewController



- (id)init
{
    return [super initWithNibName:@"GeneralPreferencesView" bundle:nil];
   

}

- (void) awakeFromNib
{

    [self LBSChecker:nil];
    [self FeetChecker:nil];
    [self InchesChecker:nil];
    [self cmChecker:nil];
    [self kgChecker:nil];
    [self ageChecker:nil];
    [self bmiCalculator:nil];
    [formattedSliderValue setHidden:YES];
    
    
}

-(IBAction)LBSChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  lbspref = [defaults objectForKey:@"lbs-name"];
    
    // Read default prefrences for member name
    if (lbspref == (id)[NSNull null] || lbspref.length == 0 ) {
        
        [lbsName setStringValue:@""];
        
    } else {
        
        [lbsName setStringValue:lbspref];
    }
    
    // Set Format for LBS Field
    NSNumberFormatter *lbsnameformatter = [[NSNumberFormatter alloc] init];
    [lbsnameformatter setFormat: @"#,###;0;(#,##0)"];
    [[lbsName cell] setFormatter:lbsnameformatter];
}


-(IBAction)FeetChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  feetpref = [defaults objectForKey:@"feet-name"];
    
    // Read default prefrences for member name
    if (feetpref == (id)[NSNull null] || feetpref.length == 0 ) {
        
        [feetname setStringValue:@""];
        
    } else {
        
        [feetname setStringValue:feetpref];
    }
    
    // Set Format for LBS Field
    NSNumberFormatter *feetnameformatter = [[NSNumberFormatter alloc] init];
    [feetnameformatter setFormat: @"#,###;0;(#,##0)"];
    [[feetname cell] setFormatter:feetnameformatter];
}


-(IBAction)InchesChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  inchpref = [defaults objectForKey:@"inch-name"];
    
    // Read default prefrences for member name
    if (inchpref == (id)[NSNull null] || inchpref.length == 0 ) {
        
        [inchname setStringValue:@""];
        
    } else {
        
        [inchname setStringValue:inchpref];
    }
    
    // Set Format for LBS Field
    NSNumberFormatter *inchnameformatter = [[NSNumberFormatter alloc] init];
    [inchnameformatter setFormat: @"#,###;0;(#,##0)"];
    [[inchname cell] setFormatter:inchnameformatter];
}


-(IBAction)cmChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  cmpref = [defaults objectForKey:@"cm-name"];
    
    // Read default prefrences for cm name
    if (cmpref == (id)[NSNull null] || cmpref.length == 0 ) {
        
        [cmname setStringValue:@""];
        
    } else {
        
        [cmname setStringValue:cmpref];
    }
    
    // Set Format for LBS Field
    NSNumberFormatter *cmnameformatter = [[NSNumberFormatter alloc] init];
    [cmnameformatter setFormat: @"#,###;0;(#,##0)"];
    [[cmname cell] setFormatter:cmnameformatter];
}

-(IBAction)kgChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  kgpref = [defaults objectForKey:@"kg-name"];
    
    // Read default prefrences for member name
    if (kgpref == (id)[NSNull null] || kgpref.length == 0 ) {
        
        [kgname setStringValue:@""];
        
    } else {
        
        [kgname setStringValue:kgpref];
    }
    
    // Set Format for LBS Field
    NSNumberFormatter *kgnameformatter = [[NSNumberFormatter alloc] init];
    [kgnameformatter setFormat: @"#,###;0;(#,##0)"];
    [[kgname cell] setFormatter:kgnameformatter];
}

-(IBAction)ageChecker:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  agepref = [defaults objectForKey:@"age-name"];
                          
      // Read default prefrences for member name
      if (agepref == (id)[NSNull null] || agepref.length == 0 ) {
          
          [agename setStringValue:@""];
          
      } else {
          
          [agename setStringValue:agepref];
      }
      
      // Set Format for LBS Field
      NSNumberFormatter *agenameformatter = [[NSNumberFormatter alloc] init];
      [agenameformatter setFormat: @"#,###;0;(#,##0)"];
      [[agename cell] setFormatter:agenameformatter];
}

-(IBAction)bmiCalculator:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  agepref = [defaults objectForKey:@"age-name"];
    NSString*  cmpref = [defaults objectForKey:@"cm-name"];
    NSString*  kgpref = [defaults objectForKey:@"kg-name"];
    
    NSString*  inchpref = [defaults objectForKey:@"inch-name"];
    NSString*  feetpref = [defaults objectForKey:@"feet-name"];
    NSString*  lbspref = [defaults objectForKey:@"lbs-name"];
    
    NSString*  metricpref = [defaults objectForKey:@"self.checkBoxChecked"];
    NSString*  metricvalue = [defaults objectForKey:@"metric-name"];
    NSString*  gendervalue = [defaults objectForKey:@"gender-name"];
    NSString*  lifestylevalue = [defaults objectForKey:@"lifestyle-name"];
    NSString*  goalsvalue = [defaults objectForKey:@"goals-name"];
    NSString*  goalvalue = [defaults objectForKey:@"goal-name"];
    
    
    
    float inches;
    float BMI;
    float totalInches;
    float totalWeight;
    float totalCM;
    float totalKG;
    float totalMeters;
    float metercheck;
    float gender;
    float BMR;
    float age;
    float lbs;
    float sedentary, lightly, moderately, very, extra;
    float lifestyles;
    float goals;
    float BMRLIFESTYLE;
    float BMRGOALS;
    
    float gainsedentary, gainlightly, gainmoderately, gainvery, gainextra;
    float loosesedentary, looselightly, loosemoderately, loosevery, looseextra;
   

    
    int feet = [feetpref intValue];
    inches = [inchpref floatValue];
    totalWeight = [lbspref floatValue];
    totalCM = [cmpref floatValue];
    metercheck = [metricvalue floatValue];
    gender = [gendervalue floatValue];
    age = [agepref floatValue];
    lbs = [lbspref floatValue];
    lifestyles = [lifestylevalue floatValue];
    goals = [goalsvalue floatValue];
    
    
    if (metercheck == 1) {
        
        
        //NSLog(@"%f", metercheck);
        
        totalKG = [kgpref floatValue];
        totalMeters = totalCM / 100;
        BMI = totalKG / ( totalMeters * totalMeters );
        
        NSString* FinishedBMI = [NSString stringWithFormat:@"%.f", BMI];
        float bmiFloatValue;
        bmiFloatValue = [FinishedBMI floatValue];
        
        NSString* theRange;
        
        if(bmiFloatValue < 16.5){
            theRange = @"Underweight";
        }else if (bmiFloatValue<18.5) {
            theRange = @"Underweight";
        }else if (bmiFloatValue<27) {
            theRange = @"Normal";
        }else if (bmiFloatValue<30) {
            theRange = @"Overweight";
        }else if (bmiFloatValue<35) {
            theRange = @"Obese";
        }else {
            theRange = @"Obese";
        }
        
        //NSLog(@"%@",FinishedBMI);
        
        NSString* finalBMIOutput = [NSString stringWithFormat:@"BMI: %.f | Rating: %@", BMI, theRange];
        
        [bmiValue setStringValue:finalBMIOutput];
        
        
        [defaults setObject:FinishedBMI forKey:@"bmi-value"];
        
        // Calculate BMR

                    if (gender == 1) {
                        
                        BMR = 655 + ( 9.6 * totalKG ) + ( 1.8 * totalCM ) - ( 4.7 * age );

                        
                    } else {
                        
                        BMR =  66 + ( 13.7 * totalKG ) + ( 5 * totalKG ) - ( 6.8 * age );
                        
                    }
        
     
        
    } else {
    
        //NSLog(@"%f", metercheck);
        
        totalInches = (feet * 12) + inches;
        BMI = totalWeight / ( totalInches * totalInches ) * 703;
        NSString* FinishedBMI = [NSString stringWithFormat:@"%.f", BMI];
        
        
        float bmiFloatValue;
        bmiFloatValue = [FinishedBMI floatValue];
        
        NSString* theRange;
        
        if(bmiFloatValue < 16.5){
            theRange = @"Underweight";
        }else if (bmiFloatValue<18.5) {
            theRange = @"Underweight";
        }else if (bmiFloatValue<27) {
            theRange = @"Normal";
        }else if (bmiFloatValue<30) {
            theRange = @"Overweight";
        }else if (bmiFloatValue<35) {
            theRange = @"Obese";
        }else {
            theRange = @"Obese";
        }
        
        //NSLog(@"%@",FinishedBMI);
        
        NSString* finalBMIOutput = [NSString stringWithFormat:@"BMI: %.f | Rating: %@", BMI, theRange];
        
        [bmiValue setStringValue:finalBMIOutput];
        
        [defaults setObject:FinishedBMI forKey:@"bmi-value"];
        
        // Calculate BMR
        
                if (gender == 1) {
                    
                    BMR = 655 + ( 4.35 * lbs ) + ( 4.7 * totalInches ) - ( 4.7 * age );
                    
                    
                } else {
                    
                    BMR =  66 + ( 6.23 * lbs ) + ( 12.7 * totalInches ) - ( 6.8 * age );
                    
                }
        
        
        
    }
    

    // Calculate Lifestyle
    
    if (lifestyles == 0) {
        
        BMRLIFESTYLE = BMR * 1.2;
        
    } else if (lifestyles == 1) {
        
        BMRLIFESTYLE = BMR * 1.375;
        
    } else if (lifestyles == 2) {
        
        BMRLIFESTYLE = BMR * 1.55;
        
    } else if (lifestyles == 3) {
        
        BMRLIFESTYLE = BMR * 1.725;
        
    } else if (lifestyles == 4) {
        
        BMRLIFESTYLE = BMR * 1.9;
        
    }
    
    
    // Calculate Goals
    
    if (goals == 0) {
        
        BMRGOALS = BMRLIFESTYLE - 500;
        
        
    } else if (goals == 1) {
        
        BMRGOALS = BMRLIFESTYLE + 1000;
        
    } else if (goals == 2) {
        
        BMRGOALS = BMRLIFESTYLE;
        
    } else {
        
        BMRGOALS = BMRLIFESTYLE;
        
    }
    

    
    [Answer setFloatValue:BMRGOALS];
    
    // Set Format for Answer Field
    NSNumberFormatter *answerformatter = [[NSNumberFormatter alloc] init];
    [answerformatter setFormat: @"#,###;0;(#,##0)"];
    [[Answer cell] setFormatter:answerformatter];
    
    
    NSString* recomendPref = [Recomend stringValue];
    
    float rec, slide;
    rec = [recomendPref floatValue];
    slide = [Answer floatValue];
    
    NSString *mySlide = [[NSNumber numberWithFloat:slide] stringValue];
    [formattedSliderValue setStringValue:mySlide];
    

   
    NSString* SlidePrefSetter = [formattedSliderValue stringValue];
    

    
    if (rec == 0.000000) {
        
        [prefslider setEnabled:YES];
        
    } else {
        
        [defaults setObject:SlidePrefSetter forKey:@"goal-name"];
        
        [prefslider setStringValue:SlidePrefSetter];
        [sliderValueLabel setStringValue:SlidePrefSetter];
        
        NSLog(@"Recomended String Value is: %@", SlidePrefSetter);
        NSLog(@"Recomended Float Value is: %f", slide);
        NSLog(@"Recommended Pref is: %f", rec);
        
        [prefslider setEnabled:NO];
    }
    
    
    
    
    
    
    
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:@"Cog"];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"General", @"Toolbar item name for the General preference pane");
}


- (IBAction)setMetric:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* metricPref = [metricheck stringValue];
   // NSString* metricPrefString = [NSString stringWithFormat:@"%li", (long)metricPref];

    
    if (sender == metricheck)
    {
        [defaults setObject:metricPref forKey:@"metric-name"];
        [self bmiCalculator:nil];
        NSLog(@"Metric value is: %@", metricPref);
    }
}

- (IBAction)setLifestyle:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexInteger = [lifeStyle indexOfSelectedItem];
    NSString* indexIntegerString = [NSString stringWithFormat:@"%li", (long)indexInteger];

    if (sender == lifeStyle)
    {
        [defaults setObject:indexIntegerString forKey:@"lifestyle-name"];
        [self bmiCalculator:nil];
        NSLog(@"Lifestyle is: %ld", (long)indexInteger);

    }
}

- (IBAction)setRecomendation:(id)sender
{

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* recomendPref = [Recomend stringValue];
    
    
    if (sender == Recomend)
    {
        [defaults setObject:recomendPref forKey:@"recommend-name"];
        [self bmiCalculator:nil];
        NSLog(@"Metric value is: %@", recomendPref);
    }

        
    
}


- (IBAction)setGoals:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexInteger = [weightGoals indexOfSelectedItem];
    NSString* indexIntegerString = [NSString stringWithFormat:@"%li", (long)indexInteger];

    if (sender == weightGoals)
    {
        [defaults setObject:indexIntegerString forKey:@"goals-name"];
        [self bmiCalculator:nil];
        NSLog(@"Goals are: %ld", (long)indexInteger);
    }
}

- (IBAction)setGender:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger indexInteger = [gendercheck indexOfSelectedItem];
    NSString* indexIntegerString = [NSString stringWithFormat:@"%li", (long)indexInteger];
    
    if (sender == gendercheck)
    {
        [defaults setObject:indexIntegerString forKey:@"gender-name"];
        [self bmiCalculator:nil];
        NSLog(@"Gender is: %ld", (long)indexInteger);
    }
}

- (IBAction)setWeightLBS:(id)sender
{
    // Set default prefrences for Member Name
    
    float num1;
    NSString *num2;
    
    num1 = [lbsName floatValue];
    num2 = [lbsName stringValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *lbsnamed = [lbsName stringValue];
    
    if (num1 <= 0) {
        
        if (num2.length == 0) {
            
            if (sender == lbsName)
            {
                [defaults setObject:lbsnamed forKey:@"lbs-name"];
                [self bmiCalculator:nil];
                NSLog(@"LBS value is: %@", lbsnamed);
                
            }
            
        } else {
            
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Please enter a value between 0 and 350 lbs."];
            [alert runModal];
        }
        
        
    } else if (num1 > 350) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 350 lbs."];
        [alert runModal];
        
    } else {
        
        if (sender == lbsName)
        {
            [defaults setObject:lbsnamed forKey:@"lbs-name"];
            [self bmiCalculator:nil];
            NSLog(@"LBS value is: %@", lbsnamed);
            
        }
        
    }
    
}

- (IBAction)setFeet:(id)sender
{
    
    // Set default prefrences for Member Name
    
    float num2;
    NSString *num3;
    
    num2 = [feetname floatValue];
    num3 = [feetname stringValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *feetnamed = [feetname stringValue];
    
    if (num2 <= 0) {
        
        if (num3.length == 0) {
            
            if (sender == feetname)
            {
                [defaults setObject:feetnamed forKey:@"feet-name"];
                [self bmiCalculator:nil];
                NSLog(@"Feet value is: %@", feetnamed);
            }
            
        } else {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 10 lbs."];
        [alert runModal];
            
        }
        
    } else if (num2 > 10) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 10 lbs."];
        [alert runModal];
        
    } else {
        
        if (sender == feetname)
        {
            [defaults setObject:feetnamed forKey:@"feet-name"];
            [self bmiCalculator:nil];
            NSLog(@"Feet value is: %@", feetnamed);
        }
        
    }
    
}

- (IBAction)setInches:(id)sender
{
    
    
    // Set default prefrences for Member Name
    
    float num3;
    NSString * num4;
    
    num3 = [inchname floatValue];
    num4 = [inchname stringValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *inchnamed = [inchname stringValue];
    
    if (num3 <= 0) {
        
        if (num4.length == 0) {
         
            if (sender == inchname)
            {
                [defaults setObject:inchnamed forKey:@"inch-name"];
                [self bmiCalculator:nil];
                NSLog(@"Inch value is: %@", inchnamed);
            } 
            
        } else {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 12 lbs."];
        [alert runModal];
            
        }
        
    } else if (num3 > 12) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 12 lbs."];
        [alert runModal];
        
    } else {
        
        if (sender == inchname)
        {
            [defaults setObject:inchnamed forKey:@"inch-name"];
            [self bmiCalculator:nil];
            NSLog(@"Inch value is: %@", inchnamed);
        }
        
    }
    
    
}


- (IBAction)setCM:(id)sender
{


        // Set default prefrences for Member Name

        float num3;
        NSString * num4;

        num3 = [cmname floatValue];
        num4 = [cmname stringValue];

        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSString *cmnamed = [cmname stringValue];

                if (num3 <= 0) {

                            if (num4.length == 0) {

                            if (sender == cmname)
                            {
                                [defaults setObject:cmnamed forKey:@"cm-name"];
                                [self bmiCalculator:nil];
                                NSLog(@"CM value is: %@", cmnamed);
                            }

                            } else {

                            NSAlert *alert = [[NSAlert alloc] init];
                            [alert setMessageText:@"cmnamePlease enter a value between 0 and 300 cm."];
                            [alert runModal];

                            }

                } else if (num3 > 300) {

                NSAlert *alert = [[NSAlert alloc] init];
                [alert setMessageText:@"Please enter a value between 0 and 300 cm."];
                [alert runModal];

                } else {

                            if (sender == cmname)
                            {
                                [defaults setObject:cmnamed forKey:@"cm-name"];
                                [self bmiCalculator:nil];
                                NSLog(@"CM value is: %@", cmnamed);
                            }

                }


}


- (IBAction)setKG:(id)sender
{
    
    
    // Set default prefrences for Member Name
    
    float num3;
    NSString * num4;
    
    num3 = [kgname floatValue];
    num4 = [kgname stringValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *kgnamed = [kgname stringValue];
    
    if (num3 <= 0) {
        
        if (num4.length == 0) {
            
            if (sender == kgname)
            {
                [defaults setObject:kgnamed forKey:@"kg-name"];
                [self bmiCalculator:nil];
                NSLog(@"KG value is: %@", kgnamed);
            }
            
        } else {
            
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"kgnamePlease enter a value between 0 and 300 cm."];
            [alert runModal];
            
        }
        
    } else if (num3 > 300) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 300 cm."];
        [alert runModal];
        
    } else {
        
        if (sender == kgname)
        {
            [defaults setObject:kgnamed forKey:@"kg-name"];
            [self bmiCalculator:nil];
            NSLog(@"KG value is: %@", kgnamed);
        }
        
    }
    
    
}

- (IBAction)setAge:(id)sender
{
    
    
    // Set default preferences for Member Name
    
    float num3;
    NSString * num4;
    
    num3 = [agename floatValue];
    num4 = [agename stringValue];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *agenamed = [agename stringValue];
    
    if (num3 <= 0) {
        
        if (num4.length == 0) {
            
            if (sender == agename)
            {
                [defaults setObject:agenamed forKey:@"age-name"];
                [self bmiCalculator:nil];
                NSLog(@"Age value is: %@", agenamed);
            }
            
        } else {
            
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"agenamePlease enter a value between 0 and 100."];
            [alert runModal];
            
        }
        
    } else if (num3 > 100) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Please enter a value between 0 and 100."];
         [alert runModal];
         
         } else {
             
             if (sender == agename)
             {
                 [defaults setObject:agenamed forKey:@"age-name"];
                 [self bmiCalculator:nil];
                 NSLog(@"Age value is: %@", agenamed);
             }
             
         }
         
    
}

         
@end
