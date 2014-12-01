//
//  SSTextField.m
//
//  Created by Dan Messing on 2/13/10.
//  Copyright 2010 Stunt Software. All rights reserved.
//

// Mimics the appearance of Safari 4's URL text field.

#import "SSTextField.h"


@implementation SSTextField
@synthesize type;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
		
		[self setDrawsBackground:NO];
		
		if ([[self cell] controlSize] == NSMiniControlSize) {	// doesn't work well for mini size - text needs to be adjusted up
			[self setFont:[NSFont systemFontOfSize:8.0]];
		}
		else if ([[self cell] controlSize] == NSSmallControlSize) {
			[self setFont:[NSFont systemFontOfSize:9.4]];
		}
		else {
			[self setFont:[NSFont systemFontOfSize:11.88]];
		}

    }
    return self;
}


-(void) textDidEndEditing:(NSNotification *)aNotification {
    
    // Integer fields
    if ([[self type] isEqualToString:IntegerCINumberFieldType]) {
        [self setIntValue:[self intValue]];
    }
    // Double fields
    else if ([[self type] isEqualToString:DoubleCINumberFieldType]) {
        [self setDoubleValue:[self doubleValue]];
    }
    // Money fields
    else if ([[self type] isEqualToString:MoneyCINumberFieldType]) {
        [self setStringValue:[NSString stringWithFormat:@"$%.02f",
                              [[[self stringValue] stringByReplacingOccurrencesOfString:@"$" withString:@""] floatValue] ]];
    }
    [super textDidEndEditing:aNotification];
}

- (void) setValue:(id)value forKeyPath:(NSString *)keyPath {
    if ([keyPath isEqualToString:CINumberFieldTypeKeyPath]) [self setType:value];
    else [self setValue:value forUndefinedKey:keyPath];
}

@end
