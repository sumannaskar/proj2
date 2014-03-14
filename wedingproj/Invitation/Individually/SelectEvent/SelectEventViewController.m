//
//  SelectEventViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/1/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "SelectEventViewController.h"
#import "SendIndividuallyViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events&"]
@interface SelectEventViewController ()

@end

@implementation SelectEventViewController

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
    jsondata = [[NSDictionary alloc]init];
    json = [[NSMutableArray alloc]init];
     eventId = [[NSMutableArray alloc]init];
     eventName = [[NSMutableArray alloc]init];
     eventDesc = [[NSMutableArray alloc]init];
    
    self.PickerView.showsSelectionIndicator=YES;
    [self.SelectEvent setInputView:self.respondView];
    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,string]];
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
-(void)fetchedData:(NSData *)responseData{
    NSError *error;
    jsondata = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    if ([[jsondata valueForKey:@"availability"]isEqualToString:@"no"]) {
        NSLog(@"Alert..");
    }
    else{
        json = [jsondata valueForKey:@"data"];
        for(int i=0;i<json.count;i++) {
        [eventId addObject:[[json objectAtIndex:i ] valueForKey:@"event_id"]];
    }
    for(int i=0;i<json.count;i++) {
        [eventName addObject:[[json objectAtIndex:i ] valueForKey:@"event_name"]];
    }
    for(int i=0;i<json.count;i++) {
        [eventDesc addObject:[[json objectAtIndex:i ] valueForKey:@"venue"]];
    }
    
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ProcedAction:(UIButton *)sender {
    SendIndividuallyViewController *InvVC =[[SendIndividuallyViewController alloc]init];
    InvVC.eventId = selectEventId;
    [self.navigationController pushViewController:InvVC animated:YES];
}
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    self.SelectEvent.text=@"";
    self.EventDescription.text=@"";
    selectEventId=@"";
    [self.SelectEvent resignFirstResponder];
}

- (IBAction)DoneAction:(UIBarButtonItem *)sender {
    if (!(self.SelectEvent.text.length>0)) {
        //        mytxtfield.text=[stateList objectAtIndex:0];
        //        self.stateName=[stateList objectAtIndex:0];
        
        self.SelectEvent.text=[eventName objectAtIndex:0];
        self.EventDescription.text=[eventDesc objectAtIndex:0];
        selectEventId = [eventId objectAtIndex:0];
    }
    
    [self.SelectEvent resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [eventId count];
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    return [eventName objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.SelectEvent.text=[eventName objectAtIndex:row];
    self.EventDescription.text = [eventDesc objectAtIndex:row];
    selectEventId = [eventId objectAtIndex:row];
}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [self.Proced setBackgroundImage:[UIImage imageNamed:@"proceed_iphone.png"] forState:UIControlStateNormal];
        
        
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
            [self.Proced setBackgroundImage:[UIImage imageNamed:@"proceed.png"] forState:UIControlStateNormal];
            
            
        }
        
    }
}



@end
