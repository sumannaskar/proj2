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
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view from its nib.
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
@end
