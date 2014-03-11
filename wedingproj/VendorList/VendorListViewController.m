//
//  VendorListViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "VendorListViewController.h"
#import "AddVendorViewController.h"
#import "SSKeychain.h"
#define NIB_NAME @"VendorCell"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&"]

#define DeleteURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_muldel&"]

@interface VendorListViewController ()

@end

@implementation VendorListViewController

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
    isLoad = YES;
    isCheck = NO;
    
    checkImage = [[NSMutableArray alloc]init];
    InvScroll.delegate = self;
    InvTable.scrollEnabled = NO;
    
    [self setTableHeight];
    [InvScroll addSubview:InvTable];
    
    json = [[NSDictionary alloc]init];
    Jsondata = [[NSMutableArray alloc]init];
    
    Vid = [[NSMutableArray alloc]init];
    Vname = [[NSMutableArray alloc]init];
    Vcatagory = [[NSMutableArray alloc]init];
    Vcontact = [[NSMutableArray alloc]init];
    Vemail = [[NSMutableArray alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&category_name=lightings&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
    NSLog(@"my--%@",url);
    
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
     NSLog(@"%@",[json valueForKey:@"availability"]);
    
    // [HUD hideUIBlockingIndicator];
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        Jsondata = [json valueForKey:@"data"];
        for(int i=0;i<Jsondata.count;i++ ) {
            [Vid addObject:[[Jsondata objectAtIndex:i ] valueForKey:@"vendor_id"]];
        }
        for(int i=0;i<Jsondata.count;i++ ) {
            [Vname addObject:[[Jsondata objectAtIndex:i ] valueForKey:@"vendor_name"]];
            
        }
        for(int i=0;i<Jsondata.count;i++ ) {
            [Vcatagory addObject:[[Jsondata objectAtIndex:i ] valueForKey:@"category_name"]];
            
        }
        for(int i=0;i<Jsondata.count;i++ ) {
            [Vcontact addObject:[[Jsondata objectAtIndex:i ] valueForKey:@"contact"]];
            
        }
        for(int i=0;i<Jsondata.count;i++ ) {
            [Vemail addObject:[[Jsondata objectAtIndex:i ] valueForKey:@"email"]];
            
        }
    }
    [self setTableHeight];
    [InvTable reloadData];
    
}


-(void)setTableHeight
{
    
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [InvTable setRowHeight:55];
        NSInteger tableRowheight = 60*[Vid count];
        
        InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        InvScroll.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
    else
    {
        [InvTable setRowHeight:85];
        NSInteger tableRowheight = 90*[Vid count];
        InvTable.frame=CGRectMake(0, 0, 768, tableRowheight*2);
        InvScroll.contentSize = CGSizeMake(768, tableRowheight);
        
        
    }
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
    //[InvTable setRowHeight: 50.00];
    // Return the number of rows in the section.
    // NSLog(@"%d",[Gname count]);
    return [Vid count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell = (VendorCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
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
    
    cell.guestLbl.text = [Vname objectAtIndex:indexPath.row];
    // NSLog(@"%@",[Gname objectAtIndex:indexPath.row]);
    
    //cell.guestLbl.text = @"Vendor";
    
    [cell.statusBtn addTarget:self action:@selector(InvStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell.statusBtn.tag = indexPath.row;
    
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
    [InvTable reloadData];
}
-(void) InvStatus:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
//    EditGuestViewController *EditVc=[[EditGuestViewController alloc] init];
//    
//    EditVc.GidString = [Gid objectAtIndex:button.tag];
//    EditVc.nameString = [Gname objectAtIndex:button.tag];
//    EditVc.roleString = [role objectAtIndex:button.tag];
//    EditVc.emailString = [email objectAtIndex:button.tag];
//    EditVc.groupString = [GroupName objectAtIndex:button.tag];
//    EditVc.withString = [NoOfPerson objectAtIndex:button.tag];
//    
//    //NSLog(@"%@",EditVc.withString);
//    
//    [self.navigationController pushViewController:EditVc animated:YES];
}
- (IBAction)AddAction:(UIBarButtonItem *)sender {
    AddVendorViewController *AddVc=[[AddVendorViewController alloc] init];
    [self.navigationController pushViewController:AddVc animated:YES];
}
- (IBAction)DeleteAction:(UIBarButtonItem *)sender {
    
    for (int i=0; i<[checkImage count]; i++)
    {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"])
        {
            isCheck = YES;
            break;
        }
        
    }
    
//    if (isCheck == YES) {
//        NSString *str1 = @"-";
//        NSString *str2;
//        NSString *str3 = @"";
//        for (int i=0; i<[Gid count]; i++) {
//            if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
//                
//                str2=[NSString stringWithFormat:@"%@%@",[Gid objectAtIndex:i],str1];
//                str3=[NSString stringWithFormat:@"%@%@",str3, str2];
//                
//            }
//        }
//        NSString *str4 = [str3 substringToIndex:[str3 length]-1];
//        //NSLog(@"%@",str4);
//        
//    }
}

@end
