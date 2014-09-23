//
//  SSTextField.h
//
//  Created by Dan Messing on 2/13/10.
//  Copyright 2010 Stunt Software. All rights reserved.
//

// Mimics the appearance of Safari 4's URL text field.


#import <Cocoa/Cocoa.h>

// Our number field types
#define CINumberFieldTypeKeyPath    @"type"
#define IntegerCINumberFieldType    @"integer"
#define DoubleCINumberFieldType     @"double"
#define MoneyCINumberFieldType      @"money"

@interface SSTextField : NSTextField {
	NSString *type;
}
-(void) textDidEndEditing:(NSNotification *)aNotification;

@property (retain) NSString *type;
@end
