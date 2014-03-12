//
//  LoginViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UIButton *loginbtn;
    
    IBOutlet UITextField *username;
    
    IBOutlet UITextField *password;
    IBOutlet UIButton *signupbtn;
    
    IBOutlet UIImageView *backgroundimgV;
    
    NSString *AddLoginDataStr;
    NSMutableArray *AddLoginmessage;

}

- (IBAction)loginactn:(UIButton *)sender;
- (IBAction)signactn:(UIButton *)sender;

@end
