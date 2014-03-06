//
//  DetailVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DetailVendor.h"
#import "EditVendor.h"
#import "ManageVendor.h"

@interface DetailVendor ()

@end

@implementation DetailVendor
@synthesize vendoridpass,json;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        json =[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",json);
    vendornametext.text=[json valueForKey:@"vendor_name"];
    categorytext.text =[json valueForKey:@"category"];
    emailtext.text=[json  valueForKey:@"email"];
    contactnotext.text =[json  valueForKey:@"contact"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    EditVendor *EditVendor_ =[[EditVendor alloc]init];
    EditVendor_.json=json;
    [self.navigationController pushViewController:EditVendor_ animated:YES];
    
}

- (IBAction)done:(id)sender {
    
    ManageVendor *ManageVendor_ =[[ManageVendor alloc]init];
    [self.navigationController pushViewController:ManageVendor_ animated:YES];
    
    
}
@end
