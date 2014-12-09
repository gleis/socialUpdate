//
//  postFacebook.m
//  socialUpdate
//
//  Created by Michael Gleissner on 8/12/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import "postFacebook.h"

@implementation postFacebook

@synthesize myFBPostText;

// use these as the keys for storing the token and date in user defaults
#define ACCESS_TOKEN_KEY @"fb_access_token"
#define EXPIRATION_DATE_KEY @"fb_expiration_date"


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//-(void) postFB: (UIImage*) fbImage: (NSString*) fbPostText: (Facebook*) myFaceBook
-(void) postFB: (UIImage*) fbImage: (Facebook*) myFaceBook
{
    
    facebook = myFaceBook; 
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream", nil];
    
    if ([facebook isSessionValid]) {
        [facebook authorize:permissions delegate:self];
    }
    //[facebook authorize:permissions delegate:self];
    
    
    [permissions release];
    
    
    myFBImage = fbImage;
    
}


//delegate method - this creates the post
- (void)fbDidLogin {
    //Save the login token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream", nil];
    //[facebook authorize:permissions delegate:self];
    
    //convert the UIImage to NSData
    NSData *data = UIImageJPEGRepresentation(myFBImage, 90);
    UIImage *img  = [[UIImage alloc] initWithData:data];
    
     
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   img, @"picture",
                                   myFBPostText, @"message", //space in this text crashes the app. Need to URL encode this string.
                                   nil];
    
    [facebook requestWithGraphPath:@"me/photos/"
                          andParams:params
                      andHttpMethod:@"POST"
                        andDelegate:self];
    
    [img release];

    
}

//delegate method
-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

//delegate method
- (void)request:(FBRequest *)request didLoad:(id)result {
	if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}
	NSLog(@"Result of API call: %@", result);
}

//delegate method
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
}


- (void)dealloc
{
    [facebook release];
    [myFBImage release];
    [myFBPostText release];
    [super dealloc];
}


@end
