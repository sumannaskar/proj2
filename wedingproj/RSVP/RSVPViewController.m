//
//  RSVPViewController.m
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "RSVPViewController.h"
#import "DestailsRSVPViewController.h"
#define kRSVPURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events"]
#define kRSVPURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]


@interface RSVPViewController ()

@end

@implementation RSVPViewController

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

- (IBAction)Detailsactn:(UIButton *)sender {
    
    DestailsRSVPViewController *detailsrsvVC=[[DestailsRSVPViewController alloc]init];
    [self.navigationController pushViewController:detailsrsvVC animated:YES];
}
@end
