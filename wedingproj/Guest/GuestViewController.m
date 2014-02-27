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
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_all&event_id=3&apikey=micronix_10_2014_wedsimple_proj"]

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
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL]];
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
    [self image];
    [InvScroll addSubview:InvTable];
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
     NSLog(@"%d",[Gname count]);
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
    
     EditVc.nameString = [Gname objectAtIndex:button.tag];
     EditVc.roleString = [role objectAtIndex:button.tag];
     EditVc.emailString = [email objectAtIndex:button.tag];
     EditVc.groupString = [GroupId objectAtIndex:button.tag];
     EditVc.withString = [NoOfPerson objectAtIndex:button.tag];
    
    
    
    [self.navigationController pushViewController:EditVc animated:YES];
}

-(void)image
{
    int tableRowheight = 50*[Gname count];
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
                        InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
            
        }
        else
        {
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        
        
    }
    else
    {
        //[bgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
        InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        InvScroll.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
}
- (IBAction)DeleteAction:(UIBarButtonItem *)sender {
    
    for (int i=1; i<[Gid count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
            //NSString * str = [NSString stringWithFormat:@"%@%@%@", str,@"id",[Gid objectAtIndex:i] ];
        }
    }
}

- (IBAction)AddAction:(UIBarButtonItem *)sender {
    AddGuestViewController *AddguestVc=[[AddGuestViewController alloc] init];
    [self.navigationController pushViewController:AddguestVc animated:YES];
}
@end
