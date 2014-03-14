//
//  EditBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditBudget.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define VendorURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&"]
#define URL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor&"]


@interface EditBudget ()

@end

@implementation EditBudget

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
    //vendernametext.delegate = self;
    vendernametext.tag = 50;
    
    [paymentduedatetext setInputView:datepickerView];
    [vendernametext setInputView:respondingView];
    
   // pkarray=[[NSArray alloc]initWithObjects:@"A",@"B", nil];
    [datepickerVW setDate:[NSDate date]];
    
   // NSLog(@"%@",self.CategoryName);
    
}
-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        jsondata = [json valueForKey:@"data"];
        for(int i=0;i<jsondata.count;i++ ) {
            [vendorName addObject:[[jsondata objectAtIndex:i ] valueForKey:@"vendor_name"]];
        }
        for(int i=0;i<jsondata.count;i++ ) {
            [vendorId addObject:[[jsondata objectAtIndex:i ] valueForKey:@"vendor_id"]];
        }
        [pickerVw reloadAllComponents];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 50) {
        json = [[NSDictionary alloc]init];
        jsondata = [[NSMutableArray alloc]init];
        vendorId = [[NSMutableArray alloc]init];
        vendorName = [[NSMutableArray alloc]init];
        
        NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&category_name=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],self.CategoryName];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VendorURL,string]];
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
                 
             }
             
             else
             {
                 [self performSelectorOnMainThread:@selector(fetchedData:)
                                        withObject:data waitUntilDone:YES];
                 
             }
         }
         );

    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'-'MM'-'yyyy hh:mm a"];
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
  
         return [vendorName count];
  
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
      return [vendorName objectAtIndex:row];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    
}

- (IBAction)done:(id)sender
{
    if (!(vendernametext.text.length>0)) {
        if (vendorName.count>0) {
             vendernametext.text=[vendorName objectAtIndex:0];
        }
        else{
            vendernametext.text=@"";
        }
   
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

@end
