//
//  AddBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AddBudget.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_create&"]
#define URL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&"]

@interface AddBudget ()

@end

@implementation AddBudget
@synthesize eventidpass;
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
    [self image];
    [paymentduedatetext setInputView:datepickerView];
    [vendernametext setInputView:respondingView];
    [datepickerVW setDate:[NSDate date]];
    json =[[NSMutableArray alloc]init];
    vendorname =[[NSMutableArray alloc]init];
    vendorid =[[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"]]];
    NSLog(@"my--%@",url);
    
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
    
    
    
    for (NSDictionary *data in [json valueForKey:@"data"] ) {
        [vendorname addObject:[data valueForKey:@"vendor_name"]];
        [vendorid addObject:[data valueForKey:@"vendor_id"]];
        
    }
    
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy hh:mm a"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

#pragma -pickerview delecates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
        return [vendorname count];
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
        return [vendorname objectAtIndex:row];

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    vendernametext.text=[vendorname objectAtIndex:row];
    vendoridpass=[vendorid objectAtIndex:row];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)save:(id)sender {
    //********** give event id...
    NSString *savedata =[[NSString alloc]initWithFormat:@"event_id=%@&name=%@&vendor_id=%@&due_date=%@&amount_due=%@&amount_paid=%@&info=%@&apikey=micronix_10_2014_wedsimple_proj",eventidpass,eventnametext.text,vendoridpass,paymentduedatetext.text,totalamountduetext.text,amountpaidtodatetext.text,infotext.text];
    NSString* urlTextEscaped = [savedata stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,urlTextEscaped]] ;
    NSLog(@"%@",url);
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    
    
}

- (IBAction)done:(id)sender
{
    if (!(vendernametext.text.length>0)) {
        
        vendernametext.text=[vendorname objectAtIndex:0];
    }
    [vendernametext resignFirstResponder];
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    vendernametext.text=@"";
    [vendernametext resignFirstResponder];
}
- (IBAction)donedate:(id)sender
{
    paymentduedatetext.text=[self formatDate:datepickerVW.date];
    [paymentduedatetext resignFirstResponder];
}
- (IBAction)canceldate:(UIBarButtonItem *)sender
{
    paymentduedatetext.text=@"";
    [paymentduedatetext resignFirstResponder];
    
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [save setBackgroundImage:[UIImage imageNamed:@"add-budgest_iphone.png"] forState:UIControlStateNormal];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [background setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [background setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [background setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [background setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
             [save setBackgroundImage:[UIImage imageNamed:@"add-budget.png"] forState:UIControlStateNormal];
            
            
        }
        
    }
}


@end
