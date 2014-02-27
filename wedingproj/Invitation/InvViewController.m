//
//  InvViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "InvViewController.h"
#import "SendIndividuallyViewController.h"
#import "SelectViewController.h"

@interface InvViewController ()

@end

@implementation InvViewController

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

- (IBAction)IndividuallySend:(UIButton *)sender {
    SendIndividuallyViewController *InvVC =[[SendIndividuallyViewController alloc]init];
    [self.navigationController pushViewController:InvVC animated:YES];
}

- (IBAction)GroupwiseSend:(UIButton *)sender {
    SelectViewController *SelectVC =[[SelectViewController alloc]init];
    [self.navigationController pushViewController:SelectVC animated:YES];
}
@end
