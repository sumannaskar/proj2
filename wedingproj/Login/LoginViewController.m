//
//  LoginViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginactn:(UIButton *)sender {
    
    HomeViewController *HomeVC =[[HomeViewController alloc]init];
    [self.navigationController pushViewController:HomeVC animated:YES];
    
}

- (IBAction)signactn:(UIButton *)sender
{
    RegisterViewController *RegisVC =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisVC animated:YES];
}
@end
