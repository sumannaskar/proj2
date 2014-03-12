//
//  DescriptionViewController.m
//  wedingproj
//
//  Created by Micronix on 04/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController

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
    descriptxtview.text=self.descriptiontxt;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        
        
        
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
            [backgroundimgV setImage:[UIImage imageNamed:@"768-1004.jpg"]];
            
            
        }
        
    }
}



@end
