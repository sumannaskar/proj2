//
//  AddEventViewController.m
//  WedingProj
//
//  Created by Micronix on 24/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AddEventViewController.h"
#import "AddBudgetViewController.h"
#import "EventViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define AddEventURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=event_create&"]

@interface AddEventViewController ()

@end

@implementation AddEventViewController

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
    nametxt.delegate=self;
    venuetxt.delegate=self;
    self.datetxt.delegate=self;
     self.dateendtxt.delegate=self;
    
    self.datetxt.tag=1;
    self.dateendtxt.tag=2;
    
    
    scroll.contentSize=CGSizeMake(320, 500);
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    [self.dresscodetxt setInputView:self.respondingView];
    [self.datetxt setInputView:self.datepickerView];
    [self.dateendtxt setInputView:self.datepickerView];
    
    [self.datepickerVW setDate:[NSDate date]];
    
    pkarray=[[NSArray alloc]initWithObjects:@"Unspecified",@"Formal",@"Casual",@"Black Tie",@"White Tie",@"Cocktail", nil];
    
}

-(void)AddDetails
{
    NSString *AddtaskData=[[NSString alloc]initWithFormat:@"&user_id=%@&event_name=%@&venue=%@&start_time=%@&end_time=%@&budget=%@&dress_code=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],nametxt.text,venuetxt.text,self.datetxt.text,self.dateendtxt.text,@"0",self.dresscodetxt.text];
    NSString* urlTextEscaped = [AddtaskData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AddEventURL,urlTextEscaped]];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",url);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    AddData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    AddEventmessage= [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    
    
    if([[AddEventmessage valueForKey:@"status" ] isEqualToString:@"Record Created"])
    {
        UIAlertView *addsuccess=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Added Successfully\nDo you want to create budget?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        addsuccess.tag = 10;
        [addsuccess show];
//        EventViewController *EventlistVc=[[EventViewController alloc] init];
//        [self.navigationController pushViewController:EventlistVc animated:YES];
        
    }
    else
    {
        UIAlertView *addfailed=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Task not added, Try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [addfailed show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag==10) {
        if (buttonIndex == 0) {
            EventViewController *EventlistVc=[[EventViewController alloc] init];
            [self.navigationController pushViewController:EventlistVc animated:YES];
        }
        if (buttonIndex == 1)
        {
//            AddBudgetViewController *AddBudgetVc=[[AddBudgetViewController alloc] init];
//            AddBudgetVc.eventidstr = self.eventidstr;
//            [self.navigationController pushViewController:AddBudgetVc animated:YES];
        }

    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
            } else {
        NSLog(@"Other pressed");
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        self.donedatebtn.tag=1;
        self.canceldatebtn.tag=1;
        
    }
    if (textField.tag==2) {
        self.donedatebtn.tag=2;
        self.canceldatebtn.tag=2;
    }
}
#pragma mark -
#pragma mark - picker view delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rowCount;
    //rowCount= [location count];
    rowCount=[pkarray count];
    return rowCount;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
   // return [location objectAtIndex:row];
    return [pkarray objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
     self.dresscodetxt.text=[pkarray objectAtIndex:row];

    
}

- (IBAction)done:(id)sender
{
    
    if (!(self.dresscodetxt.text.length>0)) {
        //        mytxtfield.text=[stateList objectAtIndex:0];
        //        self.stateName=[stateList objectAtIndex:0];
        
        self.dresscodetxt.text=[pkarray objectAtIndex:0];
//        addressdetailsText.text=[address objectAtIndex:0];
//        loactionName=[location objectAtIndex:0];
    }
    
    [self.dresscodetxt resignFirstResponder];
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    self.dresscodetxt.text=@"";
    
    //addressdetailsText.text=@"";
    
    
    [self.dresscodetxt resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donedate:(id)sender
{

    if (self.donedatebtn.tag==1) {
        self.datetxt.text=[self formatDate:self.datepickerVW.date];
        // _datetxt.text=[NSString stringWithFormat:@"%@",_datepickerVW.date];
        
        [self.datetxt resignFirstResponder];
    }
    else
    {
    
     self.dateendtxt.text=[self formatDate:self.datepickerVW.date];
     [self.dateendtxt resignFirstResponder];
   // [_dateendtxt resignFirstResponder];
    }

}
- (IBAction)canceldate:(UIBarButtonItem *)sender
{
    if (self.canceldatebtn.tag==1)
    {
        self.datetxt.text=@"";
        [self.datetxt resignFirstResponder];
    }
    else
    {
        self.dateendtxt.text=@"";
        [self.dateendtxt resignFirstResponder];
    }
   }

- (IBAction)AddEventactn:(UIButton *)sender {
    
    if (nametxt.text.length >0 && venuetxt.text.length >0 &&self.datetxt.text.length>0 && self.dateendtxt.text.length>0 && self.dresscodetxt.text.length>0)
    {
        
        [self AddDetails];
        
    }
    else
    {
        UIAlertView *fillall =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Fill all the fields" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [fillall show];
    }

}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy hh:mm a"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [addeventbtn setBackgroundImage:[UIImage imageNamed:@"add-event_iphone.png"] forState:UIControlStateNormal];
        
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
            [addeventbtn setBackgroundImage:[UIImage imageNamed:@"add-event.png"] forState:UIControlStateNormal];
            
        }
        
    }
}


@end
