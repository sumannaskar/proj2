//
//  RSVPViewController.m
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "RSVPViewController.h"
#import "DestailsRSVPViewController.h"
#define kRSVPURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=RSVP_check&"]
#define kRSVPURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface RSVPViewController ()

@end

@implementation RSVPViewController

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
    [self image];
    NSURL *tempurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@event_id=%@%@",kRSVPURL1,self.eventID,kRSVPURL2]];
    NSLog(@"%@",tempurl);
    dispatch_async(kBgQueue, ^{
        
        NSError *error;
        NSData* RsvpData = [NSData dataWithContentsOfURL: tempurl];
        rawrsvplistdic = [NSJSONSerialization JSONObjectWithData:RsvpData options:kNilOptions error:&error];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:nil waitUntilDone:YES];
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (void)fetchedData:(NSData *)responseData
{
   
    invitationsentresult.text=[rawrsvplistdic objectForKey:@"Invitation sent"];
    acceptedresultlbl.text=[rawrsvplistdic objectForKey:@"Accepted"];
    rejectedresltlbl.text=[rawrsvplistdic objectForKey:@"Rejected"];
    notsureresltlbl.text=[rawrsvplistdic objectForKey:@"Not Sure"];

}

- (IBAction)Detailsactn:(UIButton *)sender {
    
    DestailsRSVPViewController *detailsrsvVC=[[DestailsRSVPViewController alloc]init];
    detailsrsvVC.eventId = self.eventID;
    [self.navigationController pushViewController:detailsrsvVC animated:YES];
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [morebtn setBackgroundImage:[UIImage imageNamed:@"send_y-iphone.png"] forState:UIControlStateNormal];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [backgroundimgV setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            [morebtn setBackgroundImage:[UIImage imageNamed:@"send_y-iphone.png"] forState:UIControlStateNormal];
            
        }
        
    }
}

@end
