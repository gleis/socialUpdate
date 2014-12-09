//
//  getCredentialsViewController.h
//  socialUpdate
//
//  Created by Michael Gleissner on 8/14/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface getCredentialsViewController : UIViewController
{
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    IBOutlet UILabel *lblServiceName;
    NSString *serviceName;
    //NSArray *credArray;
}
- (IBAction)writeCreds:(id)sender;
//- (NSArray*)returnCreds: (NSArray*) theArray;

- (BOOL)textFieldsShouldReturn:(UITextField *)textField;
- (IBAction)dismissKeyboard:(id)sender;


@property(nonatomic, retain) NSString *serviceName;

@end
