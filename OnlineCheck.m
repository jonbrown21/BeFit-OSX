//
//  OnlineCheck.m
//  BeFit
//
//  Created by Jon Brown on 1/1/14.
//
//

#import "OnlineCheck.h"

@implementation OnlineCheck
@synthesize webData;


// Since sandboxing has been implemented this code no longer works.
//
//- (IBAction)installWidget:(id)sender {
//    
//   
//    // This solution works well without sandboxing enabled.
//    // copy widgets to users library
//    NSError* error = nil;
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains
//    ( NSLibraryDirectory, NSUserDomainMask, YES);
//    
//    NSString *widgetsPath = [[paths objectAtIndex: 0] stringByAppendingPathComponent:
//                             @"Widgets/Calorie Tracker.wdgt"];
//    
//    // NSString *testUrl = @"~/Library/Widgets/test.dat";
//    if ([[NSFileManager defaultManager]fileExistsAtPath:widgetsPath]) {
//        NSLog(@"yes");
//    }
//    NSString *testUrl2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"Calorie Tracker.wdgt"];
//    if ([[NSFileManager defaultManager]fileExistsAtPath:testUrl2]) {
//        NSLog(@"yes");
//    }
//    
//    //[[NSFileManager defaultManager] removeItemAtPath:widgetsPath error:nil];
//    [[NSFileManager defaultManager]copyItemAtPath:testUrl2 toPath:widgetsPath error:&error];
//    
//    if (error != nil) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//    
//}



-(BOOL)checkInternet
{
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.google.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    if ([NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil])
        return TRUE;
    return FALSE;
}


- (IBAction)installWidget:(id)sender {
    
    

    NSString *item1 = [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a'];
    NSString *item2 = [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a'];
    NSString *item3 = [[NSUUID UUID] UUIDString];
    
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *regnamed = item3;
    

    if ([self checkInternet]) {
        
        NSLog(@"Online");
        
        // Set Reg Code
        
        
        [RegCode setStringValue:item3];
        [defaults setObject:regnamed forKey:@"reg-code"];
        [InstallButton setEnabled: NO];
        
        // Register Reg Code
        
        NSLog(@"web request started");
        NSString *post = [NSString stringWithFormat:@"firstName=%@&lastName=%@&eMail=%@", item1, item2, item3];
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
        NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
        
        NSLog(@"Post data: %@", post);
        
        NSMutableURLRequest *request = [NSMutableURLRequest new];
        [request setURL:[NSURL URLWithString:@"http://products.jonbrown.org/tracker/form.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:nil];
        
        if(theConnection) {
            webData = [NSMutableData data];
            
            NSLog(@"connection initiated");
        }
        
        // Start Downloading Widget
        
        #ifdef WEBSITE
        
        NSURL *url=[NSURL URLWithString:@"http://updates.jonbrown.org/downloads/ct.zip"];
        [[NSWorkspace sharedWorkspace] openURL:url];
        
        NSURL *url2=[NSURL URLWithString:@"http://updates.jonbrown.org/downloads/cc.zip"];
        [[NSWorkspace sharedWorkspace] openURL:url2];
        
        #else
        
        NSURL *url=[NSURL URLWithString:@"http://www.jonbrown.org/widgets/"];
        [[NSWorkspace sharedWorkspace] openURL:url];
        
        #endif
        
        
    } else {
        
        NSLog(@"Offline");

        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"You need to be online to download and install the widgets."];
        [alert runModal];
        
        
        
        
    }
    

    
   
    
}




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
    NSLog(@"connection received data");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connection received response");
    NSHTTPURLResponse *ne = (NSHTTPURLResponse *)response;
    if([ne statusCode] == 200) {
        NSLog(@"connection state is 200 - all okay");
    } else {
        NSLog(@"connection state is NOT 200");
    }
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Conn Err: %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Conn finished loading");
    NSString *html = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"OUTPUT:: %@", html);

}




-(void)awakeFromNib
{
    


    

}




@end
