//
//  EditTaskViewController.m
//  WedingProj
//
//  Created by Micronix on 26/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditTaskViewController.h"
#import "TodolistViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define EditTaskURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=to_do_update&"]
#define keventlistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events"]
#define keventlistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define kcategorylistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_user"]
#define kcategorylistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#define kvendorlistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_category&"]
#define kvendorlistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

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
    self.vendortxt.userInteractionEnabled=NO;
    
    //Vendor-category Fetching....
    NSURL *tempcategoryurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@%@",kcategorylistURL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],kcategorylistURL2]];
    NSError *error;
    NSData* categoryListData = [NSData dataWithContentsOfURL: tempcategoryurl];
    NSDictionary* rawecategoryListDic = [NSJSONSerialization JSONObjectWithData:categoryListData options:kNilOptions error:&error];
   // NSArray *rawcategoryList=[[NSArray alloc]init];
    totalcategorylist=[[NSMutableArray alloc ]init];
    
    if ([[rawecategoryListDic valueForKey:@"availability"]isEqualToString:@"no"])
    {
        UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"No Category Found " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [createbudget show];
    }
    else
    {
        totalcategorylist = [rawecategoryListDic valueForKey:@"data"];
//        for(int i=0;i<rawcategoryList.count;i++)
//        {
//            
//            NSDictionary *tempDict=[rawcategoryList objectAtIndex:i];
//            [totalcategorylist addObject:[tempDict objectForKey:@"category"]];
//            
//        }
    }
    

    
    //event fetching....
    NSLog(@"%@",self.Vendorid);
     NSLog(@"%@",self.Eventid);
    NSURL *tempeventurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@%@",keventlistURL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],keventlistURL2]];
    
    NSData* eventListData = [NSData dataWithContentsOfURL: tempeventurl];
    NSDictionary* raweventListDic = [NSJSONSerialization JSONObjectWithData:eventListData options:kNilOptions error:&error];
    NSArray *raweventList=[[NSArray alloc]init];

        totaleventlist=[[NSMutableArray alloc ]init];
    totaleventIdlist=[[NSMutableArray alloc ]init];
    if ([[raweventListDic valueForKey:@"availability"]isEqualToString:@"no"])
    {
        UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"No Event Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [createbudget show];
    }
    else
    {
        raweventList = [raweventListDic valueForKey:@"data"];
    for(int i=0;i<raweventList.count;i++)
    {
        
        NSDictionary *tempDict=[raweventList objectAtIndex:i];
        [totaleventlist addObject:[tempDict objectForKey:@"event_name"]];
        [totaleventIdlist addObject:[tempDict objectForKey:@"event_id"]];
        
    }
    }
    
    nametxt.delegate=self;
    informationtxt.delegate=self;
    self.datetxt.delegate=self;
    self.categorytxt.delegate=self;
    self.vendortxt.delegate=self;
    self.eventtxt.delegate=self;
    self.statustxt.delegate=self;
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    [self.datetxt setInputView:self.datepickerView];
    [self.categorytxt setInputView:self.respondingView];
    [self.eventtxt setInputView:self.respondingView];
    [self.vendortxt setInputView:self.respondingView];
    [self.statustxt setInputView:self.respondingView];
    self.categorytxt.tag=1;
    self.eventtxt.tag=2;
    self.vendortxt.tag=3;
    self.statustxt.tag=4;
    
    
    scroll.contentSize=CGSizeMake(320, 500);
    
    pkarray=[[NSArray alloc]initWithObjects:@"Category1",@"Category2",@"Category3",@"Category4",@"Category5",@"Category6", nil];
    
    eventarray=[[NSArray alloc]initWithObjects:@"Event1",@"Event2",@"Event3",@"Event4",@"Event5",@"Event6", nil];
    
    vendorarray=[[NSArray alloc]initWithObjects:@"Vendor1",@"Vendor2",@"Vendor3",@"Vendor4",@"Vendor5", nil];
    
    statusarray=[[NSArray alloc]initWithObjects:@"NO",@"YES", nil];
    
    [self alreadyinrecord];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        
        self.pickerVw.tag=1;
        self.donebtn.tag=1;
        self.cancelbtn.tag=1;
        [self.pickerVw reloadAllComponents];
        
    }
    if (textField.tag==2) {
        self.pickerVw.tag=2;
        self.donebtn.tag=2;
        self.cancelbtn.tag=2;
        [self.pickerVw reloadAllComponents];
    }
    if (textField.tag==3) {
        
        self.pickerVw.tag=3;
        self.donebtn.tag=3;
        self.cancelbtn.tag=3;
        [self.pickerVw reloadAllComponents];
    }
    if (textField.tag==4) {
        
        self.pickerVw.tag=4;
        self.donebtn.tag=4;
        self.cancelbtn.tag=4;
        [self.pickerVw reloadAllComponents];
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
    
    if (self.pickerVw.tag==1) {
        
        //return [pkarray count];
        return [totalcategorylist count];
    }
    if (self.pickerVw.tag==2) {
        
        //return [eventarray count];
        return [totaleventlist count];
    }
    if (self.pickerVw.tag==3) {
        
        //return [vendorarray count];
        NSLog(@"%@",categoryName);
        //vendor data fetching
        NSError *error;
        NSURL *tempvendorurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@category=%@%@",kvendorlistURL1,categoryName,kvendorlistURL2]];
        NSData* vendorListData = [NSData dataWithContentsOfURL: tempvendorurl];
        NSDictionary* vendorListDic = [NSJSONSerialization JSONObjectWithData:vendorListData options:kNilOptions error:&error];
        
        
        totalvendorlist=[[NSMutableArray alloc ]init];
        totalvendorIdlist=[[NSMutableArray alloc ]init];
        NSArray* rawvendorList=[[NSArray alloc]init];
        if ([[vendorListDic valueForKey:@"availability"]isEqualToString:@"no"])
        {
            UIAlertView *createbudget =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"No Vendor Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [createbudget show];
        }
        else
        {
            rawvendorList = [vendorListDic valueForKey:@"data"];
            for(int i=0;i<rawvendorList.count;i++)
            {
                NSDictionary *tempDict=[rawvendorList objectAtIndex:i];
                [totalvendorlist addObject:[tempDict objectForKey:@"vendor_name"]];
                [totalvendorIdlist addObject:[tempDict objectForKey:@"vendor_id"]];
                
            }
            
        }
        
        
        
        return [totalvendorlist count];

    }
    if (self.pickerVw.tag ==4) {
        return [statusarray count];
    }
    return 0;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    
    
    if (self.pickerVw.tag==1) {
        //return [pkarray objectAtIndex:row];
        categoryName=[totalcategorylist objectAtIndex:row];
        NSLog(@"%@",categoryName);
        return [totalcategorylist objectAtIndex:row];
    }
    
    if (self.pickerVw.tag==2) {
       // return [eventarray objectAtIndex:row];
        return [totaleventlist objectAtIndex:row];
    }
    if (self.pickerVw.tag==3) {
        //return [vendorarray objectAtIndex:row];
        return [totalvendorlist objectAtIndex:row];
    }
    
    
    else
    {
        return [statusarray objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.pickerVw.tag==1) {
        //self.categorytxt.text=[pkarray objectAtIndex:row];
        self.categorytxt.text=[totalcategorylist objectAtIndex:row];
        
    }
    
    
    if (self.pickerVw.tag==2) {
//        self.eventtxt.text=[eventarray objectAtIndex:row];
        self.eventtxt.text=[totaleventlist objectAtIndex:row];
        self.Eventid=[totaleventIdlist objectAtIndex:row];
    }
    
    if (self.pickerVw.tag==3) {
//        self.vendortxt.text=[vendorarray objectAtIndex:row];
        self.vendortxt.text=[totalvendorlist objectAtIndex:row];
        self.Vendorid=[totalvendorIdlist objectAtIndex:row];
    }
    if (self.pickerVw.tag==4) {
        self.statustxt.text=[statusarray objectAtIndex:row];
    }
    
    
}

- (IBAction)done:(id)sender
{
    
    if (self.donebtn.tag==1) {
        if (!(self.categorytxt.text.length>0)) {
            
            self.categorytxt.text=[pkarray objectAtIndex:0];
            
        }
        self.vendortxt.text=@"";
        self.vendortxt.userInteractionEnabled=YES;
        [self.categorytxt resignFirstResponder];
        
    }
    
    if (self.donebtn.tag==2) {
        if (!(self.eventtxt.text.length>0)) {
            
//            self.eventtxt.text=[eventarray objectAtIndex:0];
            self.eventtxt.text=[totaleventlist objectAtIndex:0];
            self.Eventid=[totaleventIdlist objectAtIndex:0];
            
        }
        
        [self.eventtxt resignFirstResponder];
        
    }
    if (self.donebtn.tag==3) {
        if (!(self.vendortxt.text.length>0)) {
            
//            self.vendortxt.text=[vendorarray objectAtIndex:0];
            self.vendortxt.text=[totalvendorlist objectAtIndex:0];
            self.Vendorid=[totalvendorIdlist objectAtIndex:0];
            
        }
        
        [self.vendortxt resignFirstResponder];
        
    }
    if (self.donebtn.tag==4) {
        if (!(self.statustxt.text.length>0)) {
            
            self.statustxt.text=[statusarray objectAtIndex:0];
            
        }
        
        [self.statustxt resignFirstResponder];
        
    }
    
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    
    if (self.cancelbtn.tag==1) {
        
        self.categorytxt.text=self.categorystr;
        self.vendortxt.text=self.vendorstr;
        [self.categorytxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==2) {
        
        self.eventtxt.text=self.eventnamestr;
        [self.eventtxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==3) {
        
        self.vendortxt.text=self.vendorstr;
        [self.vendortxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==4) {
        
        self.statustxt.text=self.statusstr;
        [self.statustxt resignFirstResponder];
        
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [textView resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donedate:(id)sender
{
    self.datetxt.text=[self formatDate:self.datepickerVW.date];
    // _datetxt.text=[NSString stringWithFormat:@"%@",_datepickerVW.date];
    
    [self.datetxt resignFirstResponder];
    
    
}
- (IBAction)canceldate:(UIBarButtonItem *)sender
{
    self.datetxt.text=self.duedatestr;
    [self.datetxt resignFirstResponder];
}

- (IBAction)savechanges:(UIButton *)sender {
    
    
    if (nametxt.text.length >0 && self.eventtxt.text.length >0 &&self.datetxt.text.length>0 && self.categorytxt.text.length>0&& self.vendortxt.text.length>0 && self.statustxt.text.length>0 &&informationtxt.text.length>0)
    {
        
        [self EditDetails];
        
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
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
-(void)alreadyinrecord
{
    nametxt.text=self.tasknamestr;
    self.datetxt.text=self.duedatestr;
    self.categorytxt.text=self.categorystr;
    self.eventtxt.text=self.eventnamestr;
    self.statustxt.text=self.statusstr;
    self.vendortxt.text=self.vendorstr;
    informationtxt.text=self.infotxtstr;
}
-(void)EditDetails
{
    NSString *AddtaskData=[[NSString alloc]initWithFormat:@"task_id=%@&task_name=%@&event_id=%@&vendor_id=%@&due_date=%@&category=%@&status=%@&info=%@&apikey=micronix_10_2014_wedsimple_proj",self.taskidstr,nametxt.text,self.Eventid,self.Vendorid,self.datetxt.text,self.categorytxt.text,self.statustxt.text,informationtxt.text];
    NSString* urlTextEscaped = [AddtaskData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",EditTaskURL,urlTextEscaped]];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",url);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    EditData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    EditTaskmessage= [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    
    
    if([[EditTaskmessage valueForKey:@"status" ] isEqualToString:@"Record Updated"])
    {
        UIAlertView *editsuccess=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Edited Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [editsuccess show];
        TodolistViewController *ToDolistVc=[[TodolistViewController alloc] init];
        [self.navigationController pushViewController:ToDolistVc animated:YES];
        
    }
    else
    {
        UIAlertView *editfailed=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Task not edited, Try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [editfailed show];
    }
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [savebtn setBackgroundImage:[UIImage imageNamed:@"save-chenages_iphone.png"] forState:UIControlStateNormal];
        
        
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
            [savebtn setBackgroundImage:[UIImage imageNamed:@"save-changes.png"] forState:UIControlStateNormal];
            
        }
        
    }
}


@end
