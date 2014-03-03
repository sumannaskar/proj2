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
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&"]

@interface ManageVendor ()

@end

@implementation ManageVendor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *delete =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(Deletd:)];
    [self.navigationItem setRightBarButtonItem:delete];
    json = [[NSMutableArray alloc]init];
    vendorid =[[NSMutableArray alloc]init];
    vendorname =[[NSMutableArray alloc]init];
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,[SSKeychain passwordForService:@"LoginViewController" account:@"User"]]];
    
    // [HUD showUIBlockingIndicatorWithText:@"Loading.."];
    dispatch_async
    (kBgQueue, ^
     {
         NSData* data = [NSData dataWithContentsOfURL:url];
         NSString *tempstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         
         if (data.length<1 || [tempstring isEqualToString:@"null"])
         {
             
             
             //[self performSelectorOnMainThread:@selector(serverFail) withObject:nil waitUntilDone:YES];
             
         }
         
         else
         {
             [self performSelectorOnMainThread:@selector(fetchedData:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );
}


-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    
    for (NSDictionary *data in json ) {
        [vendorname addObject:[data valueForKey:@"name"]];
        [vendorid addObject:[data valueForKey:@"vendor_id"]];
        
    }
    [managevendortable reloadData];
    
}

-(IBAction)Deletd:(UIBarButtonItem *)sender
{
    DeleteVendor *DeleteVendor_ =[[DeleteVendor alloc]init];
    DeleteVendor_.json =json;
    [self.navigationController pushViewController:DeleteVendor_ animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vendorid.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell= (ManageVendorCC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"ManageVendorCC" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.vendorname.text =[vendorname objectAtIndex:indexPath.row];
    
    [cell.detail addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detail.tag = indexPath.row;
    
    return cell;
    
    
}
-(void) detail:(UIButton*)button
{
    

    DetailVendor *DetailVendor_ =[[DetailVendor alloc]init];
    DetailVendor_.json =[json objectAtIndex:button.tag];
    [self.navigationController pushViewController:DetailVendor_ animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
