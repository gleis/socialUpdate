//
//  socialUpdateViewController.m
//  socialUpdate
//
//  Created by Michael Gleissner on 8/9/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import "socialUpdateViewController.h"
#import "postTwitter.h"
#import "postFacebook.h"
#import "KeychainItemWrapper.h"

// This is the App ID that was generated from the facebook developer portal
static NSString* myAppId = @"175099815895295";

@implementation socialUpdateViewController

@synthesize postImage;
@synthesize postTextStatic;
@synthesize facebook = _facebook;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
	#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [staticPostImage release];
    staticPostImage = nil;
    [staticPostText release];
    staticPostText = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [staticPostText becomeFirstResponder];
    [staticPostText resignFirstResponder];
}
    
- (void)dealloc {
    [staticPostImage release];
    [staticPostText release];
    [super dealloc];
}

//Call the Twitter class
- (IBAction)sendToTwitter:(id)sender {
    postTwitter *pTwitter = [[postTwitter alloc] init];
    [pTwitter postTwit: staticPostImage.image: staticPostText.text];
}

//Call the Facebook class
- (IBAction)sendToFB:(id)sender {
    _facebook = [[Facebook alloc] initWithAppId:myAppId];
    postFacebook *pFacebook = [[postFacebook alloc] init];
    pFacebook.myFBPostText = staticPostText.text;
    [pFacebook postFB: staticPostImage.image: _facebook];
    //[pFacebook postFB: staticPostImage.image: staticPostText.text: _facebook];
}

- (IBAction)delPlist:(id)sender {
    
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"socialUpdate" accessGroup:nil];
    
    [keychain resetKeychainItem];
    
    NSLog(@"Keychain for app cleared");    
    
}

    
@end
