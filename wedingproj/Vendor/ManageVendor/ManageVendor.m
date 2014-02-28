//
//  ManageVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "ManageVendor.h"
#import "DetailVendor.h"
#import "DeleteVendor.h"

@interface ManageVendor ()

@end

@implementation ManageVendor

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
    UIBarButtonItem *delete =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(Deletd:)];
    [self.navigationItem setRightBarButtonItem:delete];
}

-(IBAction)Deletd:(UIBarButtonItem *)sender
{
    DeleteVendor *DeleteVendor_ =[[DeleteVendor alloc]init];
    [self.navigationController pushViewController:DeleteVendor_ animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell= (ManageVendorCC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"Customcell" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
   // cell.vendorname.text =[eventname objectAtIndex:indexPath.row];
    
    [cell.detail addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detail.tag = indexPath.row;
    
    return cell;
    
    
}
-(void) detail:(UIButton*)button
{
    

    DetailVendor *DetailVendor_ =[[DetailVendor alloc]init];
    [self.navigationController pushViewController:DetailVendor_ animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
