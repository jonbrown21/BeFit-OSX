#import "FoodList.h"
#import "Food.h"

@implementation FoodList

// Variables

    -(long)OrderIndexLongValue
    {
    return( [ [ self valueForKey: @"orderIndex" ] longValue ] );
    }

    -(NSString*)OrderIndexStringValue
    {
    return( [ NSString stringWithFormat: @"%@", [ [ self valueForKey: @"orderIndex" ] description ] ] );
    }

    - (NSString *)nameValue
    {
    return( [NSString stringWithFormat: @"%@", [self valueForKey: @"name"] ] );
    }

    -(NSString *)badgeString
    {
    NSSet * foodList = [ self valueForKey: @"foods" ];
    NSEnumerator * foodEnumerator = [foodList objectEnumerator ];
    Food * currentFood;
    long numOfItems = 0;

    while (( currentFood = [ foodEnumerator nextObject ] ) != NULL )
    {
        numOfItems+=[currentFood quantityLongValue];
    }
        NSString * myBadgeCount = [ NSString stringWithFormat: @"%ld", numOfItems ];
        NSInteger myInt = [myBadgeCount intValue];
        
        if ( myInt == 0) {
            return Nil;
        } else {
            return( [ NSString stringWithFormat: @"%ld", numOfItems ] );
        }
    }

    -(NSString *)numberOfCaloriesString
    {
    NSSet* foodList = [ self valueForKey: @"foods" ];

    NSEnumerator *FoodEnumerator = [foodList objectEnumerator];

    long long TotalCalories = 0;

    Food* CurrentFood;
    while ((CurrentFood = [FoodEnumerator nextObject]))
    {
        TotalCalories = TotalCalories + ( [ CurrentFood caloriesLongValue ] );
    }

    return( [ NSString stringWithFormat: @"%qi Total Calories", TotalCalories ] );
    }

// Sets the Library Image or Folder Image

    -(NSImage*)FoodListDisplayImage
    {
    NSImage* ImageToReturn = NULL;

    if ( [ [ self valueForKey: @"orderIndex" ] longValue ] == 0 )
      {
      ImageToReturn = [ NSImage imageNamed: @"Library" ];
      }
    else if ([ [ self valueForKey: @"orderIndex" ] longValue ] == 1) {
       ImageToReturn = [ NSImage imageNamed: @"Library" ];
    }
    else
      {
          ImageToReturn = [ NSImage imageNamed: @"Document" ];
      }
       
    [ImageToReturn isTemplate];
    [ImageToReturn setTemplate:true];
       
    return( ImageToReturn );

    }

// Determines if we can edit the name of the sourcelist

    -(BOOL)canEditName
    {
    if ( [ [ self valueForKey: @"orderIndex" ] longValue ] == 0 )
      {
      return( NO );
      }
    else if ([ [ self valueForKey: @"orderIndex" ] longValue ] == 1) {
       return( NO );
    }
    else
      {
      return( YES );
      }
    }

    -(BOOL)hideShowButton
    {
    if ( [ [ self valueForKey: @"orderIndex" ] longValue ] == 0 )
    {
        return( NO );
    }
    else if ([ [ self valueForKey: @"orderIndex" ] longValue ] == 1) {
        return( YES );
    }
    else
    {
        return( YES );
    }
    }

// Important variable for Graphing system

    -(float)CaloriesMagnitudeForGraph
    {
    long long TotalCaloriesForList = 0;

    if ( [ [ self valueForKey: @"orderIndex" ] longValue ] != 0 )
    {
        NSSet* foodList = [ self valueForKey: @"foods" ];
        
        NSEnumerator *FoodEnumerator = [foodList objectEnumerator];
        
        Food* CurrentFood;
        while ((CurrentFood = [FoodEnumerator nextObject]))
        {
            TotalCaloriesForList = TotalCaloriesForList + [ CurrentFood caloriesLongValue ];
        }
    }

    return( TotalCaloriesForList / 10 );
    }

//Added back in since the bindings were too slow:

    -(NSString*)numberOfItemsWithCaloriesString
    {
    if ( [ self OrderIndexLongValue ] != 0 )
    {
        return( [ NSString stringWithFormat: @"%@, %@", [ self numberOfItemsString ], [ self numberOfCaloriesString ] ] );
    }
    else
    {
        return( [ NSString stringWithFormat: @"%@", [ self numberOfItemsString ] ] );
    }
    }

    -(NSString *)numberOfItemsString
    {
    #if OLDWAYOFDOINGIT
    /* this just calculates the number of foods in the list, not the actual quantities of the foods */
    if ( [ [ self valueForKey: @"foods" ] count ] == 1 )
    {
    return( [ NSString stringWithFormat: @"BeFit — 1 Item" ] );
    }
    else
    {
    return( [ NSString stringWithFormat: @"%d Items", [ [ self valueForKey: @"foods" ] count ] ] );
    }
    #endif
    NSSet * foodList = [ self valueForKey: @"foods" ];
    NSEnumerator * foodEnumerator = [foodList objectEnumerator ];
    Food * currentFood;
    long numOfItems = 0;

    while (( currentFood = [ foodEnumerator nextObject ] ) != NULL )
    {
    numOfItems+=[currentFood quantityLongValue];
    }

    if( numOfItems == 1 )
    return( [ NSString stringWithFormat: @"%@ %C %ld Item",[self valueForKey: @"name"], (unichar)0x2014, numOfItems ] );
    if( numOfItems == 54134 || numOfItems == 54135 || numOfItems == 54148)
    return( [ NSString stringWithFormat: @"%@ %C %ld Items",[self valueForKey: @"name"], (unichar)0x2014, numOfItems ] );
    if( numOfItems == 7146 )
    return( [ NSString stringWithFormat: @"%@ %C %ld Items",[self valueForKey: @"name"], (unichar)0x2014, numOfItems ] );

    return( [ NSString stringWithFormat: @"%@ %C %ld Items",[self valueForKey: @"name"], (unichar)0x2014, numOfItems ] );
    }

// Functions

    - (void)setNameValue:(NSString *)nameToUse
    {
    [ self setValue: nameToUse forKey: @"name" ];
    }


    -(void)didSave
    {
    // NSLog( [ NSString stringWithFormat: @"FoodList did save" ] );
    }


@end
