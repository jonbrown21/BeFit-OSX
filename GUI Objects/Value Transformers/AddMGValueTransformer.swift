//
//  AddMGValueTransformer.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/5/19.
//

import Foundation
import Cocoa

@objc(AddMGValueTransformer)
class AddMGValueTransformer: ValueTransformer {
    static let name = NSValueTransformerName(rawValue: "addMG")
    
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        
        guard let nsNumber = value as? NSNumber else {
            print("Value does not respond to stringValue.")
            return ""
        }
        
        return nsNumber.stringValue.appending("mg")
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        assertionFailure()
        return super.reverseTransformedValue(value)
        
        /*
         if (value == nil) return nil;
         
         NSString* StringToReturn;
         
         if ( [ value respondsToSelector: @selector( stringValue ) ] )
         {
         NSString* OriginalString = [ value stringValue ];
         
         if ( ( [ OriginalString length ] > 0 ) && ( [ OriginalString characterAtIndex: [ OriginalString length ] - 1 ] == 'g' ) &&
         ( [ OriginalString characterAtIndex: [ OriginalString length ] -  2 ] == 'm' ) )
         {
         StringToReturn = [ OriginalString substringToIndex: [ OriginalString length ] - 2 ];
         }
         else
         {
         StringToReturn = @"";
         }
         }
         else
         {
         NSLog( @"Value does not respond to StringValue2" );
         StringToReturn = @"";
         }
         
         return StringToReturn;
         */
    }
    
}
