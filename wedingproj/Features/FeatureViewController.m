//
//  FeatureViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "FeatureViewController.h"
#import "DescriptionViewController.h"

@interface FeatureViewController ()

@end

@implementation FeatureViewController

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

- (IBAction)eventactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Event";
    descipVC.descriptiontxt=@"Event";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)todolistactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"To-Do-List";
     descipVC.descriptiontxt=@"To-Do-List";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)budgetactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Budget";
     descipVC.descriptiontxt=@"Budget";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)vendoractn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Vendor";
     descipVC.descriptiontxt=@"Vendor";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)guestlistactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Guest";
     descipVC.descriptiontxt=@"Guest";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)invitationactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Invitations";
     descipVC.descriptiontxt=@"Invitations";
    [self.navigationController pushViewController:descipVC animated:YES];
}
@end
