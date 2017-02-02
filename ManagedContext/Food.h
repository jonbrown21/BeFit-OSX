#import <Cocoa/Cocoa.h>


@interface Food : NSManagedObject {

}

-(BOOL)hideServing;

-(NSString *)calciumValue;
-(NSString *)calciumValuePerc;
-(NSString *)caloriesFromFatValue;
-(NSString *)carbsPercent;
-(NSString *)carbsValue;
-(NSString *)cholesterolPercent;
-(NSString *)cholesterolValue;
-(NSString *)dietaryFiberPercent;
-(NSString *)dietaryFiberValue;
-(NSString *)ironValue;
-(NSString *)ironValuePerc;
-(NSString *)monounsaturatedFatValue;
-(NSString *)nameValue;
-(NSString *)polyunsaturatedFatValue;
-(NSString *)proteinValue;
-(NSString *)proteinValuePerc;
-(NSString *)saturatedFatPercent;
-(NSString *)saturatedFatValue;
-(NSString *)servingAmount1Value;
-(NSString *)servingAmount2Value;
-(NSString *)servingAmountValue;
-(NSString *)sodiumPercent;
-(NSString *)sodiumValue;
-(NSString *)sugarsValue;
-(NSString *)sugarsValuePerc;
-(NSString *)totalFatPercent;
-(NSString *)totalFatValue;
-(NSString *)vitaminAValue;
-(NSString *)vitaminCValue;
-(NSString *)vitaminCValuePerc;

-(void)setCalValue:(NSString *)calToUse;
-(void)setIndexOfServingBeingDisplayed: (int) indexToSet;
-(void)setNameValue:(NSString *)nameToUse;

-(double)calciumValueAsDouble;
-(double)ironValueAsDouble;
-(double)monounsaturatedFatValueAsDouble;
-(double)polyunsaturatedFatValueAsDouble;
-(double)saturatedFatValueAsDouble;
-(double)totalFatValueAsDouble;
-(double)vitaminAValueAsDouble;
-(double)vitaminCValueAsDouble;
-(double)vitaminEValueAsDouble;
-(double)selectedServingWeightAsDouble;

-(int)servingWeight1Value;
-(int)indexOfServingBeingDisplayed;

-(long)calFromDiet;
-(long)caloriesLongValue;
-(long)carbsValueAsLong;
-(long)cholesterolValueAsLong;
-(long)dietaryFiberValueAsLong;
-(long)proteinValueAsLong;
-(long)quantityLongValue;
-(long)ratingLongValue;
-(long)sodiumValueAsLong;
-(long)sugarsValueAsLong;

@end
