#import "ColumnAttributeSelector.h"
#import "BeFit_AppDelegate.h"
#import "FoodTableDragSupport.h"
#import "BeFit-Swift.h"

@implementation ColumnAttributeSelector

#define ADD_GRAMS [ NSDictionary dictionaryWithObject:@"addGrams" forKey: NSValueTransformerNameBindingOption ]
#define ADD_MG [ NSDictionary dictionaryWithObject:@"addMG" forKey: NSValueTransformerNameBindingOption ]

- (IBAction)CalciumSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.calciumValueAsDouble" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Calc" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
    
    NSLog(@"Itinial Width %d", initialWidth);
    NSLog(@"Final Width %d", finalwidth);
}



- (IBAction)CarbohydrateSelected:(id)sender
{
    
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.carbsValueAsLong" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Carbs" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)CholesterolSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.cholesterolValueAsLong" options: ADD_MG ];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Chol" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)DietaryFiberSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.dietaryFiberValueAsLong" options: ADD_GRAMS ];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Fiber" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)IronSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.ironValueAsDouble" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Iron" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)ProteinSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.proteinValueAsLong" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Protein" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)SaturatedFatSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.saturatedFatValueAsDouble" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Sat Fat" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)SodiumSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.sodiumValueAsLong" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Sodium" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)SugarsSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.sugarsValueAsLong" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Sugars" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)TotalFatSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.totalFatValueAsDouble" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Fat" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}

- (IBAction)PolyFatSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.polyunsaturatedFatValueAsDouble" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Poly-Fat" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}

- (IBAction)MonoFatSelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.monounsaturatedFatValueAsDouble" options:ADD_GRAMS];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Mono-Fat" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)VitaminASelected:(id)sender
{
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.vitaminAValueAsDouble" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Vit A" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)VitaminCSelected:(id)sender
{
    
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.vitaminCValueAsDouble" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Vit C" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}



- (IBAction)VitaminESelected:(id)sender
{
    
    int initialWidth = [MixNameColumn width];
    int finalwidth;
    
    if (initialWidth == 100 || initialWidth == 70) {
        finalwidth =  initialWidth - 1;
    } else {
        finalwidth =  initialWidth + 1;
    }
    [MixNameColumn setResizingMask:NSTableColumnUserResizingMask];
    [MixNameColumn setWidth:finalwidth];
    
    [ CoumnBeingControlled bind: @"value" toObject:FoodArrayController
                    withKeyPath:@"arrangedObjects.vitaminEValueAsDouble" options:ADD_MG];
    
    [ [ CoumnBeingControlled headerCell ] setStringValue: @"  Vit E" ];
    
    [ ScrollViewBeingEdited setNeedsDisplay: YES ];
}

@end
