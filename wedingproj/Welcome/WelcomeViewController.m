//
//  WelcomeViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#include "RegisterViewController.h"
#import "FeatureViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton = YES;
    [self image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginactn:(UIButton *)sender {
    
    LoginViewController *loginVC =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];

}

- (IBAction)signactn:(UIButton *)sender {
    
    RegisterViewController *RegisVC =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisVC animated:YES];
}

- (IBAction)featuresactn:(UIButton *)sender {
    
    FeatureViewController *FeaturVC =[[FeatureViewController alloc]init];
    [self.navigationController pushViewController:FeaturVC animated:YES];
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [loginbtn setBackgroundImage:[UIImage imageNamed:@"login-320.png"] forState:UIControlStateNormal];
        [signupbtn setBackgroundImage:[UIImage imageNamed:@"sign-up-320.png"] forState:UIControlStateNormal];
        [aboutusbtn setBackgroundImage:[UIImage imageNamed:@"about-us-320.png"] forState:UIControlStateNormal];
        [helpbtn setBackgroundImage:[UIImage imageNamed:@"help-320.png"] forState:UIControlStateNormal];
        [featuresbtn setBackgroundImage:[UIImage imageNamed:@"feature-320.png"] forState:UIControlStateNormal];
        [insbtn setBackgroundImage:[UIImage imageNamed:@"instruction-320.png"] forState:UIControlStateNormal];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"640-1136.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"320-480.jpg"]];
            
        }
        else
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"320-480.jpg"]];
           
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"768-1004.jpg"]];
            [loginbtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
            [signupbtn setBackgroundImage:[UIImage imageNamed:@"sign-up.png"] forState:UIControlStateNormal];
            [aboutusbtn setBackgroundImage:[UIImage imageNamed:@"about-us.png"] forState:UIControlStateNormal];
            [helpbtn setBackgroundImage:[UIImage imageNamed:@"help.png"] forState:UIControlStateNormal];
            [featuresbtn setBackgroundImage:[UIImage imageNamed:@"feature.png"] forState:UIControlStateNormal];
            [insbtn setBackgroundImage:[UIImage imageNamed:@"instruction.png"] forState:UIControlStateNormal];
        }
        
    }
}


@end
