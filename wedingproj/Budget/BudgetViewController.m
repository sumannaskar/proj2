//
//  BudgetViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "BudgetViewController.h"
#import "CalculateBudget.h"
#import "ManageBudget.h"


@interface BudgetViewController ()

@end

@implementation BudgetViewController

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
    [self image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ManageBudget:(id)sender {
    
    ManageBudget *ManageBudget_ = [[ManageBudget alloc]init];
    [self.navigationController pushViewController:ManageBudget_ animated:YES];
}

- (IBAction)CalculateBudget:(id)sender {
    CalculateBudget *CalculateBudget_ = [[CalculateBudget alloc]init];
    [self.navigationController pushViewController:CalculateBudget_ animated:YES];
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [CalculateBudgetbtn setBackgroundImage:[UIImage imageNamed:@"calculate-bt_iphone.png"] forState:UIControlStateNormal];
        [ManageBudgetbtn setBackgroundImage:[UIImage imageNamed:@"manage-bt_iphone.png"] forState:UIControlStateNormal];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            [CalculateBudgetbtn setBackgroundImage:[UIImage imageNamed:@"calculate.png"] forState:UIControlStateNormal];
            [ManageBudgetbtn setBackgroundImage:[UIImage imageNamed:@"manage-bt.png"] forState:UIControlStateNormal];
            
        }
        
    }
}

@end
