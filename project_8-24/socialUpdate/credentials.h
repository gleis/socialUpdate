//
//  credentials.h
//  socialUpdate
//
//  Created by Michael Gleissner on 8/13/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "getCredentialsViewController.h"

@interface credentials : UIViewController
{
    NSString *username;
    NSString *password;
    NSString *myService;
    getCredentialsViewController *credView;
    
}

-(void) getCreds: (NSString*) service;
//-(void) writeCreds: (NSString*) service;
//@property(nonatomic, retain) getCredentialsViewController *credView;

@end
