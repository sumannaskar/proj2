//
//  BudgetListViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/6/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "BudgetListViewController.h"
#define NIB_NAME @"BudgetCell"
#import "EditBudgetViewController.h"
#import "AddBudgetViewController.h"
#define DeleteCat [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_muldel&"]
#define catlist [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category&"]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface BudgetListViewController ()

@end

@implementation BudgetListViewController

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
//    NSLog(@"%@",self.eventidstr);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isLoad = YES;
    isCheck = NO;
    checkImage = [[NSMutableArray alloc]init];
    BudgetScroll.delegate = self;
    BudgetTable.scrollEnabled = NO;
    [self setTableHeight];
    [BudgetScroll addSubview:BudgetTable];
    
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
    [self setTableHeight];
    [BudgetTable reloadData];
    
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
    //[EventTable setRowHeight: 100.00];
    // Return the number of rows in the section.
    //return 50;
    return [CatName count];
}


//for customize cell......


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell = (BudgetCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.checkImgv.tag = indexPath.row;
    //Sets up taprecognizer for each imageview
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tap.delegate = self;
    [cell.checkImgv addGestureRecognizer:tap];
    //Enable the image to be clicked
    cell.checkImgv.userInteractionEnabled = YES;
    
    if (isLoad == YES) {
        [cell.checkImgv setImage:[UIImage imageNamed:@"index2.jpg"]];
        [checkImage addObject:@"index2.jpg"];
    }
    else{
        [cell.checkImgv setImage:[UIImage imageNamed:[checkImage objectAtIndex:indexPath.row]]];
    }
    
    //cell.EventLbl.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.EventLbl.text=[CatName objectAtIndex:indexPath.row];
    // NSLog(@"%@",eventnamestr);
    
    [cell.editBtn addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    
    return cell;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    // NSLog(@"%d",recognizer.view.tag);
    isLoad = NO;
    if ([[checkImage objectAtIndex:recognizer.view.tag]isEqualToString:@"index2.jpg"] ) {
        [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index.jpg"];
    }
    else{
        [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index2.jpg"];
    }
    [BudgetTable reloadData];
}
-(void) Edit:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
    EditBudgetViewController *EditBudgettVc=[[EditBudgetViewController alloc] init];
    EditBudgettVc.CatId = [CatId objectAtIndex:button.tag];
     EditBudgettVc.CatName = [CatName objectAtIndex:button.tag];
     EditBudgettVc.CatBudget = [CatBudget objectAtIndex:button.tag];
     EditBudgettVc.CatDesc = [CatDesc objectAtIndex:button.tag];
    EditBudgettVc.EventIdStr = self.eventidstr;
    [self.navigationController pushViewController:EditBudgettVc animated:YES];
}
-(void)setTableHeight
{
    
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [BudgetTable setRowHeight:55];
        NSInteger tableRowheight = 60*[CatName count];
        
        BudgetTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        BudgetScroll.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
    else
    {
        [BudgetTable setRowHeight:85];
        NSInteger tableRowheight = 90*[CatName count];
        BudgetTable.frame=CGRectMake(0, 0, 768, tableRowheight*2);
        BudgetScroll.contentSize = CGSizeMake(768, tableRowheight);
        
        
    }
}

- (IBAction)Add:(UIBarButtonItem *)sender {
    AddBudgetViewController *AddBudgettVc=[[AddBudgetViewController alloc] init];
    AddBudgettVc.eventidstr = self.eventidstr;

    [self.navigationController pushViewController:AddBudgettVc animated:YES];
}

- (IBAction)Delete:(UIBarButtonItem *)sender {
    
    for (int i=0; i<[checkImage count]; i++)
    {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"])
        {
            isCheck = YES;
            break;
        }
        
    }

    if (isCheck == YES) {
        Deletejson = [[NSDictionary alloc]init];
        
        NSError *error;
        NSString *str1 = @"-";
        NSString *str2;
        NSString *str3 = @"";
        for (int i=0; i<[CatId count]; i++) {
            if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
                
                str2=[NSString stringWithFormat:@"%@%@",[CatId objectAtIndex:i],str1];
                str3=[NSString stringWithFormat:@"%@%@",str3, str2];
                
            }
            
        }
        NSString *str4 = [str3 substringToIndex:[str3 length]-1];
        NSString *deleteGuest =[[NSString alloc]initWithFormat:@"category_id=%@&apikey=micronix_10_2014_wedsimple_proj",str4];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DeleteCat,deleteGuest]];
        // NSLog(@"%@",url);
        NSData* deleteeventlistdata = [NSData dataWithContentsOfURL: url];
        Deletejson = [NSJSONSerialization JSONObjectWithData:deleteeventlistdata options:kNilOptions error:&error];
        // NSLog(@"%@",Deletejson);
        if([[Deletejson valueForKey:@"status" ] isEqualToString:@"Records Deleted"])
        {
            UIAlertView *addsuccess=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Record Deleted" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [self viewDidLoad];
            [addsuccess show];
            
        }
        else
        {
            UIAlertView *addfailed=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Fail to delete\nTry again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [addfailed show];
        }

    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Select atleast one" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end
