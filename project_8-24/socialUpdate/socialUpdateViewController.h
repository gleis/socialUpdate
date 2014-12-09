//
//  socialUpdateViewController.h
//  socialUpdate
//
//  Created by Michael Gleissner on 8/9/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"    

@interface socialUpdateViewController : UIViewController <FBSessionDelegate, FBRequestDelegate>
{
    IBOutlet UIImageView *staticPostImage;
    IBOutlet UITextField *staticPostText;
    Facebook* facebook;

    
}
- (IBAction)delPlist:(id)sender;
- (IBAction)sendToFB:(id)sender;
- (IBAction)sendToTwitter:(id)sender;

- (BOOL)textFieldsShouldReturn:(UITextField *)textField;
- (IBAction)dismissKeyboard:(id)sender;

@property(nonatomic, retain) UILabel *postTextStatic;
@property(nonatomic, retain) UIImage *postImage;
@property (nonatomic, retain) Facebook *facebook;

@end
