//
//  postFacebook.h
//  socialUpdate
//
//  Created by Michael Gleissner on 8/12/11.
//  Copyright 2011 Harper College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

@interface postFacebook : NSObject <FBSessionDelegate, FBRequestDelegate> {
    Facebook *facebook;
    UIImage *myFBImage;
    NSString *myFBPostText;
    NSString * encodedString;
    NSData *postData;
}

//-(void) postFB: (UIImage*) fbImage: (NSString*) fbPostText: (Facebook*) myFaceBook;
-(void) postFB: (UIImage*) fbImage: (Facebook*) myFaceBook;

//@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSString *myFBPostText;

@end
