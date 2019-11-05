/* ColumnAttributeSelector */

#import <Cocoa/Cocoa.h>

@interface ColumnAttributeSelector : NSObject
{
    IBOutlet NSTableColumn * MixNameColumn;
    IBOutlet id CoumnBeingControlled;
    IBOutlet id FoodArrayController;
    IBOutlet id ScrollViewBeingEdited;
}
- (IBAction)CalciumSelected:(id)sender;
- (IBAction)CarbohydrateSelected:(id)sender;
- (IBAction)CholesterolSelected:(id)sender;
- (IBAction)DietaryFiberSelected:(id)sender;
- (IBAction)IronSelected:(id)sender;
- (IBAction)ProteinSelected:(id)sender;
- (IBAction)SaturatedFatSelected:(id)sender;
- (IBAction)SodiumSelected:(id)sender;
- (IBAction)SugarsSelected:(id)sender;
- (IBAction)TotalFatSelected:(id)sender;
- (IBAction)MonoFatSelected:(id)sender;
- (IBAction)PolyFatSelected:(id)sender;
- (IBAction)VitaminASelected:(id)sender;
- (IBAction)VitaminCSelected:(id)sender;
- (IBAction)VitaminESelected:(id)sender;
@end
