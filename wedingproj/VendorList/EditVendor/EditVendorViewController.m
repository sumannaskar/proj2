//
//  EditVendorViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "EditVendorViewController.h"
#import "SSKeychain.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_user&"]

#define SaveURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_update&"]
@interface EditVendorViewController ()

@end

@implementation EditVendorViewController

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
    NSLog(@"%@",self.Vname);
    vendornametext.text = self.Vname;
     categorytext.text = self.Vcat;
     contactnotext.text = self.Vcontact;
     emailtext.text = self.Vemail;
    
    json = [[NSDictionary alloc]init];
    Jsondata = [[NSMutableArray alloc]init];
    
    //Scroll.contentSize = CGSizeMake(320, 400);
    
    self.pickerVw.showsSelectionIndicator=YES;
    [categorytext setInputView:self.respondingView];
    vendornametext.delegate = self;
    categorytext.delegate = self;
    emailtext.delegate = self;
    contactnotext.delegate = self;
    
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
    savejson = [[NSDictionary alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"vendor_id=%@&user_id=%@&vendor_name=%@&category_name=%@&email=%@&contact=%@&apikey=micronix_10_2014_wedsimple_proj",self.Vid,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],vendornametext.text,categorytext.text,emailtext.text,contactnotext.text];
    NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SaveURL,urlTextEscaped]];
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
             [self performSelectorOnMainThread:@selector(fetchedData1:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );


}
-(void)fetchedData1:(NSData *)responseData
{
    NSError *error;
    savejson = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    //NSLog(@"%@",[json valueForKey:@"availability"]);
    if ([[savejson valueForKey:@"status"]isEqualToString:@"Record Updated"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Record Updated" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    else{
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"Fail to update" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
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

@end
