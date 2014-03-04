//
//  SendIndividuallyViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "SendIndividuallyViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_event&"]

#define SendURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=invitation&"]
#define NIB_NAME @"Cell1"
@interface SendIndividuallyViewController ()

@end

@implementation SendIndividuallyViewController

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
    //NSLog(@"%@",self.eventId);
    
    json=[[NSDictionary alloc]init];
    jsondata=[[NSMutableArray alloc]init];
    
    Gid=[[NSMutableArray alloc]init];
    Gname=[[NSMutableArray alloc]init];
     GuestStatus=[[NSMutableArray alloc]init];
    
    
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    InvScroll.delegate = self;
    InvTable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
    [self setTableHeight];
    [InvScroll addSubview:InvTable];
    
    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&event_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],self.eventId];
    
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
-(void)fetchedData:(NSData *)responseData{
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
    for(int i=0;i<jsondata.count;i++) {
        
        [Gid addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_id"]];
        
    }
        for(int i=0;i<jsondata.count;i++) {
            
            [Gname addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_name"]];
            
        }
        for(int i=0;i<jsondata.count;i++) {
            
            [GuestStatus addObject:[[jsondata objectAtIndex:i ] valueForKey:@"status"]];
            
        }
[self setTableHeight];
[InvTable reloadData];
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
    // Return the number of rows in the section.
    return [Gname count];
}
//for normal table view....


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
// {
//
//     static NSString *cellidentifire;
//     UITableViewCell *cell;
//     cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
//     if(cell==nil)
//     {
//         cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
//         cell.textLabel.text=[NSString stringWithFormat:@"%d",a];
//         NSLog(@"%d",a);
//         a=a+1;
//         cell.accessoryType=UITableViewCellStyleDefault;
//         //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//         return cell;
//     }
//     return cell;
//
////[NSString stringWithFormat:@"%d",a];
//
// }

//for customize cell......


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell1 = (Cell1 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell1 == nil)
    {
        UINib* nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell1 = [array objectAtIndex:0];
    }
    cell1.checkImgv.tag = indexPath.row;
    //Sets up taprecognizer for each imageview
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tap.delegate = self;
    [cell1.checkImgv addGestureRecognizer:tap];
    //Enable the image to be clicked
    cell1.checkImgv.userInteractionEnabled = YES;
    
    if (isLoad == YES) {
        [cell1.checkImgv setImage:[UIImage imageNamed:@"index2.jpg"]];
        [checkImage addObject:@"index2.jpg"];
    }
    else{
        [cell1.checkImgv setImage:[UIImage imageNamed:[checkImage objectAtIndex:indexPath.row]]];
    }
    
    cell1.guestLbl.text = [Gname objectAtIndex:indexPath.row];
    
    [cell1.statusBtn setTitle:[GuestStatus objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell1.statusBtn addTarget:self action:@selector(InvStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell1.statusBtn.tag = indexPath.row;
    
    return cell1;
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    // NSLog(@"%@",[GuestStatus objectAtIndex:recognizer.view.tag]);
    if ([[GuestStatus objectAtIndex:recognizer.view.tag]isEqualToString:@"not sent"]) {
        isLoad = NO;
        if ([[checkImage objectAtIndex:recognizer.view.tag]isEqualToString:@"index2.jpg"] ) {
            [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index.jpg"];
        }
        else{
            [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index2.jpg"];
        }
        [InvTable reloadData];

    }
}
-(void) InvStatus:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
}

-(void)setTableHeight
{
    
        if([[UIScreen mainScreen] bounds].size.height  < 600)
        {
            [InvTable setRowHeight:60];
            int tableRowheight = 60*50;
            
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
            
            
        }
        else
        {
            [InvTable setRowHeight:90];
            int tableRowheight = 90*50;
            InvTable.frame=CGRectMake(0, 0, 768, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(768, tableRowheight);
            
            
        }

}


- (IBAction)ProcedAction:(UIButton *)sender {
    
    InvJson = [[NSDictionary alloc]init];
    
    NSString *str1 = @"-";
    NSString *str2;
    NSString *str3 = @"";
    for (int i=0; i<[Gid count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
            
            str2=[NSString stringWithFormat:@"%@%@",[Gid objectAtIndex:i],str1];
            str3=[NSString stringWithFormat:@"%@%@",str3, str2];
            
        }
    }
    NSString *str4 = [str3 substringToIndex:[str3 length]-1];
    NSLog(@"%@",str4);
    
    NSString *string =[[NSString alloc]initWithFormat:@"guest_id=%@&event_id=%@&apikey=micronix_10_2014_wedsimple_proj",str4,self.eventId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SendURL,string]];
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
             [self performSelectorOnMainThread:@selector(fetchedData1:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );

}
-(void)fetchedData1:(NSData *)responseData{
    NSError *error;
    InvJson = [NSJSONSerialization
               JSONObjectWithData:responseData //1
               
               options:kNilOptions
               error:&error];
    NSLog(@"%@",InvJson);
    [self viewDidLoad];
}
@end
