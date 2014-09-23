#import "BeFitGraphOpenGLView.h"
#import "FoodList.h"
#import "Food.h"
#import "FoodListArrayController.h"
#import "GUIController.h"
#import <WebKit/WebKit.h>

@implementation BeFitGraphView



-(float)GetMagnitudeForGraph: (double)AverageForList
{
    
    //Want 2X the average for all foods to be the 100 percentile mark which is a value of 100. So:
    //Magnitude = ( 100 * Average for list) / (Average For all * 2)
    //Magnitude = 50 * AverageForList / Average For All Foods.
    float ReturnValue = ( float ) ( AverageForList );
    
    //Don't want a magnitude greater then 100
    //if ( ReturnValue > 100 )
    //{ ReturnValue = 100; }
    
    return( ReturnValue );
}



-(void)drawGraphFromSelectedFoodList
{
    
    NSArray* ListOfFoods = [ FoodListController arrangedObjects ];
    
   
    if ( [ ListOfFoods count ] < 8000 )
    {
        
        NSEnumerator *FoodEnumerator = [ListOfFoods objectEnumerator];
        
        Food* CurrentFood;
        long long TotalCaloriesForList = 0;
        double    TotalFatForList      = 0;
        long long TotalProteinForList  = 0;
        long long TotalCarbsForList    = 0;
        double    TotalCalciumForList  = 0;
        double    TotalIronForList     = 0;
        long long TotalSugarForList    = 0;
        long long TotalFiberForList    = 0;
        long long TotalSodiumForList   = 0;
        
        long NumberOfFoods = 0;
        
        //Calculate the totals for the food list if appropriate
        while ( CurrentFood = [FoodEnumerator nextObject] )
        {
            TotalCaloriesForList = TotalCaloriesForList + [ CurrentFood caloriesLongValue ];
            TotalFatForList      = TotalFatForList +      [ CurrentFood totalFatValueAsDouble ];
            TotalProteinForList  = TotalProteinForList +  [ CurrentFood proteinValueAsLong ];
            TotalCarbsForList    = TotalCarbsForList +    [ CurrentFood carbsValueAsLong ];
            TotalCalciumForList  = TotalCalciumForList +  [ CurrentFood calciumValueAsDouble ];
            TotalIronForList     = TotalIronForList +     [ CurrentFood ironValueAsDouble ];
            TotalSugarForList    = TotalSugarForList +    [ CurrentFood sugarsValueAsLong ];
            TotalFiberForList    = TotalFiberForList +    [ CurrentFood dietaryFiberValueAsLong ];
            TotalSodiumForList   = TotalSodiumForList +   [ CurrentFood sodiumValueAsLong ];
            
            NumberOfFoods = NumberOfFoods + 1;
        }
        

            
            
            //Convert the Calories Square Data into an Integer
            int calInteger =  [self GetMagnitudeForGraph: ( double )TotalCaloriesForList ];
            
            //Convert the Fat Square Data into an Integer
            int fatInteger =  [ self GetMagnitudeForGraph: ( double )TotalFatForList
                                ];
            
             //Convert the Protien Square Data into an Integer
            int protInteger =  [ self GetMagnitudeForGraph: ( double )TotalProteinForList
                                  ];
            
            //Convert the Carbs Square Data into an Integer
            int carbInteger =  [ self GetMagnitudeForGraph: ( double )TotalCarbsForList
                                  ];
            
            //Convert the Calcium Square Data into an Integer
            int calcInteger =  [ self GetMagnitudeForGraph: ( double )TotalCalciumForList
                                 ];
            
            //Convert the Iron Square Data into an Integer
            int ironInteger =  [ self GetMagnitudeForGraph: ( double )TotalIronForList
                                 ];
            
            //Convert the Sugar Square Data into an Integer
            int sugarInteger =  [ self GetMagnitudeForGraph: ( double )TotalSugarForList
                                  ];
            
            //Convert the Fiber Square Data into an Integer
            int fiberInteger =  [ self GetMagnitudeForGraph: ( double )TotalFiberForList
                                   ];
            
            //Convert the Sodium Square Data into an Integer
            int sodiumInteger =  [ self GetMagnitudeForGraph: ( double )TotalSodiumForList
                                    ];
            
        
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            NSString*  lbspref = [defaults objectForKey:@"goal-name"];
        
        
            //Set that Integer as a string
            NSString* calString = [NSString stringWithFormat:@"%.2d", calInteger];
            NSString* fatString = [NSString stringWithFormat:@"%.2d", fatInteger];
            NSString* protString = [NSString stringWithFormat:@"%.2d", protInteger];
            NSString* carbString = [NSString stringWithFormat:@"%.2d", carbInteger];
            NSString* calcString = [NSString stringWithFormat:@"%.2d", calcInteger];
            NSString* ironString = [NSString stringWithFormat:@"%.2d", ironInteger];
            NSString* sugarString = [NSString stringWithFormat:@"%.2d", sugarInteger];
            NSString* fiberString = [NSString stringWithFormat:@"%.2d", fiberInteger];
            NSString* sodiumString = [NSString stringWithFormat:@"%.2d", sodiumInteger];
            
            //pass that to webview with javascript
            NSString *javascriptString = [NSString stringWithFormat:@"myFunction('%@','%@','%@','%d','%d','%d','%d','%d','%d','%@')", calString, fatString, protString, carbInteger, calcInteger, ironInteger, sugarInteger, fiberInteger, sodiumInteger, lbspref];
            
            [self stringByEvaluatingJavaScriptFromString:javascriptString];
        
            
        
        
    }
   
  
}

- (void) drawRect: (NSRect) rect
{

    [ self drawGraphFromSelectedFoodList ];
    
}




- (void)awakeFromNib
{
    
    
    
    [FoodListController addObserver:self forKeyPath:@"arrangedObjects"
                            options: NSKeyValueObservingOptionNew  context:NULL];
    
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqual:@"arrangedObjects"]) 
    {
        [ self setNeedsDisplay: YES ];
    }
}

@end