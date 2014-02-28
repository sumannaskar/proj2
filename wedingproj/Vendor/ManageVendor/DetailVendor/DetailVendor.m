//
//  DetailVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DetailVendor.h"
#import "EditVendor.h"

@interface DetailVendor ()

@end

@implementation DetailVendor

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

- (IBAction)edit:(id)sender {
    EditVendor *EditVendor_ =[[EditVendor alloc]init];
    [self.navigationController pushViewController:EditVendor_ animated:YES];
    
}

- (IBAction)done:(id)sender {
}
@end
