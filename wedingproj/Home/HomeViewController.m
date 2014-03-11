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
#import "ReferViewController.h"
#import "SelectEventRsvpViewController.h"
#import "GroupViewController.h"
#import "VendorListViewController.h"

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
    [self image];
    
    self.navigationItem.hidesBackButton = YES;
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
        [SSKeychain deletePasswordForService:@"LoginViewController" account:@"User" error:nil];
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
//    VendorViewController *VendorVC =[[VendorViewController alloc]init];
//    [self.navigationController pushViewController:VendorVC animated:YES];
    
    VendorListViewController *VendorVC =[[VendorListViewController alloc]init];
    [self.navigationController pushViewController:VendorVC animated:YES];
}

- (IBAction)GroupAction:(id)sender {
    GroupViewController *GroupVC =[[GroupViewController alloc]init];
    [self.navigationController pushViewController:GroupVC animated:YES];
    
}

- (IBAction)RSVPactn:(UIButton *)sender {
    SelectEventRsvpViewController *rsvpVC=[[SelectEventRsvpViewController alloc]init];
    [self.navigationController pushViewController:rsvpVC animated:YES];
    
}

- (IBAction)referactn:(UIButton *)sender {
    ReferViewController *ReferVC =[[ReferViewController alloc]init];
    [self.navigationController pushViewController:ReferVC animated:YES];

}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [guestbtn setBackgroundImage:[UIImage imageNamed:@"guest-list-320.png"] forState:UIControlStateNormal];
        [eventbtn setBackgroundImage:[UIImage imageNamed:@"events-320.png"] forState:UIControlStateNormal];
        [invitationbtn setBackgroundImage:[UIImage imageNamed:@"invitations-320.png"] forState:UIControlStateNormal];
        [rsvpbtn setBackgroundImage:[UIImage imageNamed:@"status-320.png"] forState:UIControlStateNormal];
        [vendorbtn setBackgroundImage:[UIImage imageNamed:@"vendors-320.png"] forState:UIControlStateNormal];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgets-320.png"] forState:UIControlStateNormal];
        [groupbtn setBackgroundImage:[UIImage imageNamed:@"group-320.png"] forState:UIControlStateNormal];
        [todolistbtn setBackgroundImage:[UIImage imageNamed:@"do-list-320.png"] forState:UIControlStateNormal];
        
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
            [guestbtn setBackgroundImage:[UIImage imageNamed:@"guest-list.png"] forState:UIControlStateNormal];
            [eventbtn setBackgroundImage:[UIImage imageNamed:@"events.png"] forState:UIControlStateNormal];
            [invitationbtn setBackgroundImage:[UIImage imageNamed:@"invitations.png"] forState:UIControlStateNormal];
            [rsvpbtn setBackgroundImage:[UIImage imageNamed:@"status.png"] forState:UIControlStateNormal];
            [vendorbtn setBackgroundImage:[UIImage imageNamed:@"vendors.png"] forState:UIControlStateNormal];
            [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgets.png"] forState:UIControlStateNormal];
            [groupbtn setBackgroundImage:[UIImage imageNamed:@"group-320.png"] forState:UIControlStateNormal];
            [todolistbtn setBackgroundImage:[UIImage imageNamed:@"do-list.png"] forState:UIControlStateNormal];
        }
        
    }
}

@end
