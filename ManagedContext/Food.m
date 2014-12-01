#import "Food.h"


@implementation Food

#pragma mark -- Variables

long user;
long userValue;

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


#pragma mark Food Values -- Qty & Serving Sizes


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

-(BOOL)hideServing
{
    if ( [[ self valueForKey: @"servingDescription1" ]  isEqual: @"1 ITEM"] ||  [[ self valueForKey: @"servingDescription1" ]  isEqual: @"1 item"])
    {
        return( YES );
    }
    else
    {
        return( NO );
    }
}

#pragma mark Food Values -- FUNCTIONS



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

-(long)CalculateLong: (NSString*)key
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }

    long	userValue = [[ self valueForKey: key] longValue] * QuantityActualValue;
    long	actualValue = (( [[ self valueForKey: key] longValue] * [self selectedServingWeight ] ) / 100 )* QuantityActualValue;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( userValue );
    } else {
        return( actualValue );
    }
}

-(double)CalculateDouble: (NSString*)key
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double	userValue = [[ self valueForKey: key] longValue] * QuantityActualValue;
    double	actualValue = (( [[ self valueForKey: key] longValue] * [self selectedServingWeight ] ) / 100 )* QuantityActualValue;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( userValue );
    } else {
        return( actualValue );
    }
    
}
-(NSString*)CalculateValues: (NSString*)key
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double userValue = [[ self valueForKey: key ] doubleValue ] * QuantityActualValue;
    double actualValue = (( [[ self valueForKey: key ] doubleValue ] * [ self selectedServingWeight ] ) / 100 ) * QuantityActualValue;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        
        if ([key  isEqual: @"sodium"] || [key  isEqual: @"cholesteral"] || [key  isEqual: @"calcium"] || [key  isEqual: @"iron"] || [key  isEqual: @"vitaminC"] || [key  isEqual: @"vitaminA"]) {
            return [NSString stringWithFormat: @"%.0lfmg", userValue ];
        }
        return [NSString stringWithFormat: @"%.0lfg", userValue ];
    } else {
        if ([key  isEqual: @"sodium"] || [key  isEqual: @"cholesteral"] || [key  isEqual: @"calcium"] || [key  isEqual: @"iron"] || [key  isEqual: @"vitaminC"] || [key  isEqual: @"vitaminA"]) {
            return [NSString stringWithFormat: @"%.0lfmg", actualValue ];
        }
        return [NSString stringWithFormat: @"%.0lfg", actualValue ];
    }
}







#pragma mark Food Values -- Long Values

-(NSString*)caloriesLongValueTip
{
    return [NSString stringWithFormat: @"%ld", [ self caloriesLongValue ] ];
}

-(long)caloriesValue
{
    return( [ [ self valueForKey: @"calories" ] longValue ] );
    
}

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


-(long)proteinValueAsLong
{
    
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    long	originalValue = [[ self valueForKey: @"protein" ] longValue ] * QuantityActualValue;
    long	servingWeight = [ self selectedServingWeight ] ;
    long	adjustedValue = (( originalValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
}

-(long)carbsValueAsLong
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long carbsL = [ [ self valueForKey: @"carbs" ] longValue ] * QuantityActualValue;
    
    return( carbsL );
}

-(long)dietaryFiberValueAsLong
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long carbsL = [ [ self valueForKey: @"dietaryFiber" ] longValue ] * QuantityActualValue;
    
    return( carbsL );
    
}

-(long)cholesterolValueAsLong
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long carbsL = [ [ self valueForKey: @"cholesteral" ] longValue ] * QuantityActualValue;
    
    return( carbsL );
    
}

-(long)sodiumValueAsLong
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    long	originalValue = [[self valueForKey: @"sodium"] longValue ] * QuantityActualValue;
    long	servingWeight = [self selectedServingWeight ];
    long	adjustedValue = (( originalValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
}

-(long)sugarsValueAsLong
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    long	originalValue = [ [ self valueForKey: @"sugars" ] longValue ] * QuantityActualValue;
    long	servingWeight = [ self selectedServingWeight ];
    long	adjustedValue = (( originalValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( adjustedValue );
    } else {
        return( originalValue );
    }
}






#pragma mark Food Values -- Double Values




-(double)saturatedFatValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double result = [ [ self valueForKey: @"saturatedFat" ] doubleValue ];
    long servingWeight = [ self selectedServingWeight ];
    double valueToDisplay;
    double userResult = [ [ self valueForKey: @"saturatedFat" ] doubleValue ] * QuantityActualValue;
    
    result = (( result * servingWeight ) / 100 );
    
    //Round it to one decimal
    valueToDisplay = round(( 10 * result )/ 10) * QuantityActualValue;
    
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
}

