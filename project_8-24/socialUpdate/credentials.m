//
//  credentials.m
//  socialUpdate
//
//  Created by Michael Gleissner on 8/13/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import "credentials.h"
#import "socialUpdateAppDelegate.h"
#import "KeychainItemWrapper.h"
#import "postTwitter.h"


@implementation credentials
//@synthesize credView;


- (id)init
{
    self = [super init];
    if (self) {
               
    }
    
    return self;
}

-(void) getCreds: (NSString*) service
{
    
    
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"socialUpdate" accessGroup:nil];
    
    username = [keychain objectForKey:(id)kSecAttrAccount];
    password = [keychain objectForKey:(id)kSecValueData];
    
    if (username.length  == 0 || password.length == 0)
    {   
        getCredentialsViewController *myView = [[getCredentialsViewController alloc] init];
        socialUpdateAppDelegate *appDelegate = (socialUpdateAppDelegate *)[[UIApplication sharedApplication] delegate];
        myView.serviceName = service;
        [[appDelegate viewController] presentModalViewController:myView animated:YES];
    }
    
    
}



- (void)dealloc {
        [super dealloc];
}

@end
