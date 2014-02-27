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
    // Do any additional setup after loading the view from its nib.
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