-(double)polyunsaturatedFatValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double result = [ [ self valueForKey: @"polyFat" ] doubleValue ];
    long servingWeight = [ self selectedServingWeight ];
    double valueToDisplay;
    double userResult = [ [ self valueForKey: @"polyFat" ] doubleValue ] * QuantityActualValue;
    
    result = (( result * servingWeight ) / 100 );
    
    //Round it to one decimal
    valueToDisplay = round(( 10 * result )/ 10) * QuantityActualValue;
    
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }

}


-(double)monounsaturatedFatValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double result = [ [ self valueForKey: @"monosaturatedFat" ] doubleValue ];
    long servingWeight = [ self selectedServingWeight ];
    double valueToDisplay;
    double userResult = [ [ self valueForKey: @"monosaturatedFat" ] doubleValue ] * QuantityActualValue;
    
    result = (( result * servingWeight ) / 100 );
    
    //Round it to one decimal
    valueToDisplay = round(( 10 * result )/ 10) * QuantityActualValue;
    
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
}


-(double)ironValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    double ironD = [ [ self valueForKey: @"iron" ] doubleValue ] * QuantityActualValue;
    return( round( ironD ) );
}


-(double)vitaminCValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    double ironD = [ [ self valueForKey: @"vitaminC" ] doubleValue ] * QuantityActualValue;
    return( round( ironD ) );
    

}


-(double)vitaminAValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    double ironD = [ [ self valueForKey: @"vitaminA" ] doubleValue ] * QuantityActualValue;
    return( round( ironD ) );
    
   
}

-(double)calciumValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    double ironD = [ [ self valueForKey: @"calcium" ] doubleValue ] * QuantityActualValue;
    return( round( ironD ) );
    

}

-(double)vitaminEValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    double ironD = [ [ self valueForKey: @"vitaminE" ] doubleValue ] * QuantityActualValue;
    return( round( ironD ) );

}






#pragma mark Food Values -- Value Calculations




- (NSString *)saturatedFatValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double fatValue = [[ self valueForKey: @"saturatedFat" ] doubleValue ] * QuantityActualValue;
    long servingWeight = [ self selectedServingWeight ];
    double adjustedFat = (( fatValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
    
}

- (NSString *)cholesterolValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    long	originalValue = [[self valueForKey: @"cholesteral"] longValue ] * QuantityActualValue;
    long	servingWeight = [self selectedServingWeight ];
    long	adjustedValue = (( originalValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%ldmg", adjustedValue ];
    } else {
        return [NSString stringWithFormat: @"%ldmg", originalValue ];
    }
    
    
}

- (NSString *)proteinValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = [[self valueForKey: @"protein"] doubleValue] * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldg", protS ];
}

- (NSString *)sodiumValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    long	originalValue = [[self valueForKey: @"sodium"] longValue ] * QuantityActualValue;
    long	servingWeight = [self selectedServingWeight ];
    long	adjustedValue = (( originalValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%ldmg", adjustedValue ];
    } else {
        return [NSString stringWithFormat: @"%ldmg", originalValue ];
    }
    
    
}

- (NSString *)carbsValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"carbs"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldg", protS ];
}

- (NSString *)dietaryFiberValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"dietaryFiber"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldg", protS ];

}

- (NSString *)sugarsValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"sugars"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldg", protS ];

}

- (NSString *)polyunsaturatedFatValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double fatValue = [[ self valueForKey: @"polyFat" ] doubleValue ] * QuantityActualValue;
    long servingWeight = [ self selectedServingWeight ];
    double adjustedFat = (( fatValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
    
}

- (NSString *)monounsaturatedFatValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double fatValue = [[ self valueForKey: @"monosaturatedFat" ] doubleValue ] * QuantityActualValue;
    long servingWeight = [ self selectedServingWeight ];
    double adjustedFat = (( fatValue * servingWeight ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.1lfg", adjustedFat ];
    } else {
        return [NSString stringWithFormat: @"%.1lfg", fatValue ];
    }
    
}

- (NSString *)vitaminAValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"vitaminA"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldmg", protS ];
}

- (NSString *)vitaminCValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"vitaminC"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldmg", protS ];
}

- (NSString *)ironValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"iron"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldmg", protS ];
}

- (NSString *)calciumValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"calcium"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldmg", protS ];
}

