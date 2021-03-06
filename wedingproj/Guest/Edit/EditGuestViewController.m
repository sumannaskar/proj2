//
//  EditGuestViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditGuestViewController.h"
#import "GuestViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GroupURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=groups&"]
#define SaveURL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=guest_update&"]
@interface EditGuestViewController ()

@end

@implementation EditGuestViewController

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
    NSLog(@"%@",self.GidString);
    // Do any additional setup after loading the view from its nib.
    jsondata = [[NSDictionary alloc]init];
    json = [[NSMutableArray alloc]init];
    GroupArray = [[NSMutableArray alloc]init];
     GroupIdArray = [[NSMutableArray alloc]init];
    
    
     nametxt.text = self.nameString;
     self.RoleText.text = self.roleString;
     self.EmailText.text = self.emailString;
     self.GroupText.text = self.groupString;
     self.WithText.text = self.withString;
    
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
    
   // GroupArray=[[NSArray alloc]initWithObjects:@"Group1",@"Group2",@"Group3",@"Group4",@"Group5",@"Group6", nil];
    
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
             [self performSelectorOnMainThread:@selector(fetchedData:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );
    
    
}
-(void)fetchedData:(NSData *)responseData
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
    // NSLog(@"%@",GroupArray);
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
    
    
    // return [location objectAtIndex:row];
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
         self.GroupIdString=[GroupIdArray objectAtIndex:row];
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
            self.GroupIdString=[GroupIdArray objectAtIndex:0];
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
        
        self.GroupText.text=self.groupString;
        
        for (int i=0; i<GroupArray.count; i++) {
            if ([[GroupArray objectAtIndex:i]isEqualToString:self.groupString]) {
                self.GroupIdString = [GroupIdArray objectAtIndex:i];
                break;
            }
        }
        [self.GroupText resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==3) {
        
        self.WithText.text=self.withString;
        
        [self.WithText resignFirstResponder];
        
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)SaveAction:(UIButton *)sender {
     UpdateArray = [[NSMutableArray alloc]init];
//     NSString *SignUpdatra =[[NSString alloc]initWithFormat:@"guest_id=%@&name=%@&role=%@&email=%@&group_id=%@&no_of_guest=%@&apikey=micronix_10_2014_wedsimple_proj",self.GidString,nametxt.text,self.RoleText.text,self.EmailText.text,self.GroupText.text,self.WithText.text];
    
    NSString *SignUpdatra =[[NSString alloc]initWithFormat:@"guest_id=%@&name=%@&role=%@&email=%@&group_id=%@&no_of_guest=%@&apikey=micronix_10_2014_wedsimple_proj",self.GidString,nametxt.text,self.RoleText.text,self.EmailText.text,self.GroupIdString,self.WithText.text];
    
    NSString* urlTextEscaped = [SignUpdatra stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  //  NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SaveURL,urlTextEscaped]];
   // NSLog(@"%@",url);
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
    UpdateArray = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
   // NSLog(@"%@",UpdateArray);
    if ([[UpdateArray valueForKey:@"status"]isEqualToString:@"Record Updated"]) {
        UIAlertView *nodata=[[UIAlertView alloc]initWithTitle:@"Wedding App" message:[UpdateArray valueForKey:@"status"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [nodata show];
    }
    GuestViewController *GuestVC =[[GuestViewController alloc]init];
    [self.navigationController pushViewController:GuestVC animated:YES];
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [self.save setBackgroundImage:[UIImage imageNamed:@"save-chenages_iphone.png"] forState:UIControlStateNormal];
        
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
            [self.save setBackgroundImage:[UIImage imageNamed:@"save-changes.png"] forState:UIControlStateNormal];
            
        }
        
    }
}

@end
