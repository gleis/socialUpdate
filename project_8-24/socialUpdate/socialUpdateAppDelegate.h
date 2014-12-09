//
//  socialUpdateAppDelegate.h
//  socialUpdate
//
//  Created by Michael Gleissner on 8/9/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socialUpdateViewController.h"

@class socialUpdateViewController;

@interface socialUpdateAppDelegate : NSObject <UIApplicationDelegate>
{
    //postFacebook* postFB;
    //Facebook *facebook;
    socialUpdateViewController* viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet socialUpdateViewController *viewController;
//@property (nonatomic, retain) IBOutlet postFacebook *postFB;

@end
