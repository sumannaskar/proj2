//
//  AllBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AllBudget.h"
#import "DeleteBudget.h"
#import "AddBudget.h"
#import "DetailBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_event&"]

@interface AllBudget ()

@end

@implementation AllBudget
@synthesize eventidpass;
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
    budgetname =[[NSMutableArray alloc]init];
    budgetid =[[NSMutableArray alloc]init];
    [super viewDidLoad];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@event_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,eventidpass]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@event_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,@"4"]];
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

}

-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    
    for (NSDictionary *data in json ) {
        [budgetname addObject:[data valueForKey:@"name"]];
        [budgetid addObject:[data valueForKey:@"budget_id"]];
        
    }
    [allbudget reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return budgetname.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     static NSString *cellidentifire;
     
     UITableViewCell *cell;
     cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
     if(cell==nil)
     {
         cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
         cell.textLabel.text=[budgetname objectAtIndex:indexPath.row];
         
         
         return cell;
         
         
     }
     
     
     return cell;

//[NSString stringWithFormat:@"%d",a];

 }

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"SimpleTableCell";
//    
//    Customcell *cell= (Customcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil)
//    {
//        UINib* nib = [UINib nibWithNibName:@"Customcell" bundle:nil];
//        NSArray* array = [nib instantiateWithOwner:self options:nil];
//        cell = [array objectAtIndex:0];
//    }
//    cell.event.text =@"event";
//    cell.budget.text=@"Total budget";
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailBudget *DetailBudget_ =[[DetailBudget alloc]init];
    DetailBudget_.budgetidpass =[budgetid objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:DetailBudget_ animated:YES];
    
}

- (IBAction)addBudget:(id)sender
{
    AddBudget *AddBudget_ = [[AddBudget alloc]init];
    [self.navigationController pushViewController:AddBudget_ animated:YES];
    
}
- (IBAction)deleteBudget:(UIBarButtonItem *)sender
{
    DeleteBudget *DeleteBudget_ = [[DeleteBudget alloc]init];
    [self.navigationController pushViewController:DeleteBudget_ animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
