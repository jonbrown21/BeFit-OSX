//
//  RightGraphView.h
//  BeFit
//
//  Created by Jon Brown on 12/3/13.
//
//

#import <WebKit/WebKit.h>

@interface RightGraphView : WebView
{
    IBOutlet id FoodListArrayController;
    IBOutlet id FoodListController;
    IBOutlet id GUIControllerObject;
    
    IBOutlet NSTextField *textField;
    IBOutlet NSTextField *textField2;
    IBOutlet NSTextField *textField3;
    IBOutlet NSTextField *textField4;
    IBOutlet NSTextField *textField5;
    IBOutlet NSTextField *textField6;
    IBOutlet NSTextField *textField7;
    IBOutlet NSTextField *textField8;
    IBOutlet NSTextField *textField9;
    IBOutlet NSTextField *BadgeCount;
}
@end