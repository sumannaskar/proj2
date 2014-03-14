//
//  RegisterViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#define RegisterURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=user_create&"]
#define RegisterURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define CountryListURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=country&apikey=micronix_10_2014_wedsimple_proj"]

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    NSLog(@"Sourabh");
    // Do any additional setup after loading the view from its nib.
    
    //Country List Fetching
    NSError *error;
    NSData* CountryListData = [NSData dataWithContentsOfURL: CountryListURL];
    NSArray* rawcountryList = [NSJSONSerialization JSONObjectWithData:CountryListData options:kNilOptions error:&error];
    
    totalCountrylist=[[NSMutableArray alloc ]init];
    totalCountryIdlist=[[NSMutableArray alloc ]init];
    
    for(int i=0;i<rawcountryList.count;i++)
    {
        NSDictionary *tempDict=[rawcountryList objectAtIndex:i];
        [totalCountrylist addObject:[tempDict objectForKey:@"name"]];
        [totalCountryIdlist addObject:[tempDict objectForKey:@"code"]];
        
    }

    
    
    groomnametxt.delegate=self;
    bridenametxt.delegate=self;
    emailtxt.delegate=self;
    passwrdtxt.delegate=self;
    confirmpwdtxt.delegate=self;
    self.countrytxt.delegate=self;
    self.datetxt.delegate=self;
    
    
    scroll.contentSize=CGSizeMake(320, 500);
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    [self.countrytxt setInputView:self.respondingView];
    [self.datetxt setInputView:self.datepickerView];
    
    
    [self.datepickerVW setDate:[NSDate date]];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)AddUserDetails
{
    NSString *AddUserData=[[NSString alloc]initWithFormat:@"groom_name=%@&bride_name=%@&password=%@&u_email=%@&wedding_date=%@&country=%@%@",groomnametxt.text,bridenametxt.text,passwrdtxt.text,emailtxt.text,self.datetxt.text,countrycode,RegisterURL2];
    NSString* urlTextEscaped = [AddUserData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RegisterURL1,urlTextEscaped]];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",url);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    AddUserDataStr=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    AddUsermessage= [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    
    
    if([[AddUsermessage valueForKey:@"status" ] isEqualToString:@"email already registered"])
    {
        UIAlertView *addfail=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Email ID already Registered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [addfail show];
        
        
    }
    else
    {
        NSLog(@"%@",[AddUsermessage valueForKey:@"status" ]);
        UIAlertView *addsucess =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:[NSString stringWithFormat:@"%@ and login ",[AddUsermessage valueForKey:@"status" ]] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [addsucess show];
        LoginViewController *LoginVC =[[LoginViewController alloc]init];
       
        [self.navigationController pushViewController:LoginVC animated:YES];
        
    }
}

- (IBAction)registeractn:(UIButton *)sender {
    
    if (groomnametxt.text.length >0 && bridenametxt.text.length >0 &&passwrdtxt.text.length>0 && confirmpwdtxt.text.length>0&& emailtxt.text.length>0 && self.datetxt.text.length>0 && self.countrytxt.text.length>0)
    {
        if (![passwrdtxt.text isEqualToString:confirmpwdtxt.text]) {
            UIAlertView *passwordnotmatch =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"password doesnot match" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [passwordnotmatch show];
        }
        else
        {
            NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
            if  ([emailTest evaluateWithObject:emailtxt.text] != YES && [emailtxt.text length]!=0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wedding Project" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
            else{
                //[HUD showUIBlockingIndicatorWithText:@"Loading"];
                [self AddUserDetails];
            }
            
        }
        
    }
    else
    {
        
        
        UIAlertView *fillall =[[UIAlertView alloc]initWithTitle:@"Wedding App" message:@"fill all the fields" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [fillall show];
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - picker view delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    NSInteger rowCount;
//    //rowCount= [location count];
//    rowCount=[pkarray count];
//    return rowCount;
    NSLog(@"%lu",(unsigned long)totalCountrylist.count);
    //return [totalCountrylist count];
    return 200;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    // return [location objectAtIndex:row];
   // return [pkarray objectAtIndex:row];
    return [totalCountrylist objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.countrytxt.text=[totalCountrylist objectAtIndex:row];
    countrycode=[totalCountryIdlist objectAtIndex:row];
    
    
}


- (IBAction)done:(id)sender
{
    if (!(self.countrytxt.text.length>0)) {
        self.countrytxt.text=[totalCountrylist objectAtIndex:0];
        countrycode=[totalCountryIdlist objectAtIndex:0];
        
    }
    
    [self.countrytxt resignFirstResponder];
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    self.countrytxt.text=@"";
    [self.countrytxt resignFirstResponder];
}
- (IBAction)donedate:(UIBarButtonItem *)sender
{
    self.datetxt.text=[self formatDate:self.datepickerVW.date];
    [self.datetxt resignFirstResponder];
    
}
- (IBAction)canceldate:(UIBarButtonItem *)sender
{
    self.datetxt.text=@"";
    [self.datetxt resignFirstResponder];

}



- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [registerbtn setBackgroundImage:[UIImage imageNamed:@"registration-320_iphone.png"] forState:UIControlStateNormal];
        
        
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
            [backgroundimgV setImage:[UIImage imageNamed:@"registration.png"]];
            [registerbtn setBackgroundImage:[UIImage imageNamed:@"normal-background-320.jpg"] forState:UIControlStateNormal];
            
        }
        
    }
}



@end
