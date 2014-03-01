//
//  CalculateBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/22/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "CalculateBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_cal&"]

@interface CalculateBudget ()

@end

@implementation CalculateBudget

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
    
   /*
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user_id=%@&total=500&apikey=micronix_10_2014_wedsimple_proj",URL,@"10"]];
    
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
             [self performSelectorOnMainThread:@selector(fetchedData:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );
*/
    
    
}

/*
 -(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    
    for (NSDictionary *data in json ) {
        [vendorname addObject:[data valueForKey:@"vendor_name"]];
        [vendorid addObject:[data valueForKey:@"vendor_id"]];
        
    }
    [managevendortable reloadData];
    
}
*/
-(void)recievedata
{
    
    
    
}
-(void)senddata
{
    
}


-(void)retrivedata
{
    NSString *myString = [prefs stringForKey:@"keyToLookupString"];
}

-(void)savedata
{
    prefs = [NSUserDefaults standardUserDefaults];
    if (yourbudgettext.text.length > 0) {
        [prefs setObject:yourbudgettext.text forKey:@"keyToLookupString"];
    }
    else
    {
        [prefs setObject:@"0" forKey:@"keyToLookupString"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    [self savedata];
    
    
}
@end
