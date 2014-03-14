//
//  AddVendorViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "AddVendorViewController.h"
#import "SSKeychain.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_user&"]

#define AddVendorURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_create&"]


@interface AddVendorViewController ()

@end

@implementation AddVendorViewController

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
    //Scroll.contentSize = CGSizeMake(320, 400);
    [self image];
    self.pickerVw.showsSelectionIndicator=YES;
    [categorytext setInputView:self.respondingView];
    vendornametext.delegate = self;
    categorytext.delegate = self;
    emailtext.delegate = self;
    contactnotext.delegate = self;
    
    
    json = [[NSDictionary alloc]init];
    Jsondata = [[NSMutableArray alloc]init];
//
//    Vid = [[NSMutableArray alloc]init];
//    Vname = [[NSMutableArray alloc]init];
//    Vcatagory = [[NSMutableArray alloc]init];
//    Vcontact = [[NSMutableArray alloc]init];
//    Vemail = [[NSMutableArray alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
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
    //NSLog(@"%@",[json valueForKey:@"availability"]);
    if ([[json valueForKey:@"availability"]isEqualToString:@"no"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"No record found" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        Jsondata = [json valueForKey:@"data"];
        // NSLog(@"%@",[Jsondata objectAtIndex:1]);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)save:(id)sender
{
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&vendor_name=%@&category_name=%@&email=%@&contact=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],vendornametext.text,categorytext.text,emailtext.text,contactnotext.text];
     NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AddVendorURL,urlTextEscaped]];
    NSLog(@"add--%@",url);
    
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
    addjson = [[NSDictionary alloc]init];
    
    NSError *error;
    addjson = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    NSLog(@"%@",[addjson valueForKey:@"status"]);
    if ([[addjson valueForKey:@"status"]isEqualToString:@"Record Created"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Record Created" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Fail to create" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rowCount;
    //rowCount= [location count];
    rowCount=[Jsondata count];
    return rowCount;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    // return [location objectAtIndex:row];
    return [Jsondata objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
//    categorytext.text=[totalcategorylist objectAtIndex:row];
    categorytext.text=[Jsondata objectAtIndex:row];
    
}

//- (IBAction)done:(id)sender
//{
//    categorytext.text=@"row";
//    
////    if (!(categorytext.text.length>0))
////    {
////        categorytext.text=[totalcategorylist objectAtIndex:0];
////    }
//    [categorytext resignFirstResponder];
//}
//- (IBAction)cancel:(UIBarButtonItem *)sender
//{
//    categorytext.text=@"";
//    [categorytext resignFirstResponder];
//}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    categorytext.text=@"";
    [categorytext resignFirstResponder];
}

- (IBAction)done:(UIBarButtonItem *)sender {
    
    if (!(categorytext.text.length>0))
    {
        categorytext.text=[Jsondata objectAtIndex:0];
    }
    [categorytext resignFirstResponder];
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [save setBackgroundImage:[UIImage imageNamed:@"add-vendor_iphone.png"] forState:UIControlStateNormal];
        
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            [save setBackgroundImage:[UIImage imageNamed:@"add-vendor.png"] forState:UIControlStateNormal];
            
            
        }
        
    }
}


@end
