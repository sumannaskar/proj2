//
//  WelcomeViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController
{
    
    IBOutlet UIButton *loginbtn;
    
    IBOutlet UIButton *signupbtn;
    
    IBOutlet UIButton *featuresbtn;
    
    IBOutlet UIButton *helpbtn;
    IBOutlet UIButton *aboutusbtn;
    IBOutlet UIButton *insbtn;
    IBOutlet UIImageView *backgroundimgV;
}


- (IBAction)loginactn:(UIButton *)sender;
- (IBAction)signactn:(UIButton *)sender;
- (IBAction)featuresactn:(UIButton *)sender;

@end
