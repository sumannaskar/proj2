//
//  EditBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_update&"]
#define URL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&apikey=micronix_10_2014_wedsimple_proj"]


@interface EditBudget ()

@end

@implementation EditBudget
@synthesize eventnamepass,infopass,paymentduedatepass,vendernamepass,amountpaidtodatepass,totalamountduepass,budgetidpass,eventidpass,vendoridpass;

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
    [paymentduedatetext setInputView:datepickerView];
    
   // pkarray=[[NSArray alloc]initWithObjects:@"A",@"B", nil];
    [datepickerVW setDate:[NSDate date]];
    json =[[NSMutableArray alloc]init];
    
    
    paymentduedatetext.text=paymentduedatepass;
    eventnametext.text=eventnamepass;
    infotext.text=infopass;
    vendernametext.text=vendernamepass;
    amountpaidtodatetext.text=amountpaidtodatepass;
    totalamountduetext.text=totalamountduepass;
    if (vendernametext.text.length > 0) {
        vendernametext.userInteractionEnabled=NO;
    }
    else
    {
        vendernametext.userInteractionEnabled=YES;
        [vendernametext setInputView:respondingView];
        
        vendorname =[[NSMutableArray alloc]init];
        vendorid =[[NSMutableArray alloc]init];
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL1]];
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
    
}


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
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd"];
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSString *savedata =[[NSString alloc]initWithFormat:@"budget_id=%@&event_id=%@&name=%@&vendor_id=%@&due_date=%@&amount_due=%@&amount_paid=%@&info=%@&apikey=micronix_10_2014_wedsimple_proj",budgetidpass,eventidpass,eventnametext.text,vendoridpass,paymentduedatetext.text,amountpaidtodatetext.text,amountpaidtodatetext.text,infotext.text];
    NSString* urlTextEscaped = [savedata stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,urlTextEscaped]] ;
    
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
        
    vendernametext.text=[pkarray objectAtIndex:0];
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
    paymentduedatetext.text=paymentduedatepass;
    [paymentduedatetext resignFirstResponder];
    
}

@end
