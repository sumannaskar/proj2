//
//  CalculateBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/22/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "CalculateBudget.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
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
    json=[[NSMutableArray alloc]init];
    
    yourbudgettext.text =  [NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"]] ;
    NSLog(@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"]);
    
    
   
    [self recievedata];
    
    
}


 -(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    allocatetext.text=[json valueForKey:@"allocated_budget"];
    balancemaintext.text=[json valueForKey:@"remaining_budget"];
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)recievedata
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user_id=%@&total=%@&apikey=micronix_10_2014_wedsimple_proj",URL,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],yourbudgettext.text]];
    
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

    
}
-(void)senddata
{
    
}


-(void)retrivedata
{
    if ([yourbudgettext.text intValue] ==[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"]) {
        
    }
    else
    {
        [self savedata];
    }
}

-(void)savedata
{
    if (yourbudgettext.text.length > 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:[yourbudgettext.text intValue] forKey:@"HighScoreSaved"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"HighScoreSaved"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    
    [self recievedata];
    [self retrivedata];
    
}

- (IBAction)calculate:(id)sender {
    
    
    
    
    
}
@end
