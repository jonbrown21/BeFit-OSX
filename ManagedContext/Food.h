#import <Cocoa/Cocoa.h>


@interface Food : NSManagedObject {

}

- (NSString *)nameValue;
- (void)setNameValue:(NSString *)nameToUse; 
- (void)setCalValue:(NSString *)calToUse;

- (NSString *)proteinValue;
- (NSString *)proteinValuePerc;
-(long)proteinValueAsLong;

- (NSString *)sugarsValue;
- (NSString *)sugarsValuePerc;
-(long)sugarsValueAsLong;

- (NSString *)dietaryFiberValue;
- (NSString *)dietaryFiberPercent;
-(long)dietaryFiberValueAsLong;

- (NSString *)carbsValue;
- (NSString *)carbsPercent;
-(long)carbsValueAsLong;

- (NSString *)sodiumValue;
- (NSString *)sodiumPercent;
-(long)sodiumValueAsLong;

- (NSString *)cholesterolValue;
- (NSString *)cholesterolPercent;
-(long)cholesterolValueAsLong;

- (NSString *)saturatedFatValue;
- (NSString *)saturatedFatPercent;
-(double)saturatedFatValueAsDouble;



- (NSString *)monounsaturatedFatValue;
-(double)monounsaturatedFatValueAsDouble;


- (NSString *)polyunsaturatedFatValue;
-(double)polyunsaturatedFatValueAsDouble;

-(double)totalFatValueAsDouble;
- (NSString *)totalFatValue;
- (NSString *)totalFatPercent;

-(int)servingWeight1Value;

-(long)caloriesLongValue;
-(long)ratingLongValue;
-(long)calFromDiet;

- (NSString *)caloriesFromFatValue;

-(long)quantityLongValue;

- (NSString *)vitaminAValue;
-(double)vitaminAValueAsDouble;

- (NSString *)vitaminCValue;
- (NSString *)vitaminCValuePerc;
-(double)vitaminCValueAsDouble;

- (NSString *)ironValue;
- (NSString *)ironValuePerc;
-(double)ironValueAsDouble;

- (NSString *)calciumValue;
- (NSString *)calciumValuePerc;
-(double)calciumValueAsDouble;

-(double)vitaminEValueAsDouble;

- (NSString *)servingAmountValue;
- (NSString *)servingAmount1Value;
- (NSString *)servingAmount2Value;

- (double)selectedServingWeightAsDouble;
- (int)indexOfServingBeingDisplayed;
- (void)setIndexOfServingBeingDisplayed: (int) indexToSet;
- (BOOL)hideServing;
@end
