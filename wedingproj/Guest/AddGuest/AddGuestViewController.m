//
//  AddGuestViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AddGuestViewController.h"
#import "GuestViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_create&"]

#define GroupURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=groups&"]
@interface AddGuestViewController ()

@end

@implementation AddGuestViewController

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
    self.RoleText.delegate=self;
    self.EmailText.delegate=self;
    self.GroupText.delegate=self;
     self.WithText.delegate=self;
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    
    [self.GroupText setInputView:self.respondingView];
    [self.WithText setInputView:self.respondingView];
    
    self.GroupText.tag=1;
    self.WithText.tag=3;
    
    scroll.contentSize=CGSizeMake(320, 500);
    
    jsondata = [[NSDictionary alloc]init];
      json = [[NSMutableArray alloc]init];
    GroupArray = [[NSMutableArray alloc]init];
    GroupIdArray = [[NSMutableArray alloc]init];
    AddArray = [[NSMutableArray alloc]init];
    
   // CompletedArray=[[NSArray alloc]initWithObjects:@"YES",@"NO", nil];
    
    WithArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    NSString *str =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GroupURL,str]];
    //NSLog(@"my--%@",url);
    
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
    jsondata = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    
    // [HUD hideUIBlockingIndicator];
    json = [jsondata valueForKey:@"data"];
    for(int i=0;i<json.count;i++) {
        
        [GroupArray addObject:[[json objectAtIndex:i ] valueForKey:@"group_name"]];
        
    }
    for(int i=0;i<json.count;i++) {
        
        [GroupIdArray addObject:[[json objectAtIndex:i ] valueForKey:@"group_id"]];
        
    }

    [self.pickerVw reloadAllComponents];
     //NSLog(@"%@",GroupArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        
        self.pickerVw.tag=1;
        self.donebtn.tag=1;
        self.cancelbtn.tag=1;
        [self.pickerVw reloadAllComponents];
        
    }
    if (textField.tag==3) {
        self.pickerVw.tag=3;
        self.donebtn.tag=3;
        self.cancelbtn.tag=3;
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
        //rowCount=[pkarray count];
        return [GroupArray count];
    }
    if (self.pickerVw.tag==3) {
        //rowCount=[eventarray count];
        return [WithArray count];
    }

    return 0;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    
    
    if (self.pickerVw.tag==1) {
        return [GroupArray objectAtIndex:row];
    }
    else {
        return [WithArray objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.pickerVw.tag==1) {
        self.GroupText.text=[GroupArray objectAtIndex:row];
        self.groupIdstring=[GroupIdArray objectAtIndex:row];
    }
    if (self.pickerVw.tag==3) {
        self.WithText.text=[WithArray objectAtIndex:row];
    }
    
}

- (IBAction)done:(id)sender
{
    
    if (self.donebtn.tag==1) {
        if (!(self.GroupText.text.length>0)) {
            
            self.GroupText.text=[GroupArray objectAtIndex:0];
            self.groupIdstring=[GroupIdArray objectAtIndex:0];
            
        }
        
        [self.GroupText resignFirstResponder];
        
    }
    
    if (self.donebtn.tag==3) {
        if (!(self.WithText.text.length>0)) {
            
            self.WithText.text=[WithArray objectAtIndex:0];
            
        }
        
        [self.WithText resignFirstResponder];


    }
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    
    if (self.cancelbtn.tag==1) {
        
        self.GroupText.text=@"";
        self.groupIdstring=@"";
        [self.GroupText resignFirstResponder];
        
    }
    
    
    if (self.cancelbtn.tag==3) {
        
        self.WithText.text=@"";
        [self.WithText resignFirstResponder];
        
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

- (IBAction)AddGuest:(UIButton *)sender {
    NSString *SignUpdatra =[[NSString alloc]initWithFormat:@"user_id=%@&name=%@&role=%@&email=%@&group_id=%@&no_of_guest=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],nametxt.text,self.RoleText.text,self.EmailText.text,self.groupIdstring,self.WithText.text];
    
    NSString* urlTextEscaped = [SignUpdatra stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,urlTextEscaped]];
    //  NSLog(@"%@",url);
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
    GuestViewController *GuestVC =[[GuestViewController alloc]init];
    [self.navigationController pushViewController:GuestVC animated:YES];

}

-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    AddArray = [NSJSONSerialization
                   JSONObjectWithData:responseData //1
                   
                   options:kNilOptions
                   error:&error];
    // NSLog(@"%@",UpdateArray);
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
       [self.Add setBackgroundImage:[UIImage imageNamed:@"add-guest_iphone.png"] forState:UIControlStateNormal];
        
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
            [self.Add setBackgroundImage:[UIImage imageNamed:@"add-guest.png"] forState:UIControlStateNormal];
            
        }
        
    }
}

@end
