//
//  ManageListViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "ManageListViewController.h"
#import "EditBudget.h"

#define catlist [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_event&"]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ManageListViewController ()

@end

@implementation ManageListViewController

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
    
    json = [[NSDictionary alloc]init];
    jsondata = [[NSMutableArray alloc]init];
    CatId = [[NSMutableArray alloc]init];
    CatName = [[NSMutableArray alloc]init];
    CatBudget = [[NSMutableArray alloc]init];
    CatDesc = [[NSMutableArray alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"event_id=%@&apikey=micronix_10_2014_wedsimple_proj",self.eventidstr];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",catlist,string]];
    // NSLog(@"my--%@",url);
    
    // [HUD showUIBlockingIndicatorWithText:@"Loading.."];
    dispatch_async
    (kBgQueue, ^
     {
         NSData* data = [NSData dataWithContentsOfURL:
                         url];
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
    // NSLog(@"%@",[json valueForKey:@"status"]);
    
    // [HUD hideUIBlockingIndicator];
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        jsondata = [json valueForKey:@"data"];
        for(int i=0;i<jsondata.count;i++ ) {
            [CatId addObject:[[jsondata objectAtIndex:i ] valueForKey:@"category_id"]];
        }
        for(int i=0;i<jsondata.count;i++ ) {
            [CatName addObject:[[jsondata objectAtIndex:i ] valueForKey:@"category_name"]];
            
        }
        for(int i=0;i<jsondata.count;i++ ) {
            [CatBudget addObject:[[jsondata objectAtIndex:i ] valueForKey:@"estimate_budget"]];
            
        }
        for(int i=0;i<jsondata.count;i++ ) {
            [CatDesc addObject:[[jsondata objectAtIndex:i ] valueForKey:@"description"]];
            
        }
    }
    [tbl reloadData];
    NSLog(@"%@",CatId);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return 1;
}


-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [CatName count];
}


-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    static NSString *cellidentifire;
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
    if(cell==nil)
    {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifire];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.textLabel.text=[CatName objectAtIndex:indexPath.row];
        //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Edit" forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(EditButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
        
        //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        return cell;
    }
    return cell;
    
}
-(void)EditButtonTapped:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);
    EditBudget *AllBudget_ =[[EditBudget alloc]init];
    [self.navigationController pushViewController:AllBudget_ animated:YES];
}
@end