- (NSString *)viteValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    long protS = round([[self valueForKey: @"vitaminE"] doubleValue]) * QuantityActualValue;
    return [NSString stringWithFormat: @"%ldmg", protS ];
}






#pragma mark Food Percentages



- (NSString *)saturatedFatPercent
{
    return( [ self CalculatePercent: @"saturatedFat" divider: 0.20 ] );
}

- (NSString *)cholesterolPercent
{
    return( [ self CalculatePercent: @"cholesteral" divider: 3 ] );
}

- (NSString *)sodiumPercent
{
    return( [ self CalculatePercent: @"sodium" divider: 24 ] );
}

- (NSString *)carbsPercent
{
    return( [ self CalculatePercent: @"carbs" divider: 3.0 ] );
}

- (NSString *)dietaryFiberPercent
{
    return( [ self CalculatePercent: @"dietaryFiber" divider: 0.25 ] );
}

- (NSString *)ironValuePerc
{
    return( [ self CalculatePercent: @"iron" divider: 1.8 ] );
}
- (NSString *)calciumValuePerc
{
    return( [ self CalculatePercent: @"calcium" divider: 10 ] );
}

- (NSString *)vitaminCValuePerc
{
    return( [ self CalculatePercent: @"vitaminC" divider: 6 ] );
}

- (NSString *)vitaminEValuePerc
{
    return( [ self CalculatePercent: @"vitaminE" divider: 9.5 ] );
}

- (NSString *)vitaminAValuePerc
{
    return( [ self CalculatePercent: @"vitaminA" divider: 50 ] );
}


- (NSString *)polyFatValuePerc
{
    return( [ self CalculatePercent: @"polyFat" divider: 9 ] );
}

- (NSString *)monoFatValuePerc
{
    return( [ self CalculatePercent: @"monosaturatedFat" divider: 11 ] );
}

- (NSString *)calfromFatValuePerc
{
    double ValueForCalculation = [ self caloriesLongValue ];
    double Result = ( ValueForCalculation / 2000 )*100;
    
    //Round it to one decimal
    double ValueToDisplay = round( 10 * Result )/ 10;
    
    return [NSString stringWithFormat: @"%.0lf%%", ValueToDisplay ];

    
}



#pragma mark Food Values -- CUSTOM FUNCTIONS


-(double)totalFatValueAsDouble
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
    [ [self valueForKey: @"polyFat"] doubleValue ];
    double valueToDisplay;
    long servingWeight = [ self selectedServingWeight ] * QuantityActualValue;
    double calculatedFat = (( totalFat * servingWeight ) / 100 ) * QuantityActualValue;
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


- (NSString *)transFatValue
{
    double ValueToDisplay = [self totalFatValueAsDouble];
    double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ];
    double transfat = ValueToDisplay - totalFat;
    
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double actualValue = round((( transfat * [ self selectedServingWeight ] ) / 100 ) * QuantityActualValue);
    double userValue = round(transfat * QuantityActualValue);
    
    
    if (actualValue < 0) {
        actualValue = 0;
    } else if (actualValue == 0) {
        actualValue = 0;
    }
    
    if (userValue < 0) {
        userValue = 0;
    } else if (userValue == 0) {
        userValue = 0;
    }
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lfg", userValue ];
    } else {
        return [NSString stringWithFormat: @"%.0lfg", actualValue ];
    }
    
}

- (NSString *)totalFatValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double ValueToDisplay = [ self totalFatValueAsDouble ] * QuantityActualValue;
    
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

- (NSString *)proteinValuePerc
{
    long	totalProt = [[ self valueForKey: @"protein" ] longValue ];
    long	totalCals = [[ self valueForKey: @"calories" ] longValue ];
    
#if USEDTOBE
    double ValueForCalculation = totalProt * 4;
    double Result = ( ValueForCalculation / totalCals ) * 100;
    
    return [NSString stringWithFormat: @"%.0lf%%", Result ];
#endif
    double	valueForCalculation = totalProt * 4;
    double Result = ( valueForCalculation / totalCals ) * 100;
    
    double	valueForDisplay = (( Result * [ self selectedServingWeightAsDouble ] ) / 100 );
    
    return [NSString stringWithFormat: @"%.0lf%%", valueForDisplay ];
    
}

- (NSString *)sugarsValuePerc
{
    long	totalSugar = [[ self valueForKey: @"sugars" ] longValue ];
    
#if USEDTOBE
    
    double Result = ( totalSugar / [ self selectedServingWeightAsDouble ] ) * 100;
    
    return [NSString stringWithFormat: @"%.0lf%%", Result ];
    
#endif
    
    double Result = ( totalSugar / [ self selectedServingWeightAsDouble ] ) * 100;
    
    double	valueForDisplay = Result / 100;
    
    return [NSString stringWithFormat: @"%.0lf%%", valueForDisplay ];
    
}


