//
//  DestailsRSVPViewController.m
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DestailsRSVPViewController.h"

@interface DestailsRSVPViewController ()

@end

@implementation DestailsRSVPViewController

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}
//for normal table view....


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {

     static NSString *cellidentifire;
     UITableViewCell *cell;
     cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
     if(cell==nil)
     {
         cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
         cell.textLabel.text=@"guest";
         
         UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 72, 37)];
         status.text = @"Yes";
         
         cell.accessoryType = UITableViewCellAccessoryNone;
         cell.accessoryView = status;
         //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         return cell;
     }
     return cell;

//[NSString stringWithFormat:@"%d",a];

 }


@end
