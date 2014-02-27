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
@end
