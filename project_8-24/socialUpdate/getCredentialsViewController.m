//
//  getCredentialsViewController.m
//  socialUpdate
//
//  Created by Michael Gleissner on 8/14/11.
//  Copyright 2011 Harper College. All rights reserved.
//


//This presents a modal view that collects the user's authentication information
//Mainly, username and password.

#import "getCredentialsViewController.h"
#import "KeychainItemWrapper.h"

@implementation getCredentialsViewController

@synthesize serviceName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the service name so it can be seen in the view.
    lblServiceName.text = serviceName;
    
}


//This allows the keyboard to hide after editing textfields
- (BOOL)textFieldsShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//This allows the keyboard to hide after editing textfields
//Attached to the didEndEditing action of the textfields
- (IBAction)dismissKeyboard:(id)sender
{
    //[txtUsername becomeFirstResponder];
    //[txtUsername resignFirstResponder];
    [txtPassword becomeFirstResponder];
    [txtPassword resignFirstResponder];

}


- (void)viewDidUnload
{
    [txtUsername release];
    txtUsername = nil;
    [txtPassword release];
    txtPassword = nil;
    [lblServiceName release];
    lblServiceName = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [txtUsername release];
    [txtPassword release];
    [lblServiceName release];
    [super dealloc];
}
- (IBAction)writeCreds:(id)sender {
      
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"socialUpdate" accessGroup:nil];
    
    // Store username to keychain 	
    if ([txtUsername text])
        [keychain setObject:[txtUsername text] forKey:(id)kSecAttrAccount];
    
    // Store password to keychain
    if ([txtPassword text])
        [keychain setObject:[txtPassword text] forKey:(id)kSecValueData];  
    
    if (![[txtUsername text] length] == 0 && ![[txtPassword text] length] == 0)
        [self dismissModalViewControllerAnimated:YES];
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a username and password" 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

    
    
    //[self dismissModalViewControllerAnimated:YES];
        
        
}



@end