- (NSString *)totalValuePerc
{
    long	totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
    [ [self valueForKey: @"polyFat"] doubleValue ];
    long intermediateValue = ( totalFat * 9 );
    
#if USEDTOBE
    
    double Result = ( intermediateValue / [ self selectedServingWeightAsDouble ] ) * 100;
    
    return [NSString stringWithFormat: @"%.0lf%%", Result ];
    
#endif
    
    double Result = ( intermediateValue / [ self selectedServingWeightAsDouble ] ) * 100;
    
    double	valueForDisplay = Result / 100;
    
    return [NSString stringWithFormat: @"%.0lf%%", valueForDisplay ];
    
}



- (NSString *)caloriesFromFatValue
{
    NSNumber * quantityNumber;
    long QuantityActualValue = 1;
    
    quantityNumber = [ self valueForKey: @"quantity" ];
    if( NULL != quantityNumber )
    {
        QuantityActualValue = [ quantityNumber longValue ];
        if( QuantityActualValue <= 0 )
            QuantityActualValue = 1;
    }
    
    double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
    [ [self valueForKey: @"polyFat"] doubleValue ];
    double intermediateValue = ( totalFat * 9 );
    double endingValue = (( intermediateValue * [ self selectedServingWeightAsDouble ] ) / 100 ) * QuantityActualValue;
    
    long user;
    
    user = [ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lf", endingValue ];
    } else {
        return [NSString stringWithFormat: @"%.0lf", endingValue ];
    }
    
}


-(long)ratingLongValue
{
    double ValueForCalculation = [ self caloriesLongValue ];
    double Result = ( ValueForCalculation / 2000 )*100;
    
    //Round it to one decimal
    double CaloriesRatingPercent = round( 10 * Result )/ 10;
    
    
    if(CaloriesRatingPercent >= 0 && CaloriesRatingPercent <= 21) {
        
        CaloriesRatingPercent = 5;
        
    } else if(CaloriesRatingPercent >= 21 && CaloriesRatingPercent <= 41) {
        
        CaloriesRatingPercent = 4;
        
    } else if(CaloriesRatingPercent >= 41 && CaloriesRatingPercent <= 61) {
        
        CaloriesRatingPercent = 3;
        
    } else if(CaloriesRatingPercent >= 61 && CaloriesRatingPercent <= 81) {
        
        CaloriesRatingPercent = 2;
        
    } else if(CaloriesRatingPercent >= 81 && CaloriesRatingPercent <= 100) {
        
        CaloriesRatingPercent = 1;
        
    } else if(CaloriesRatingPercent > 100) {
         CaloriesRatingPercent = 1;
    }
    
	return( CaloriesRatingPercent );

}

- (long)calFromDiet
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  lbspref = [defaults objectForKey:@"goal-name"];
    long yourLong = [lbspref longLongValue];
    long originalCalorieRatingValue = [[ self valueForKey: @"calories" ] longValue ];
    
    //NSString *calValue =  Cals;
    long yourCals = [ self caloriesLongValue ];
    long result = (yourLong - yourCals);
    
    return (originalCalorieRatingValue);
}

- (NSString *)CalsPrint
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *lbspref = [defaults objectForKey:@"goal-name"];
    double lbsprefint = [lbspref doubleValue];
    if (lbsprefint < 0) {
        lbsprefint = 2000;
    }
    
    return [NSString stringWithFormat: @"%ld / %.f", [self caloriesLongValue], round(lbsprefint) ];
}

- (NSString *)CarbsPrint
{
    
    return [NSString stringWithFormat: @"%@ / 300mg", [self carbsValue] ];
}

- (NSString *)CholPrint
{
    
    return [NSString stringWithFormat: @"%ld / 300mg", [self cholesterolValueAsLong] ];
}

- (NSString *)protPrint
{
    
    return [NSString stringWithFormat: @"%@ / 50g", [self proteinValue] ];
}

- (NSString *)sodPrint
{
    
    return [NSString stringWithFormat: @"%@ / 2400mg", [self sodiumValue] ];
}

- (NSString *)fibPrint
{
    
    return [NSString stringWithFormat: @"%@ / 25g", [self dietaryFiberValue] ];
}

- (NSString *)tfatPrint
{
    
    return [NSString stringWithFormat: @"%ld / 50g", [self sugarsValueAsLong] ];
}

@end
