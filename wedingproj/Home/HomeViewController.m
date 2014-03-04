//
//  HomeViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "HomeViewController.h"
#import "GuestViewController.h"
#import "InvViewController.h"
#import "EventViewController.h"
#import "TodolistViewController.h"
#import "BudgetViewController.h"
#import "VendorViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "WelcomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    self.logoutButton=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(LogOut:)];
    [self.navigationItem setRightBarButtonItem:self.logoutButton];
       // Do any additional setup after loading the view from its nib.
}
-(IBAction)LogOut:(UIBarButtonItem *)sender
{
    //show confirmation message to user
    UIAlertView* alert1 = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                     message:@"Do you want to log out?"
                                                    delegate:self
                                           cancelButtonTitle:@"No"
                                           otherButtonTitles:@"Yes", nil];
    [alert1 show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)  // 0 == the cancel button
    {
        [SSKeychain deletePasswordForService:@"LogIn" account:@"User" error:nil];
        //[SSKeychain deletePasswordForService:@"LogIn" account:@"Password" error:nil];
        
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc]init];
        [self.navigationController pushViewController:welcomeVC animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)guestactn:(UIButton *)sender
{
    GuestViewController *GuestVC =[[GuestViewController alloc]init];
    [self.navigationController pushViewController:GuestVC animated:YES];
    
}
- (IBAction)invitationactn:(UIButton *)sender
{
    InvViewController *InviVC =[[InvViewController alloc]init];
    [self.navigationController pushViewController:InviVC animated:YES];
    
}
- (IBAction)eventactn:(UIButton *)sender
{
    EventViewController *EventVC =[[EventViewController alloc]init];
    [self.navigationController pushViewController:EventVC animated:YES];
    //NSString *a;
}
- (IBAction)todolistactn:(UIButton *)sender
{
    TodolistViewController *TodoVC =[[TodolistViewController alloc]init];
    [self.navigationController pushViewController:TodoVC animated:YES];
}
- (IBAction)budgetactn:(UIButton *)sender
{
    BudgetViewController *budgetVC =[[BudgetViewController alloc]init];
    [self.navigationController pushViewController:budgetVC animated:YES];
    NSLog(@"suman");
    NSLog(@"suman");
    NSLog(@"suman");
    NSLog(@"suman");
    NSLog(@"demo");
}
- (IBAction)vendoractn:(UIButton *)sender
{
    VendorViewController *VendorVC =[[VendorViewController alloc]init];
    [self.navigationController pushViewController:VendorVC animated:YES];
}
@end
