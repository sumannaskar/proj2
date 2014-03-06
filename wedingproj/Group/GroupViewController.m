//
//  GroupViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/6/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "GroupViewController.h"
#import "SSKeychain.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GroupURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=groups&"]
#define UpdateURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=group_update&"]
@interface GroupViewController ()

@end

@implementation GroupViewController

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
   
    
   
    [self jsonMethod];
   
}
-(void)jsonMethod
{
    jsondata = [[NSDictionary alloc]init];
    json = [[NSMutableArray alloc]init];
    Gid = [[NSMutableArray alloc]init];
    Gname = [[NSMutableArray alloc]init];
    
     NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GroupURL,string]];
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
             NSLog(@"server Fail..");
             
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
    jsondata = [NSJSONSerialization
                JSONObjectWithData:responseData //1
                
                options:kNilOptions
                error:&error];
    if ([[jsondata valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No group found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        json = [jsondata valueForKey:@"data"];
        for(int i=0;i<json.count;i++) {
            
            [Gid addObject:[[json objectAtIndex:i ] valueForKey:@"group_id"]];
            
        }
        for(int i=0;i<json.count;i++) {
            
            [Gname addObject:[[json objectAtIndex:i ] valueForKey:@"group_name"]];
            
        }
        [GroupTable reloadData];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellidentifire;
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
    if(cell==nil)
    {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
        cell.textLabel.text=[Gname objectAtIndex:indexPath.row];
        
        UIButton *EditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        EditButton.frame = CGRectMake(0, 0, 72, 37);
        [EditButton setTitle:@"Edit" forState:UIControlStateNormal];
        [EditButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        EditButton.tag = indexPath.row;
       // [EditButton setImage:[UIImage imageNamed:@"book-avilable.png"] forState:UIControlStateNormal];
        [EditButton addTarget:self action:@selector(EditButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = EditButton;
        //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        return cell;
    }
    return cell;
    
    //[NSString stringWithFormat:@"%d",a];
    
}
-(void)EditButtonTapped:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);
    GroupId = [Gid objectAtIndex:button.tag];
    UIAlertView *EditGroup =[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Edit Group Name" delegate:self cancelButtonTitle:@"done" otherButtonTitles:nil, nil];
    EditGroup.alertViewStyle =  UIAlertViewStylePlainTextInput;
    [EditGroup textFieldAtIndex:0].keyboardType =UIKeyboardAppearanceDefault;
    //setdistance.tag=0;
    //setdistance.delegate =self;
    [EditGroup show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView textFieldAtIndex:0].text.length > 0) {
        jsonUpdate = [[NSDictionary alloc]init];
        //NSLog(@"%@",[alertView textFieldAtIndex:0].text);
        NSString *string =[[NSString alloc]initWithFormat:@"group_id=%@&group_name=%@&apikey=micronix_10_2014_wedsimple_proj",GroupId,[alertView textFieldAtIndex:0].text];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UpdateURL,string]];
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
                 NSLog(@"server Fail..");
                 
             }
             
             else
             {
                 [self performSelectorOnMainThread:@selector(fetchedData1:)
                                        withObject:data waitUntilDone:YES];
                 
             }
         }
         );

    }
    
    
}
-(void)fetchedData1:(NSData *)responseData{
    NSError *error;
    jsonUpdate = [NSJSONSerialization
                JSONObjectWithData:responseData //1
                
                options:kNilOptions
                error:&error];
    UIAlertView *UpdateStatus =[[UIAlertView alloc]initWithTitle:@"Wedding App" message:[jsonUpdate valueForKey:@"status"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [UpdateStatus show];

     [self jsonMethod];

}
@end
