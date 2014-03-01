//
//  ManageBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/22/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "ManageBudget.h"

#import "AllBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events&"]



@interface ManageBudget ()

@end

@implementation ManageBudget

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
    
    
    json =[[NSMutableArray alloc]init];
    eventid=[[NSMutableArray alloc]init];
    eventname=[[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,@"10"]];
    NSLog(@"my--%@",url);
    
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

 
    
    
    [super viewDidLoad];
    
}


-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    
    for (NSDictionary *data in json ) {
        [eventname addObject:[data valueForKey:@"event_name"]];
        [eventid addObject:[data valueForKey:@"event_id"]];
        
    }
    [manageTable reloadData];
    
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
        return [eventname count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell= (Customcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"Customcell" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.event.text =[eventname objectAtIndex:indexPath.row];
    
    [cell.detail addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detail.tag = indexPath.row;

    return cell;
    
    
}
-(void) detail:(UIButton*)button
{
    
    AllBudget *AllBudget_ =[[AllBudget alloc]init];
    AllBudget_.eventidpass=[eventid objectAtIndex:button.tag];
    [self.navigationController pushViewController:AllBudget_ animated:YES];
    
    
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AllBudget *AllBudget_ =[[AllBudget alloc]init];
//    AllBudget_.eventidpass=[eventid objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:AllBudget_ animated:YES];
//    
//}



@end
