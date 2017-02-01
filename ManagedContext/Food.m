#import "Food.h"


@implementation Food

#pragma mark -- Variables

long user;
long userValue;

- (void)setNameValue:(NSString *)nameToUse
{
    [ self setValue: nameToUse forKey: @"name" ];
}

- (void)setCalValue:(NSString *)calToUse
{
    int calX = [calToUse intValue];
    [ self setValue: [NSNumber numberWithInteger:calX] forKey: @"calories" ];
}


#pragma mark -- BOOL

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
-(BOOL)changableColumnIsEditable
{
    return( NO );
}

#pragma mark -- STRINGS

- (NSString *)calciumValue
{
    return( [ self CalculateValues:@"calcium" ] );
}
- (NSString *)calciumValuePerc
{
    return( [ self CalculatePercent: @"calcium" divider: 10 ] );
}
- (NSString *)carbsPercent
{
    return( [ self CalculatePercent: @"carbs" divider: 3.0 ] );
}
- (NSString *)carbsValue
{
    return( [ self CalculateValues:@"carbs" ] );
}
- (NSString *)cholesterolPercent
{
    return( [ self CalculatePercent: @"cholesteral" divider: 3 ] );
}
- (NSString *)cholesterolValue
{
    return( [ self CalculateValues:@"cholesteral" ] );
}
- (NSString *)dietaryFiberPercent
{
    return( [ self CalculatePercent: @"dietaryFiber" divider: 0.25 ] );
}
- (NSString *)dietaryFiberValue
{
    return( [ self CalculateValues:@"dietaryFiber" ] );
}
- (NSString *)ironValue
{
    return( [ self CalculateValues:@"iron" ] );
}
- (NSString *)ironValuePerc
{
    return( [ self CalculatePercent: @"iron" divider: 1.8 ] );
}
- (NSString *)monounsaturatedFatValue
{
    return( [ self CalculateValues:@"monosaturatedFat" ] );
}
- (NSString *)nameValue
{
    return( [NSString stringWithFormat: @"%@", [self valueForKey: @"name"] ] );
}
- (NSString *)polyunsaturatedFatValue
{
    return( [ self CalculateValues:@"polyFat" ] );
}
- (NSString *)proteinValue
{
    return( [ self CalculateValues:@"protein" ] );
}
- (NSString *)saturatedFatPercent
{
    return( [ self CalculatePercent: @"saturatedFat" divider: 0.20 ] );
}
- (NSString *)saturatedFatValue
{
    return( [ self CalculateValues:@"saturatedFat" ] );
}
- (NSString *)sodiumPercent
{
    return( [ self CalculatePercent: @"sodium" divider: 24 ] );
}
- (NSString *)sodiumValue
{
    return( [ self CalculateValues:@"sodium" ] );
}
- (NSString *)sugarsValue
{
    return( [ self CalculateValues:@"sugars" ] );
}
- (NSString *)vitaminAValue
{
    return( [ self CalculateValues:@"vitaminA" ] );
}
- (NSString *)vitaminCValue
{
    return( [ self CalculateValues:@"vitaminC" ] );
};
- (NSString *)vitaminCValuePerc
{
    return( [ self CalculatePercent: @"vitaminC" divider: 6 ] );
}
- (NSString *)servingAmount1Value
{
    return( [ NSString stringWithFormat: @"%@", [ self valueForKey: @"servingDescription1" ]] );
}
-(NSString*)caloriesLongValueTip
{
    return [NSString stringWithFormat: @"%ld", [ self caloriesLongValue ] ];
}
- (NSString *)viteValue
{
    return( [ self CalculateValues:@"vitaminE" ] );
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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lf", endingValue ];
    } else {
        return [NSString stringWithFormat: @"%.0lf", endingValue ];
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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lfg", userValue ];
    } else {
        return [NSString stringWithFormat: @"%.0lfg", actualValue ];
    }
    
}
- (NSString *)totalValuePerc
{
    long totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
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
- (NSString *)calfromFatValuePerc
{
    double ValueForCalculation = [ self caloriesLongValue ];
    double Result = ( ValueForCalculation / 2000 )*100;
    
    //Round it to one decimal
    double ValueToDisplay = round( 10 * Result )/ 10;
    return [NSString stringWithFormat: @"%.0lf%%", ValueToDisplay ];
    
}
- (NSString *)proteinValuePerc
{
    long totalProt = [[ self valueForKey: @"protein" ] longValue ];
    long totalCals = [[ self valueForKey: @"calories" ] longValue ];
    
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
- (NSString *)servingAmount2Value
{
    NSString * serving2Value;
    
    serving2Value = [ self valueForKey: @"servingDescription2" ];
    
    if( NULL == serving2Value )
        return NULL;
    
    return( [ NSString stringWithFormat: @"%@", serving2Value ] );
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
};
- (NSString *)sugarsValuePerc
{
    long totalSugar = [[ self valueForKey: @"sugars" ] longValue ];
    
#if USEDTOBE
    
    double Result = ( totalSugar / [ self selectedServingWeightAsDouble ] ) * 100;
    return [NSString stringWithFormat: @"%.0lf%%", Result ];
    
#endif
    
    double Result = ( totalSugar / [ self selectedServingWeightAsDouble ] ) * 100;
    double	valueForDisplay = Result / 100;
    return [NSString stringWithFormat: @"%.0lf%%", valueForDisplay ];
    
}
- (NSString *)totalFatPercent
{
    double totalFat = [ [self valueForKey: @"saturatedFat"] doubleValue ] + [ [self valueForKey: @"monosaturatedFat"] doubleValue ] +
    [ [self valueForKey: @"polyFat"] doubleValue ];
    double result = ((( totalFat * [ self selectedServingWeightAsDouble ] ) / 100 ) / 0.63 );
    double valueToReturn = round( result );
    double userResult = round( totalFat );
    
    long user;
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return [NSString stringWithFormat: @"%.0lf%%", valueToReturn ];
    } else {
        return [NSString stringWithFormat: @"%.0lf%%", userResult ];
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


#pragma mark -- DOUBLES

-(double)calciumValueAsDouble
{
    return( [ self CalculateDouble:@"calcium" ] );
}
-(double)ironValueAsDouble
{
    return( [ self CalculateDouble:@"iron" ] );
}
-(double)monounsaturatedFatValueAsDouble
{
    return( [ self CalculateDouble:@"monosaturatedFat" ] );
}
-(double)polyunsaturatedFatValueAsDouble
{
    return( [ self CalculateDouble:@"polyFat" ] );
}
-(double)saturatedFatValueAsDouble
{
    return( [ self CalculateDouble:@"saturatedFat" ] );
}
-(double)vitaminCValueAsDouble
{
    return( [ self CalculateDouble:@"vitaminC" ] );
}
-(double)vitaminAValueAsDouble
{
    return( [ self CalculateDouble:@"vitaminA" ] );
}
-(double)vitaminEValueAsDouble
{
    return( [ self CalculateDouble:@"vitaminE" ] );
}

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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( valueToDisplay );
    } else {
        return( userResult );
    }
    
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

#pragma mark -- LONG

-(long)sodiumValueAsLong
{
    return( [ self CalculateLong:@"sodium" ] );
}
-(long)proteinValueAsLong
{
    return( [ self CalculateLong:@"protein" ] );
}
-(long)sugarsValueAsLong
{
    return( [ self CalculateLong:@"sugars" ] );
}
-(long)caloriesValue
{
    return( [ [ self valueForKey: @"calories" ] longValue ] );
}
-(long)dietaryFiberValueAsLong
{
    return( [ self CalculateLongAdj:@"dietaryFiber" ] );
}
-(long)cholesterolValueAsLong
{
    return( [ self CalculateLongAdj:@"cholesteral" ] );
}
-(long)carbsValueAsLong
{
    return( [ self CalculateLongAdj:@"carbs" ] );
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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        actualCalories = (( servingWeight * originalCalorieValue ) / 100 );
    } else {
        actualCalories = (originalCalorieValue);
    }
    
    return( actualCalories );
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


#pragma mark -- INT


-(int)servingWeight1Value
{
    return( [ [ self valueForKey: @"servingWeight1" ] intValue ] );
}

-(int) indexOfServingBeingDisplayed
{
    return( [[ self valueForKey: @"selectedServing" ] intValue ] );
}

#pragma mark Food Values -- FUNCTIONS


-(void)setIndexOfServingBeingDisplayed: (int) indexToSet
{
    [ self setValue: [ NSNumber numberWithInt: indexToSet ] forKey: @"selectedServing" ];
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
    
    long userValue = [[ self valueForKey: key] longValue] * QuantityActualValue;
    long actualValue = (( [[ self valueForKey: key] longValue] * [self selectedServingWeight ] ) / 100 )* QuantityActualValue;
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
    if (user == 0) {
        return( userValue );
    } else {
        return( actualValue );
    }
}

-(long)CalculateLongAdj: (NSString*)key
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
    long carbsL = [ [ self valueForKey: key ] longValue ] * QuantityActualValue;
    
    return( carbsL );
    
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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
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
    
    user = (int)[ self valueForKey: @"userDefined" ];
    
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
@end
