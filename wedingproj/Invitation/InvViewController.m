//
//  InvViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "InvViewController.h"
#import "SelectEventViewController.h"
#import "SelectViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GroupURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=groups&"]

@interface InvViewController ()

@end

@implementation InvViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)IndividuallySend:(UIButton *)sender {
//    SendIndividuallyViewController *InvVC =[[SendIndividuallyViewController alloc]init];
//    [self.navigationController pushViewController:InvVC animated:YES];
    SelectEventViewController *InvVC =[[SelectEventViewController alloc]init];
    [self.navigationController pushViewController:InvVC animated:YES];
}

- (IBAction)GroupwiseSend:(UIButton *)sender {
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
        
    SelectViewController *SelectVC =[[SelectViewController alloc]init];
    
    SelectVC.GId = Gid;
    SelectVC.Gname = Gname;
   // NSLog(@"%@")
    
    [self.navigationController pushViewController:SelectVC animated:YES];
    }
}

@end
