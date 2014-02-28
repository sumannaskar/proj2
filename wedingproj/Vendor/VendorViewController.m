//
//  VendorViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "VendorViewController.h"
#import "ManageVendor.h"
#import "AddVendor.h"


@interface VendorViewController ()

@end

@implementation VendorViewController

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
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)managevendor:(id)sender {
    ManageVendor *ManageVendor_ =[[ManageVendor alloc]init];
    [self.navigationController pushViewController:ManageVendor_ animated:YES];
}

- (IBAction)addvendor:(id)sender {
    
    AddVendor *AddVendor_ =[[AddVendor alloc]init];
    [self.navigationController pushViewController:AddVendor_ animated:YES];
    
}
@end
