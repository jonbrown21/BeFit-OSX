#import <Cocoa/Cocoa.h>


@interface Food : NSManagedObject {

}

- (NSString *)nameValue;
- (void)setNameValue:(NSString *)nameToUse; 
- (void)setCalValue:(NSString *)calToUse;

- (NSString *)proteinValue;
-(long)proteinValueAsLong;

- (NSString *)sugarsValue;
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

-(long)caloriesValue;
-(int)servingWeight1Value;

-(long)caloriesLongValue;
-(long)ratingLongValue;


- (NSString *)caloriesFromFatValue;

-(long)quantityLongValue;

- (NSString *)vitaminAValue;
-(double)vitaminAValueAsDouble;

- (NSString *)vitaminCValue;
-(double)vitaminCValueAsDouble;

- (NSString *)ironValue;
-(double)ironValueAsDouble;

- (NSString *)calciumValue;
-(double)calciumValueAsDouble;

-(double)vitaminEValueAsDouble;

- (NSString *)servingAmountValue;
- (NSString *)servingAmount1Value;
- (NSString *)servingAmount2Value;

- (double)selectedServingWeightAsDouble;
- (int)indexOfServingBeingDisplayed;
- (void)setIndexOfServingBeingDisplayed: (int) indexToSet;

@end
