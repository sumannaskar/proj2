//
//  GuestViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "GuestViewController.h"
#import "AddGuestViewController.h"
#import "EditGuestViewController.h"
#define NIB_NAME @"GuestCell"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_all&"]

#define DeleteURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_muldel&"]

@interface GuestViewController ()

@end

@implementation GuestViewController
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
    //[GuestTable setRowHeight: 100.00];
    json=[[NSDictionary alloc]init];
    
     Gid=[[NSMutableArray alloc]init];
     Gname=[[NSMutableArray alloc]init];
     role=[[NSMutableArray alloc]init];
     email=[[NSMutableArray alloc]init];
     GroupId=[[NSMutableArray alloc]init];
     NoOfPerson=[[NSMutableArray alloc]init];
    
    
    
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    InvScroll.delegate = self;
    InvTable.scrollEnabled = NO;
   
    [self setTableHeight];
     [InvScroll addSubview:InvTable];
    
     NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",@"12"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
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
//    if ([[json valueForKey:@"status"]isEqualToString:@"No record found"]) {
//        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [nodata show];
//    }
//    else{
        for(NSString *loc in [json valueForKey:@"guest_id"]) {
            [Gid addObject:loc];
        }
        for(NSString *loc in [json valueForKey:@"name"]) {
            [Gname addObject:loc];
        }
        for(NSString *loc in [json valueForKey:@"role"]) {
            [role addObject:loc];
        }
        for(NSString *loc in [json valueForKey:@"email"]) {
            [email addObject:loc];
        }
        for(NSString *loc in [json valueForKey:@"group_id"]) {
            [GroupId addObject:loc];
        }
        for(NSString *loc in [json valueForKey:@"no_of_guest"]) {
            [NoOfPerson addObject:loc];
        }
    [self setTableHeight];
    [InvTable reloadData];
   // }
        
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
    
    cell1 = (GuestCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
     NSLog(@"%@",[Gname objectAtIndex:indexPath.row]);
    
    [cell1.statusBtn addTarget:self action:@selector(InvStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell1.statusBtn.tag = indexPath.row;
    
    return cell1;
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
    EditGuestViewController *EditVc=[[EditGuestViewController alloc] init];
    
     EditVc.GidString = [Gid objectAtIndex:button.tag];
     EditVc.nameString = [Gname objectAtIndex:button.tag];
     EditVc.roleString = [role objectAtIndex:button.tag];
     EditVc.emailString = [email objectAtIndex:button.tag];
     EditVc.groupString = [GroupId objectAtIndex:button.tag];
     EditVc.withString = [NoOfPerson objectAtIndex:button.tag];
    
    
    
    [self.navigationController pushViewController:EditVc animated:YES];
}

-(void)setTableHeight
{
    
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
         [InvTable setRowHeight:55];
        NSInteger tableRowheight = 60*[Gname count];
       
        InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        InvScroll.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
    else
    {
        [InvTable setRowHeight:85];
        NSInteger tableRowheight = 90*[Gname count];
        InvTable.frame=CGRectMake(0, 0, 768, tableRowheight*2);
        InvScroll.contentSize = CGSizeMake(768, tableRowheight);
        
        
    }
}
- (IBAction)DeleteAction:(UIBarButtonItem *)sender {
    
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
   // NSLog(@"%@",str4);
    
    Deletejson = [[NSDictionary alloc]init];
    
    NSString *deleteGuest =[[NSString alloc]initWithFormat:@"guest_id=%@&apikey=micronix_10_2014_wedsimple_proj",str4];
    
    //NSString* urlTextEscaped = [SignUpdatra stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DeleteURL,deleteGuest]];
    //NSLog(@"my--%@",url);
    
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
             [self performSelectorOnMainThread:@selector(fetchedData1:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );
    
}
-(void)fetchedData1:(NSData *)responseData
{
    NSError *error;
    Deletejson = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    NSLog(@"%@",Deletejson);
}
- (IBAction)AddAction:(UIBarButtonItem *)sender {
    AddGuestViewController *AddguestVc=[[AddGuestViewController alloc] init];
    [self.navigationController pushViewController:AddguestVc animated:YES];
}
@end
