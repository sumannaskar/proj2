//
//  DestailsRSVPViewController.m
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DestailsRSVPViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=RSVP_check_guest&"]


@interface DestailsRSVPViewController ()

@end

@implementation DestailsRSVPViewController

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
    guestId = [[NSMutableArray alloc]init];
    guestName = [[NSMutableArray alloc]init];
    guestResponse = [[NSMutableArray alloc]init];
    
    
    NSString *string =[[NSString alloc]initWithFormat:@"event_id=%@&apikey=micronix_10_2014_wedsimple_proj",self.eventId];
    
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
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        jsondata = [json valueForKey:@"data"];
        for(int i=0;i<jsondata.count;i++) {
            
            [guestId addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_id"]];
            
        }
        for(int i=0;i<jsondata.count;i++) {
            
            [guestName addObject:[[jsondata objectAtIndex:i ] valueForKey:@"guest_name"]];
            
        }
        for(int i=0;i<jsondata.count;i++) {
            
            [guestResponse addObject:[[jsondata objectAtIndex:i ] valueForKey:@"response"]];
            
        }
        [self.rsvpTable reloadData];
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
    return [guestName count];
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
         cell.textLabel.text=[guestName objectAtIndex:indexPath.row];
         
         UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 72, 37)];
         status.text = [guestResponse objectAtIndex:indexPath.row];
         
         cell.accessoryType = UITableViewCellAccessoryNone;
         cell.accessoryView = status;
         //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         return cell;
     }
     return cell;

//[NSString stringWithFormat:@"%d",a];

 }


@end
