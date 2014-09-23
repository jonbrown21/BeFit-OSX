#import "Food.h"


@implementation Food

//Food Name
- (NSString *)nameValue 
   {
   return( [NSString stringWithFormat: @"%@", [self valueForKey: @"name"] ] );
   }


- (void)setNameValue:(NSString *)nameToUse
   {
   [ self setValue: nameToUse forKey: @"name" ];
   }

- (void)setCalValue:(NSString *)calToUse
{
    [ self setValue: [NSNumber numberWithInteger:calToUse] forKey: @"calories" ];
}

-(double)selectedServingWeightAsDouble
{
	NSNumber * number;
	double servingWeight;
	int indexOfItem;
	
	number = [ self valueForKey: @"selectedServing" ];
	if( NULL == number )
	{
		NSLog( @"selectedServing should never be null" );
		indexOfItem = 0;
	} else {
		indexOfItem = [ number intValue ];
	}

	if( indexOfItem == 1 )
	{
		servingWeight = [[ self valueForKey: @"servingWeight2" ] doubleValue ];
	} else {
		servingWeight = [[ self valueForKey: @"servingWeight1" ] doubleValue ];
	}
	
	return( servingWeight );
}

-(long)selectedServingWeight
{
	NSNumber * number;
	long servingWeight;
	int indexOfItem;
	
	number = [ self valueForKey: @"selectedServing" ];
	if( NULL == number )
	{
		NSLog( @"selectedServing should never be null" );
		indexOfItem = 0;
	} else {
		indexOfItem = [ number intValue ];
	}

	if( indexOfItem == 1 )
	{
		servingWeight = [[ self valueForKey: @"servingWeight2" ] longValue ];
	} else {
		servingWeight = [[ self valueForKey: @"servingWeight1" ] longValue ];
	}
	
	return( servingWeight );
}

-(NSString*)CalculatePercent: (NSString*)key divider: (double)diverToUse
{
#if USEDTOBE
	double ValueForCalculation = [ [ self valueForKey: key ] doubleValue ];
	double Result = ( ValueForCalculation / diverToUse )*100;
   
	//Round it to one decimal
	double ValueToDisplay = round( 10 * Result )/ 10; 
   
	return [NSString stringWithFormat: @"%.0lf%%", ValueToDisplay ];
#endif
	double	valueForCalculation = [[ self valueForKey: key ] doubleValue ];
	double	intermediateValue1 = (( valueForCalculation * [ self selectedServingWeightAsDouble ] ) / 100 );
	double  valueForDisplay = ( intermediateValue1 / diverToUse );

	return [NSString stringWithFormat: @"%.0lf%%", valueForDisplay ];	
}



//Protein (stored as Int32) needs gram transformer
- (NSString *)proteinValue 
{
   return [NSString stringWithFormat: @"%@g", [self valueForKey: @"protein"] ];
}


-(long)proteinValueAsLong
{
	long	originalValue = [[ self valueForKey: @"protein" ] longValue ];
	long	servingWeight = [ self selectedServingWeight ];
	long	adjustedValue = (( originalValue * servingWeight ) / 100 );
	
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
    

}


//Sugars (stored as Int32) needs gram transformer
- (NSString *)sugarsValue 
{
   return [NSString stringWithFormat: @"%@g", [self valueForKey: @"sugars"] ];
}



-(long)sugarsValueAsLong
{
	long	originalValue = [ [ self valueForKey: @"sugars" ] longValue ];
	long	servingWeight = [ self selectedServingWeight ];
	long	adjustedValue = (( originalValue * servingWeight ) / 100 );
	
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
    
	
}


//Dietary fiber stored as UInt32  needs gram transformer
- (NSString *)dietaryFiberValue 
{
	return [NSString stringWithFormat: @"%@g", [self valueForKey: @"dietaryFiber"] ];
}


- (NSString *)dietaryFiberPercent
{
	return( [ self CalculatePercent: @"dietaryFiber" divider: 0.25 ] );
}


-(long)dietaryFiberValueAsLong
{
	return( [ [ self valueForKey: @"dietaryFiber" ] longValue ] );
}


//Carbs stored as Int32  needs gram transformer
- (NSString *)carbsValue 
{
	return [NSString stringWithFormat: @"%@g", [self valueForKey: @"carbs"] ];
}


