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
#define EditURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_single&"]
#define UpdateURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_budget&"]


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
    Editjson = [[NSDictionary alloc]init];
    Editjsondata = [[NSDictionary alloc]init];
    EditName = [[NSMutableArray alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"category_id=%@&apikey=micronix_10_2014_wedsimple_proj",self.CategoryId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",EditURL,string]];
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
             [self performSelectorOnMainThread:@selector(fetchedData1:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );

}
-(void)fetchedData1:(NSData *)responseData
{
    NSError *error;
    Editjson = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    if ([[Editjson valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        Editjsondata = [Editjson valueForKey:@"data"];
        eventnametext.text = [Editjsondata valueForKey:@"category_name"];
        vendernametext.text = [Editjsondata valueForKey:@"vendor_name"];
        self.VId = [Editjsondata valueForKey:@"vendor_id"];
        paymentduedatetext.text = [Editjsondata valueForKey:@"due_date"];
        totalamountduetext.text = [Editjsondata valueForKey:@"amount_due"];
        amountpaidtodatetext.text = [Editjsondata valueForKey:@"amount_paid"];
        infotext.text = [Editjsondata valueForKey:@"info"];
    }

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
-(void)fetchedData2:(NSData *)responseData
{
    NSError *error;
    Updatejson = [NSJSONSerialization
                JSONObjectWithData:responseData //1
                
                options:kNilOptions
                error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:[Updatejson valueForKey:@"status"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    if ([[Updatejson valueForKey:@"status"]isEqualToString:@"Record Updated"]) {
        [self.navigationController popViewControllerAnimated:YES];
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
    
    
    vendernametext.text=[vendorName objectAtIndex:row];
    self.VId = [vendorId objectAtIndex:row];
    NSLog(@"suman");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    Updatejson = [[NSDictionary alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"category_id=%@&category_name=%@&vendor_id=%@&due_date=%@&amount_due=%@&amount_paid=%@&info=%@&apikey=micronix_10_2014_wedsimple_proj",self.CategoryId,eventnametext.text,self.VId,paymentduedatetext.text,totalamountduetext.text,amountpaidtodatetext.text,infotext.text];
    NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UpdateURL,urlTextEscaped]];
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
             [self performSelectorOnMainThread:@selector(fetchedData2:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );

}

- (IBAction)done:(id)sender
{
    if (!(vendernametext.text.length>0)) {
    }
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    vendernametext.text = [Editjsondata valueForKey:@"vendor_name"];
    self.VId = [Editjsondata valueForKey:@"vendor_id"];
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
    NSLog(@"suman");
}

@end
