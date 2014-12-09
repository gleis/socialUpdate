//
//  postTwitter.m
//  socialUpdate
//
//  Created by Michael Gleissner on 8/10/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import "postTwitter.h"
#import "credentials.h"
#import "KeychainItemWrapper.h"

@implementation postTwitter

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}



- (void) postTwit: (UIImage*) timage: (NSString*) tPostText
{
    credentials *mycreds = [[credentials alloc] init];
    //NSArray *creds = [[NSArray alloc] init];
    [mycreds getCreds:@"twitter"];
    
    // create the URL for twitpic
    NSURL *postURL = [NSURL URLWithString:@"http://twitpic.com/api/uploadAndPost"];
    
    // create the connection
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:postURL
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
    
    // change type to POST (default is GET)
    [postRequest setHTTPMethod:@"POST"];
    
    
    // just some random text that will never occur in the body
    NSString *stringBoundary = @"0dsklemfdfsaWwWFdsjklwo453---This_Is_ThE_BoUnDaRyy---pqo";
    
    // header value
    NSString *headerBoundary = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",
                                stringBoundary];
    
    // set header
    [postRequest addValue:headerBoundary forHTTPHeaderField:@"Content-Type"];
    
    //---------------------------------------------------------
    // create data
    NSMutableData *postBody = [NSMutableData data];
    
   
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"socialUpdate" accessGroup:nil];
    
    NSString *username = [keychain objectForKey:(id)kSecAttrAccount];
    NSString *password = [keychain objectForKey:(id)kSecValueData];
    
    NSString *message = tPostText;
    
    // username part
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[username dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // password part
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // message part
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"message\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[message dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //-----------------------------------------------------------------------
    
    // media part
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"media\"; filename=\"dummy.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get the image data from main bundle directly into NSData object
    NSData *imageData = UIImageJPEGRepresentation(timage, 90);
    
    // add it to body
    [postBody appendData:imageData];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //-----------------------------------------------------------------------
    
        
    // add body to post
    [postRequest setHTTPBody:postBody];
    
    // pointers to some necessary objects
    NSURLResponse* response;
    NSError* error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
    
    
    NSString *responseString = [[[NSString alloc] initWithBytes:[responseData bytes]
                                                         length:[responseData length]
                                                       encoding:NSUTF8StringEncoding] autorelease];
    
    NSRange textRange;
    textRange = [[responseString lowercaseString] rangeOfString:[@"err code=" lowercaseString]];
    if (textRange.location != NSNotFound && [username length] != 0)
    {
        //Does contain err string
        //NSLog(@"There is an error. We should get the credentials again");
        [keychain resetKeychainItem];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Invalid Credentials - Try Again" 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [mycreds getCreds:@"twitter - invalid password"];
    }
}

@end