- (NSString *)carbsPercent
{
	return( [ self CalculatePercent: @"carbs" divider: 3.0 ] );
}


-(long)carbsValueAsLong
{
	return( [ [ self valueForKey: @"carbs" ] longValue ] );
}


//Sodium stored as Int32  needs MG transformer
- (NSString *)sodiumValue 
{
	long	originalValue = [[self valueForKey: @"sodium"] longValue ];
	long	servingWeight = [self selectedServingWeight ];
	long	adjustedValue = (( originalValue * servingWeight ) / 100 );
	
    long user;
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%ldmg", adjustedValue ];
    } else {
        return [NSString stringWithFormat: @"%ldmg", originalValue ];
    }
    
	
}


- (NSString *)sodiumPercent
{
	return( [ self CalculatePercent: @"sodium" divider: 24 ] );
}


-(long)sodiumValueAsLong
{
	long	originalValue = [[self valueForKey: @"sodium"] longValue ];
	long	servingWeight = [self selectedServingWeight ];
	long	adjustedValue = (( originalValue * servingWeight ) / 100 );
    
    long user;
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
    
    
	
}



//Cholestoral stored as Int32  needs MG transformer
- (NSString *)cholesterolValue 
{
	long	originalValue = [[self valueForKey: @"cholesteral"] longValue ];
	long	servingWeight = [self selectedServingWeight ];
	long	adjustedValue = (( originalValue * servingWeight ) / 100 );
	
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%ldmg", adjustedValue ];
    } else {
        return [NSString stringWithFormat: @"%ldmg", originalValue ];
    }
    
	
}


- (NSString *)cholesterolPercent
{
	return( [ self CalculatePercent: @"cholesteral" divider: 3 ] );
}


-(long)cholesterolValueAsLong
{
	return( [ [ self valueForKey: @"cholesteral" ] longValue ] );
}

