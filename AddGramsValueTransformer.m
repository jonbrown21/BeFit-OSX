#import "AddGramsValueTransformer.h"


@implementation AddGramsValueTransformer

+ (Class)transformedValueClass
   {
    return [NSString class];
   }



+ (BOOL)allowsReverseTransformation
   {
    return NO;   
   }


- (id)transformedValue:(id)value
   {
   if (value == nil) return nil;
    
   NSString *StringToReturn;
    
   if ( [value respondsToSelector: @selector(stringValue)] )
      {
      StringToReturn = [ [ value stringValue ] stringByAppendingString: @"g" ];
      }
   else
      {
      NSLog( @"Value does not respond to stringValue." );
      StringToReturn = @"";
      }

   return StringToReturn;
   }



- (id)reverseTransformedValue:(id)value
   {
   if (value == nil) return nil;
    
   NSString* StringToReturn;
   
   if ( [ value respondsToSelector: @selector( stringValue ) ] )
      {
      NSString* OriginalString = [ value stringValue ];
      
      if ( ( [ OriginalString length ] > 0 ) && ( [ OriginalString characterAtIndex: [ OriginalString length ] - 1 ] == 'g' ) )
         {
         StringToReturn = [ OriginalString substringToIndex: [ OriginalString length ] - 1 ];
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
   }

@end
