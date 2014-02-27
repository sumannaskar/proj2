//
//  DetailBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "DetailBudget.h"
#import "EditBudget.h"

@interface DetailBudget ()

@end

@implementation DetailBudget

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
    infotext.editable=NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
}

- (IBAction)edit:(id)sender {
    
    EditBudget *EditBudget_=[[EditBudget alloc]init];
    [self.navigationController pushViewController:EditBudget_ animated:YES];
    
    
}
@end
