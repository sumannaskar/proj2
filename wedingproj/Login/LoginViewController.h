//
//  LoginViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    
    IBOutlet UIButton *loginbtn;
    
    
    IBOutlet UIButton *signupbtn;
}

- (IBAction)loginactn:(UIButton *)sender;
- (IBAction)signactn:(UIButton *)sender;

@end