//Polyunsaturated Fat stored as double  needs gram transformer
- (NSString *)polyunsaturatedFatValue
{
	double fatValue = [[ self valueForKey: @"polyFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double adjustedFat = (( fatValue * servingWeight ) / 100 );
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
	
}

-(double)polyunsaturatedFatValueAsDouble
{
	double result = [ [ self valueForKey: @"polyFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double valueToDisplay;
	double userResult = [ [ self valueForKey: @"polyFat" ] doubleValue ];
    
	result = (( result * servingWeight ) / 100 );
	
	//Round it to one decimal
	valueToDisplay = round( 10 * result )/ 10;
    
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
    
    
    
	
}

//Monounsaturated Fat stored as double  needs gram transformer
- (NSString *)monounsaturatedFatValue
{
	double fatValue = [[ self valueForKey: @"monosaturatedFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double adjustedFat = (( fatValue * servingWeight ) / 100 );
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
	
}

-(double)monounsaturatedFatValueAsDouble
{
	double result = [ [ self valueForKey: @"monosaturatedFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double valueToDisplay;
	double userResult = [ [ self valueForKey: @"monosaturatedFat" ] doubleValue ];
    
	result = (( result * servingWeight ) / 100 );
	
	//Round it to one decimal
	valueToDisplay = round( 10 * result )/ 10;
    
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
    
    
    
	
}

//Saturated Fat stored as double  needs gram transformer
- (NSString *)saturatedFatValue 
{
	double fatValue = [[ self valueForKey: @"saturatedFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double adjustedFat = (( fatValue * servingWeight ) / 100 );
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
	
}


- (NSString *)saturatedFatPercent
{
   return( [ self CalculatePercent: @"saturatedFat" divider: 0.20 ] );
}



-(double)saturatedFatValueAsDouble
{   
	double result = [ [ self valueForKey: @"saturatedFat" ] doubleValue ];
	long servingWeight = [ self selectedServingWeight ];
	double valueToDisplay;
	double userResult = [ [ self valueForKey: @"saturatedFat" ] doubleValue ];
    
	result = (( result * servingWeight ) / 100 );
	
	//Round it to one decimal
	valueToDisplay = round( 10 * result )/ 10;

    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
    
    

	
}



//Total fat stored as double  needs gram transformer
-(double)totalFatValueAsDouble
{
	double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
                     [ [self valueForKey: @"polyFat"] doubleValue ];
	double valueToDisplay;
	long servingWeight = [ self selectedServingWeight ];
	double calculatedFat = (( totalFat * servingWeight ) / 100 );
    double userResult;
    
	valueToDisplay = round( calculatedFat );
    userResult = round( totalFat );
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }

}


- (NSString *)totalFatValue 
{
	double ValueToDisplay = [ self totalFatValueAsDouble ];
   
	return [NSString stringWithFormat: @"%.0lfg", ValueToDisplay ];
}


- (NSString *)totalFatPercent
{

	double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
                     [ [self valueForKey: @"polyFat"] doubleValue ];
	double result = ((( totalFat * [ self selectedServingWeightAsDouble ] ) / 100 ) / 0.63 );
	double valueToReturn = round( result );
	double userResult = round( totalFat );
	
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lf%%", valueToReturn ];
    } else {
        return [NSString stringWithFormat: @"%.0lf%%", userResult ];
    }
    
    
}

-(long)ratingLongValue
{
    
    long CaloriesRatingPercent;
	long originalCalorieRatingValue;
	long servingWeightRating;
	double actualCaloriesRating;
	int	indexOfItem;
	NSNumber * number;
	
	number = [ self valueForKey: @"selectedServing" ];
	if( NULL == number )
	{
		indexOfItem = 0;
	} else {
		indexOfItem = [ number intValue ];
	}
	
	originalCalorieRatingValue = [[ self valueForKey: @"calories" ] longValue ];
	if( indexOfItem == 1 )
	{
		servingWeightRating = [[ self valueForKey: @"servingWeight2" ] longValue ];
	} else {
		servingWeightRating = [[ self valueForKey: @"servingWeight1" ] longValue ];
	}
	
	actualCaloriesRating = (( servingWeightRating * originalCalorieRatingValue ) / 100 );
    
    
    CaloriesRatingPercent = (( actualCaloriesRating / 2000 ) * 100 );;
    
    
    
    if(CaloriesRatingPercent >= 0 && CaloriesRatingPercent <= 20) {
        
        CaloriesRatingPercent = 5;
        
    } else if(CaloriesRatingPercent >= 21 && CaloriesRatingPercent <= 40) {
        
        CaloriesRatingPercent = 4;
        
    } else if(CaloriesRatingPercent >= 41 && CaloriesRatingPercent <= 60) {
        
        CaloriesRatingPercent = 3;
        
    } else if(CaloriesRatingPercent >= 61 && CaloriesRatingPercent <= 80) {
        
        CaloriesRatingPercent = 2;
        
    } else if(CaloriesRatingPercent >= 81 && CaloriesRatingPercent <= 100) {
        
        CaloriesRatingPercent = 1;
        
    } else if(CaloriesRatingPercent > 100) {
         CaloriesRatingPercent = 1;
    }
    
    
	return( CaloriesRatingPercent );

    

    
    
}


-(long)caloriesValue
{
    return( [ [ self valueForKey: @"calories" ] longValue ] );
    
}

//Calories stored as Int32
-(long)caloriesLongValue
{
	long originalCalorieValue;
	long servingWeight;
	long actualCalories;
	int	indexOfItem;
	NSNumber * number;
    long user;
	
	number = [ self valueForKey: @"selectedServing" ];
	if( NULL == number )
	{
		indexOfItem = 0;
	} else {
		indexOfItem = [ number intValue ];
	}
	
	originalCalorieValue = [[ self valueForKey: @"calories" ] longValue ];
	if( indexOfItem == 1 )
	{
		servingWeight = [[ self valueForKey: @"servingWeight2" ] longValue ];
	} else {
		servingWeight = [[ self valueForKey: @"servingWeight1" ] longValue ];
	}
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        actualCalories = (( servingWeight * originalCalorieValue ) / 100 );
    } else {
        actualCalories = (originalCalorieValue);
    }
	
	return( actualCalories );
}


- (NSString *)caloriesFromFatValue 
{
	double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
                     [ [self valueForKey: @"polyFat"] doubleValue ];
	double intermediateValue = ( totalFat * 9 );
	double endingValue = (( intermediateValue * [ self selectedServingWeightAsDouble ] ) / 100 );
   
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"Fat Cals %.0lf", endingValue ];
    } else {
        return [NSString stringWithFormat: @"Fat Cals %.0lf", totalFat ];
    }
    
	
}

- (long) quantityLongValue
{
	NSNumber * quantityNumber;
	long actualValue = 1;
	
	quantityNumber = [ self valueForKey: @"quantity" ];
	if( NULL != quantityNumber )
	{
		actualValue = [ quantityNumber longValue ];
		if( actualValue <= 0 )
			actualValue = 1;
	}
	return( actualValue );
}

//Vitamin A stored as double  needs MG transformer
- (NSString *)vitaminAValue 
   {
   double ValueToDisplay = round( [ [self valueForKey: @"vitaminA"] doubleValue ] );
   
   return [NSString stringWithFormat: @"Vitamin A %.0lfmg", ValueToDisplay ];
   }



-(double)vitaminAValueAsDouble
   {
   return( round( [ [ self valueForKey: @"vitaminA" ] doubleValue ] ) );
   }



//Vitamin C stored as double needs MG transformer
- (NSString *)vitaminCValue 
   {
   double ValueToDisplay = round( [ [self valueForKey: @"vitaminC"] doubleValue ] );
   
   return [NSString stringWithFormat: @"Vitamin C %.0lfmg", ValueToDisplay ];
   }



-(double)vitaminCValueAsDouble
   {
   return( round( [ [ self valueForKey: @"vitaminC" ] doubleValue ] ) );
   }



//Iron stored as double needs MG transformer
- (NSString *)ironValue 
   {
   double ValueToDisplay = round( [ [self valueForKey: @"iron"] doubleValue ] );
   
   return [NSString stringWithFormat: @"Iron %.0lfmg", ValueToDisplay ];
   }


-(double)ironValueAsDouble
   {
   return( round( [ [ self valueForKey: @"iron" ] doubleValue ] ) );
   }


//Calcium stored as double needs MG transformer
- (NSString *)calciumValue 
   {
   double ValueToDisplay = round( [ [self valueForKey: @"calcium"] doubleValue ] );
   
   return [NSString stringWithFormat: @"Calcium %.0lfmg", ValueToDisplay ];
   }



-(double)calciumValueAsDouble
   {
   return( round( [ [ self valueForKey: @"calcium" ] doubleValue ] ) );
   }



-(double)vitaminEValueAsDouble
   {
   return( round( [ [ self valueForKey: @"vitaminE" ] doubleValue ] ) );
   }

- (NSString *)servingAmountValue
{
	NSNumber * number;
	unsigned indexOfItem;
	
	number = [ self valueForKey: @"selectedServing" ];
	if( NULL == number )
	{
		indexOfItem = 0;
	} else {
		indexOfItem = [ number intValue ];
	}
	
	if( indexOfItem == 1 )
	{
		return( [ self servingAmount2Value ] );
	}
		
	return( [ NSString stringWithFormat: @"%@", [ self valueForKey: @"servingDescription1" ]] );
}



- (NSString *)servingAmount1Value
{
#if 0
// def DEBUG
		NSLog( [ NSString stringWithFormat: @"s d 1 is %@", [ self valueForKey: @"servingDescription1" ]] );
		NSLog( [ NSString stringWithFormat: @"s w 1 is %d", [[ self valueForKey: @"servingWeight1" ] intValue ]] );
		NSLog( [ NSString stringWithFormat: @"s d 2 is %d %@", [[ self valueForKey: @"servingDescription2" ] length ], [ self valueForKey: @"servingDescription2" ]] );
		NSLog( [ NSString stringWithFormat: @"s w 2 is %d", [[ self valueForKey: @"servingWeight2" ] intValue ]] );
#endif
		
		return( [ NSString stringWithFormat: @"%@", [ self valueForKey: @"servingDescription1" ]] );
}


-(int)servingWeight1Value
{
    return( [ [ self valueForKey: @"servingWeight1" ] intValue ] );
    
}

- (NSString *)servingAmount2Value
{
	NSString * serving2Value;
	
	serving2Value = [ self valueForKey: @"servingDescription2" ];
	
	if( NULL == serving2Value )
		return NULL;
		
	return( [ NSString stringWithFormat: @"%@", serving2Value ] );
}

-(BOOL)changableColumnIsEditable
   {
   return( NO );
   }
   
-(int) indexOfServingBeingDisplayed
{
	return( [[ self valueForKey: @"selectedServing" ] intValue ] );
}

-(void)setIndexOfServingBeingDisplayed: (int) indexToSet
{
	[ self setValue: [ NSNumber numberWithInt: indexToSet ] forKey: @"selectedServing" ];
}

@end
