//
//  EventViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EventViewController.h"
#import "AddEventViewController.h"
#import "EditEventViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define NIB_NAME @"Cell2"
#define keventlistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events"]
#define keventlistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define EventDeleteURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=event_delete&"]
#define EventDeleteURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface EventViewController ()

@end

@implementation EventViewController

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
    NSLog(@"Eventviewcontroller");
   
//    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)];
//    [self.navigationItem setRightBarButtonItem:add];
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    EventScroll.delegate = self;
    EventTable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
//    [self image];
//    [EventScroll addSubview:EventTable];
    
    NSURL *tempeventurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@%@",keventlistURL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],keventlistURL2]];
    dispatch_async(kBgQueue, ^{
//        NSURL *tempUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",firstCatagoryURL,self.deviceString,secondCatagoryURL]];
        NSData *tempcatagorydata=[NSData dataWithContentsOfURL:tempeventurl];
        NSString *tempstring = [[NSString alloc] initWithData:tempcatagorydata encoding:NSUTF8StringEncoding];
        
        
        if (tempcatagorydata.length<1 || [tempstring isEqualToString:@"null"])
        {
            
//            if ([InternetValidation connectedToNetwork])
//            {
//                [self performSelectorOnMainThread:@selector(serverFail) withObject:nil waitUntilDone:YES];
//                
//            }
            
//            else
//            {
//                [self performSelectorOnMainThread:@selector(connection) withObject:nil waitUntilDone:YES];
//                NSLog(@"no net");
//                
//            }
            
        }
        
        else
        {
            NSError *error;
            NSArray *tempArray=[NSJSONSerialization JSONObjectWithData:tempcatagorydata options:kNilOptions error:&error];
            raweventList = [[NSArray alloc]initWithArray:tempArray];
            totaleventIdlist=[[NSMutableArray alloc ]init];
            
            for(int i=0;i<raweventList.count;i++)
            {
                NSDictionary *tempDict=[raweventList objectAtIndex:i];
                
                [totaleventIdlist addObject:[tempDict objectForKey:@"event_id"]];
                
            }

            
            
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:nil waitUntilDone:YES];
            
            
        }
        
        
        
    });

    
}
- (void)fetchedData:(NSData *)responseData
{
    
    NSLog(@"FetchData");
    [self image];
    [EventScroll addSubview:EventTable];
    [EventTable reloadData];
}
-(IBAction)Add:(UIBarButtonItem *)sender
{
    AddEventViewController *AddeventVc=[[AddEventViewController alloc] init];
    [self.navigationController pushViewController:AddeventVc animated:YES];
}

- (IBAction)Delete:(UIBarButtonItem *)sender {
    
    BOOL uncheck=YES;
    
    NSLog(@"%@",checkImage);
    for (int i=0; i<[checkImage count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"])
        {
            uncheck=NO;
            break;
        }
    }
    
    if (uncheck==NO) {
        [self deleteevent];
    }
    else
    {
        UIAlertView *nodelete=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"At least Select one event to delete" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nodelete show];

    }
}

-(void)deleteevent
{
    NSError *error;
    NSString *str1 = @"-";
    NSString *str2;
    NSString *str3 = @"";
    for (int i=0; i<[totaleventIdlist count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
            
            str2=[NSString stringWithFormat:@"%@%@",[totaleventIdlist objectAtIndex:i],str1];
            str3=[NSString stringWithFormat:@"%@%@",str3, str2];
            
        }
        
    }
    NSString *str4 = [str3 substringToIndex:[str3 length]-1];
    NSString *deleteGuest =[[NSString alloc]initWithFormat:@"event_id=%@%@",str4,EventDeleteURL2];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",EventDeleteURL1,deleteGuest]];
    NSData* deleteeventlistdata = [NSData dataWithContentsOfURL: url];
    NSArray* rawvendorList = [NSJSONSerialization JSONObjectWithData:deleteeventlistdata options:kNilOptions error:&error];
    NSLog(@"%@",rawvendorList);
    [self viewDidLoad];

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
    return [raweventList count];
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
    
    cell = (Cell2 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
    
    NSDictionary *tempdic=[raweventList objectAtIndex:indexPath.row];
    eventnamestr=[tempdic objectForKey:@"event_name"];
    startstr=[tempdic objectForKey:@"start_time"];
    endstr=[tempdic objectForKey:@"end_time"];
    dresscodestr=[tempdic objectForKey:@"dress_code"];
    venuestr=[tempdic objectForKey:@"venue"];
    budgetstr=[tempdic objectForKey:@"budget"];
    
        //cell.EventLbl.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.EventLbl.text=eventnamestr;
   // NSLog(@"%@",eventnamestr);
    
    [cell.editBtn addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    
    [cell.categoryBtn addTarget:self action:@selector(Category:) forControlEvents:UIControlEventTouchUpInside];
    cell.categoryBtn.tag = indexPath.row;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    int cellheight=40;
//    if([[UIScreen mainScreen] bounds].size.height  < 600)
//    {
//        if ([[UIScreen mainScreen] bounds].size.height == 568)
//        {
//            
//            cellheight=cellheight+20;
//            
//            
//        }
//        else if ([[UIScreen mainScreen] bounds].size.height == 480)
//        {
//            
//            //no change
//            
//        }
//        else
//        {
//            //no change
//            
//        }
//        
//        
//    }
//    else
//    {
//        if ([[UIScreen mainScreen] bounds].size.height == 1024)
//        {
//            
//            cellheight=cellheight+40;
//            
//        }
//        else
//        {
//            
//            cellheight=cellheight+80;
//        }
//    }
//    // NSLog(@"cellheight-- %d",cellheight);
//    return cellheight;
//    
//}

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
    [EventTable reloadData];
}
-(void) Edit:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
    NSLog(@"%@",eventnamestr);
    EditEventViewController *EditeventVc=[[EditEventViewController alloc] init];
    NSDictionary *tempdic=[raweventList objectAtIndex:button.tag];
    EditeventVc.eventidstr=[tempdic objectForKey:@"event_id"];
    EditeventVc.eventnamestr=[tempdic objectForKey:@"event_name"];
    EditeventVc.startstr=[tempdic objectForKey:@"start_time"];
    EditeventVc.endstr=[tempdic objectForKey:@"end_time"];
    EditeventVc.dresscodestr=[tempdic objectForKey:@"dress_code"];
    EditeventVc.venuestr=[tempdic objectForKey:@"venue"];
    EditeventVc.budgetstr=[tempdic objectForKey:@"budget"];
    [self.navigationController pushViewController:EditeventVc animated:YES];
}
-(void) Category:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
}
-(void)image
{
     long tableRowheight=50*[raweventList count];
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
       
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
            
        }
        else
        {
            int tableRowheight = 100*50;
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        
        
    }
    else
    {
        //[bgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
       
        EventTable.frame=CGRectMake(0, 0, 320,tableRowheight*2);
        EventScroll.contentSize = CGSizeMake(320,tableRowheight);
        
        
    }
}


@end
