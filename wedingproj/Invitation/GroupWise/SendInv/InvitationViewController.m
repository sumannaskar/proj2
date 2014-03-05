//
//  InvitationViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "InvitationViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define NIB_NAME @"Cell"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_group&"]

#define SendURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=invitation&"]

@interface InvitationViewController ()

@end

@implementation InvitationViewController

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
    //NSLog(@"%@-%@",self.GroupId,self.EventId);
     json = [[NSDictionary alloc]init];
    jsondata = [[NSMutableArray alloc]init];
    Guestid = [[NSMutableArray alloc]init];
     Guestname = [[NSMutableArray alloc]init];
     GuestStatus = [[NSMutableArray alloc]init];
    
    
    isLoad = YES;
    isCheck = NO;
    
    checkImage = [[NSMutableArray alloc]init];
    InvScroll.delegate = self;
    InvTable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
    [self setTableHeight];
    [InvScroll addSubview:InvTable];
    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&event_id=%@&group_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],self.EventId,self.GroupId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
     //NSLog(@"my--%@",url);
    
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
    //    if ([[json valueForKey:@"status"]isEqualToString:@"No record found"]) {
    //        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    //        [nodata show];
    //    }
    //    else{
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        jsondata = [json valueForKey:@"data"];
        for(int i=0;i<jsondata.count;i++) {
            
            [Guestid addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_id"]];
            
        }
        for(int i=0;i<jsondata.count;i++) {
            
            [Guestname addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_name"]];
            
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
    //[InvTable setRowHeight: 100.00];
    // Return the number of rows in the section.
    return [Guestid count];
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
    
    cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
    
    cell.guestLbl.text = [Guestname objectAtIndex:indexPath.row];;
    
    [cell.statusBtn setTitle:[GuestStatus objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.statusBtn addTarget:self action:@selector(InvStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell.statusBtn.tag = indexPath.row;
    
    return cell;
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
   // NSLog(@"%d",recognizer.view.tag);
    if ([[GuestStatus objectAtIndex:recognizer.view.tag]isEqualToString:@"not sent"])
    {
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
            NSInteger tableRowheight = 60*[Guestid count];
            
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
            
            
        }
        else
        {
            [InvTable setRowHeight:90];
            NSInteger tableRowheight = 90*[Guestid count];
            InvTable.frame=CGRectMake(0, 0, 768, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(768, tableRowheight);
            
            
        }
}


- (IBAction)SendAction:(UIButton *)sender {
    for (int i=0; i<[checkImage count]; i++)
    {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"])
        {
            isCheck = YES;
            break;
        }
        
    }
    if (isCheck == YES)
    {
    NSString *str1 = @"-";
    NSString *str2;
    NSString *str3 = @"";
    for (int i=0; i<[Guestid count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
            
            str2=[NSString stringWithFormat:@"%@%@",[Guestid objectAtIndex:i],str1];
            str3=[NSString stringWithFormat:@"%@%@",str3, str2];
            
        }
    }
    NSString *str4 = [str3 substringToIndex:[str3 length]-1];
    //NSLog(@"%@",str4);
    
    InvJson = [[NSDictionary alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"guest_id=%@&event_id=%@&apikey=micronix_10_2014_wedsimple_proj",str4,self.EventId];
    
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
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Select atleast one" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }


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
