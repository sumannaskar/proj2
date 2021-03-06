//
//  TodolistViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.


#import "TodolistViewController.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define NIB_NAME @"Cell3"
#define ktodolistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=to_do"]
#define ktodolistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define ToDolistDeleteURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=to_do_delete&"]
#define ToDolistDeleteURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface TodolistViewController ()

@end

@implementation TodolistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [EventTable reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)];
//    [self.navigationItem setRightBarButtonItem:add];
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    EventScroll.delegate = self;
    EventTable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
    
    NSURL *tempurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@%@",ktodolistURL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],ktodolistURL2]];
    NSLog(@"%@",tempurl);
    
    dispatch_async(kBgQueue, ^{
        //        NSURL *tempUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",firstCatagoryURL,self.deviceString,secondCatagoryURL]];
        NSData *tempcatagorydata=[NSData dataWithContentsOfURL:tempurl];
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
            json=[NSJSONSerialization JSONObjectWithData:tempcatagorydata options:kNilOptions error:&error];
            rawtaskList = [[NSArray alloc]init];
            if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
                
//                UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"No Task Found\nDo You Want To Create a new Task Now? " delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
//                [createbudget show];
                [self performSelectorOnMainThread:@selector(Alert) withObject:nil waitUntilDone:YES];
               
            }
            else
            {
                rawtaskList = [json valueForKey:@"data"];
//            NSArray *tempArray=[NSJSONSerialization JSONObjectWithData:tempcatagorydata options:kNilOptions error:&error];
//            rawtaskList = [[NSArray alloc]initWithArray:tempArray];
            totaltaskid=[[NSMutableArray alloc]init];
            
            for(int i=0;i<rawtaskList.count;i++)
            {
                NSDictionary *tempDict=[rawtaskList objectAtIndex:i];
                
                [totaltaskid addObject:[tempDict objectForKey:@"task_id"]];
                
            }
            

            
            
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:nil waitUntilDone:YES];
            
            
        }
        
        }
       
        
    });
     [EventTable reloadData];

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if (buttonIndex == 0)
    {
        AddTaskViewController *AddTaskVC = [[AddTaskViewController alloc]init];
        [self.navigationController pushViewController:AddTaskVC animated:YES];
    }
//    else if (buttonIndex == 1)
//    {
////        ManageBudget *ManageBudget_ =[[ManageBudget alloc]init];
////        [self.navigationController pushViewController:ManageBudget_ animated:YES];
//    }
}
- (void)Alert
{
    UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"No Task Found\nDo You Want To Create a new Task Now? " delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [createbudget show];
    [EventScroll addSubview:EventTable];
    [EventTable reloadData];
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
    AddTaskViewController *AddeventVc=[[AddTaskViewController alloc] init];
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
        [self deletetask];
    }
    else
    {
        UIAlertView *nodelete=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"At least Select one Task to delete" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nodelete show];
        
    }

}

-(void)deletetask
{
    NSError *error;
    NSString *str1 = @"-";
    NSString *str2;
    NSString *str3 = @"";
    for (int i=0; i<[totaltaskid count]; i++) {
        if ([[checkImage objectAtIndex:i]isEqualToString:@"index.jpg"]) {
            
            str2=[NSString stringWithFormat:@"%@%@",[totaltaskid objectAtIndex:i],str1];
            str3=[NSString stringWithFormat:@"%@%@",str3, str2];
            
        }
    }
    NSString *str4 = [str3 substringToIndex:[str3 length]-1];
    NSString *deleteTask =[[NSString alloc]initWithFormat:@"task_id=%@%@",str4,ToDolistDeleteURL2];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ToDolistDeleteURL1,deleteTask]];
    NSData* deletetasklistdata = [NSData dataWithContentsOfURL: url];
    NSArray* rawdeletetaskList = [NSJSONSerialization JSONObjectWithData:deletetasklistdata options:kNilOptions error:&error];
    NSLog(@"%@",rawdeletetaskList);
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
    return [rawtaskList count];
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
    
    cell = (Cell3 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
     NSLog(@"%@",rawtaskList);
    NSDictionary *tempdic=[rawtaskList objectAtIndex:indexPath.row];
    NSLog(@"%@",[tempdic objectForKey:@"task_name"]);
    tasknamestr=[tempdic objectForKey:@"task_name"];
    
    
    //cell.EventLbl.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.EventLbl.text=tasknamestr;
    NSLog(@"%@",tasknamestr);
    
    
    [cell.editBtn addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    
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
    EditTaskViewController *EditTaskVc=[[EditTaskViewController alloc] init];
    NSDictionary *tempdic=[rawtaskList objectAtIndex:button.tag];
    EditTaskVc.taskidstr=[tempdic objectForKey:@"task_id"];
    EditTaskVc.tasknamestr=[tempdic objectForKey:@"task_name"];
    EditTaskVc.duedatestr=[tempdic objectForKey:@"due_date"];
    EditTaskVc.categorystr=[tempdic objectForKey:@"category"];
    NSLog(@"%@%@",[tempdic objectForKey:@"event_name"],[tempdic objectForKey:@"event_id"]);
    EditTaskVc.eventnamestr=[tempdic objectForKey:@"event_name"];
    EditTaskVc.Eventid=[tempdic objectForKey:@"event_id"];
    EditTaskVc.vendorstr=[tempdic objectForKey:@"vendor_name"];
    EditTaskVc.Vendorid=[tempdic objectForKey:@"vendor_id"];
    EditTaskVc.statusstr=[tempdic objectForKey:@"status"];
    EditTaskVc.infotxtstr=[tempdic objectForKey:@"info"];

    [self.navigationController pushViewController:EditTaskVc animated:YES];
    
}

-(void)image
{
    NSInteger tableRowheight = 50*[rawtaskList count];
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
       {
//            int tableRowheight = 100*50;
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
            
        }
        else
        {
//            int tableRowheight = 100*50;
            EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            EventScroll.contentSize = CGSizeMake(320, tableRowheight);
        }
        
        
    }
    else
    {
        //[bgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
//        int tableRowheight = 100*50;
        EventTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        EventScroll.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
}


@end
