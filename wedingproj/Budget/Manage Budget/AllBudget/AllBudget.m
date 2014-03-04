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
#import "ManageBudget.h"
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
    jsondata =[[NSDictionary alloc]init];
    json =[[NSMutableArray alloc]init];
    budgetname =[[NSMutableArray alloc]init];
    budgetid =[[NSMutableArray alloc]init];
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@event_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,eventidpass]];
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
    jsondata = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    NSLog(@"%@",json);
    
    
    if ([[jsondata valueForKey:@"availability"] isEqual:@"no"])
    {
        UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"weding" message:@"No Budget\nDo You Want To Create Budget Now? " delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [createbudget show];
    }
    else
    {
    
        json=[jsondata valueForKey:@"data"];
//    for (NSDictionary *data in json ) {
//        [budgetname addObject:[data valueForKey:@"name"]];
//        [budgetid addObject:[data valueForKey:@"budget_id"]];
//        
//    }
        for (int i=0; i<[json count]; i++) {
            [budgetname addObject:[[json objectAtIndex:i ] valueForKey:@"name"]];
            [budgetid addObject:[[json objectAtIndex:i ] valueForKey:@"budget_id"]];
        }
    NSLog(@"%@",budgetid);
    [allbudget reloadData];
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if (buttonIndex == 0)
    {
        AddBudget *AddBudget_ = [[AddBudget alloc]init];
        AddBudget_.eventidpass=eventidpass;
        [self.navigationController pushViewController:AddBudget_ animated:YES];
    }
    else if (buttonIndex == 1)
    {
        ManageBudget *ManageBudget_ =[[ManageBudget alloc]init];
        [self.navigationController pushViewController:ManageBudget_ animated:YES];
    }
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
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell= (AllBudgetCC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"AllBudgetCC" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.budgetname.text =[budgetname objectAtIndex:indexPath.row];
    [cell.detail addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detail.tag = indexPath.row;
                          
                          
    
    return cell;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void) detail:(UIButton*)button
{
        
    DetailBudget *DetailBudget_ =[[DetailBudget alloc]init];
    DetailBudget_.budgetidpass =[budgetid objectAtIndex:button.tag];
     NSLog(@"%@",DetailBudget_.budgetidpass);
    [self.navigationController pushViewController:DetailBudget_ animated:YES];
        
        
        
    }
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailBudget *DetailBudget_ =[[DetailBudget alloc]init];
//    DetailBudget_.budgetidpass =[budgetid objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:DetailBudget_ animated:YES];
//    
//}

- (IBAction)addBudget:(id)sender
{
    AddBudget *AddBudget_ = [[AddBudget alloc]init];
    AddBudget_.eventidpass=eventidpass;
    [self.navigationController pushViewController:AddBudget_ animated:YES];
    
}
- (IBAction)deleteBudget:(UIBarButtonItem *)sender
{
    DeleteBudget *DeleteBudget_ = [[DeleteBudget alloc]init];
    DeleteBudget_.json =json;
    [self.navigationController pushViewController:DeleteBudget_ animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
