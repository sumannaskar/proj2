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
    [self image];
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

- (IBAction)rsvpactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"RSVP Stus";
    descipVC.descriptiontxt=@"Show RSVP Status";
    [self.navigationController pushViewController:descipVC animated:YES];
}

- (IBAction)groupactn:(UIButton *)sender {
    DescriptionViewController *descipVC=[[DescriptionViewController alloc]init];
    descipVC.title=@"Group";
    descipVC.descriptiontxt=@"Group";
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
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [guestbtn setBackgroundImage:[UIImage imageNamed:@"guest-list_iphone.png"] forState:UIControlStateNormal];
        [eventbtn setBackgroundImage:[UIImage imageNamed:@"events_iphone.png"] forState:UIControlStateNormal];
        [invitationbtn setBackgroundImage:[UIImage imageNamed:@"invitation_iphone.png"] forState:UIControlStateNormal];
        [rsvpbtn setBackgroundImage:[UIImage imageNamed:@"rsvp_iphone.png"] forState:UIControlStateNormal];
        [vendorbtn setBackgroundImage:[UIImage imageNamed:@"vendors_iphone.png"] forState:UIControlStateNormal];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgets_iphone.png"] forState:UIControlStateNormal];
        [groupbtn setBackgroundImage:[UIImage imageNamed:@"group-320.png"] forState:UIControlStateNormal];
        [todolistbtn setBackgroundImage:[UIImage imageNamed:@"to-do-list_iphone.png"] forState:UIControlStateNormal];
        
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
            [rsvpbtn setBackgroundImage:[UIImage imageNamed:@"rsvp.png"] forState:UIControlStateNormal];
            [vendorbtn setBackgroundImage:[UIImage imageNamed:@"vendors.png"] forState:UIControlStateNormal];
            [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgets.png"] forState:UIControlStateNormal];
            [groupbtn setBackgroundImage:[UIImage imageNamed:@"group-768.png"] forState:UIControlStateNormal];
            [todolistbtn setBackgroundImage:[UIImage imageNamed:@"do-list.png"] forState:UIControlStateNormal];
        }
        
    }
}

@end
