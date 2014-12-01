#import "GraphObject.h"

@implementation GraphObject

-(void)setCaloriesTotal:(NSNumber*)caloriesTotal
   {
 //  [ CaloriesTotal autorelease ];
   
   CaloriesTotal = [ caloriesTotal copy ];
   }


-(NSNumber*)caloriesTotal
   {
   return( CaloriesTotal );
   }


@end
