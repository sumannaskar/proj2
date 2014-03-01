//
//  SelectViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "SelectViewController.h"
#import "InvitationViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=events&"]
@interface SelectViewController ()

@end

@implementation SelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.GId = [[NSMutableArray alloc]init];
        self.Gname = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // NSLog(@"%@",self.GId);
    
    json = [[NSMutableArray alloc]init];
    eventId = [[NSMutableArray alloc]init];
    eventName = [[NSMutableArray alloc]init];
    eventDesc = [[NSMutableArray alloc]init];
    
    self.PickerView.showsSelectionIndicator=YES;
    [self.SelectGroup setInputView:self.respondView];
    [self.SelectEvent setInputView:self.respondView];
    
    self.SelectGroup.delegate = self;
    self.SelectEvent.delegate = self;

    
    self.SelectGroup.tag=1;
    self.SelectEvent.tag=2;

    
    NSString *string =[[NSString alloc]initWithFormat:@"user_id=%@&apikey=micronix_10_2014_wedsimple_proj",@"11"];
    
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
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    for(NSString *loc in [json valueForKey:@"event_id"]) {
        [eventId addObject:loc];
    }
    for(NSString *loc in [json valueForKey:@"event_name"]) {
        [eventName addObject:loc];
    }
    for(NSString *loc in [json valueForKey:@"venue"]) {
        [eventDesc addObject:loc];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1) {
        
        self.PickerView.tag=1;
        self.done.tag=1;
        self.cancel.tag=1;
        [self.PickerView reloadAllComponents];
        
    }
    if (textField.tag==2) {
        self.PickerView.tag=2;
        self.done.tag=2;
        self.cancel.tag=2;
        [self.PickerView reloadAllComponents];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectGroup:(id)sender {
    InvitationViewController *InvVC =[[InvitationViewController alloc]init];
    InvVC.self.GroupId=selectGroupId;
    InvVC.self.EventId=selectEventId;
    [self.navigationController pushViewController:InvVC animated:YES];
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    
    
    if (self.cancel.tag==1) {
        
        self.SelectGroup.text=@"";
        selectGroupId=@"";
        [self.SelectGroup resignFirstResponder];
        
    }
    
    
    if (self.cancel.tag==2) {
        
        self.SelectEvent.text=@"";
        self.EventDescription.text=@"";
        selectEventId=@"";
        [self.SelectEvent resignFirstResponder];
        
    }

    
}

- (IBAction)DoneAction:(UIBarButtonItem *)sender {
    
    
    if (self.done.tag==1) {
        if (!(self.SelectGroup.text.length>0)) {
            
            self.SelectGroup.text=[self.Gname objectAtIndex:0];
            selectGroupId = [self.GId objectAtIndex:0];
            
        }
        
        [self.SelectGroup resignFirstResponder];
        
    }
    
    if (self.done.tag==2) {
        if (!(self.SelectEvent.text.length>0)) {
            
            self.SelectEvent.text=[eventName objectAtIndex:0];
            self.EventDescription.text=[eventDesc objectAtIndex:0];
            selectEventId = [eventId objectAtIndex:0];
            
        }
        
        [self.SelectEvent resignFirstResponder];
        
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.PickerView.tag==1) {
        //rowCount=[pkarray count];
        return [self.GId count];
    }
     else {
        //rowCount=[eventarray count];
        return [eventId count];
    }
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (self.PickerView.tag==1) {
        return [self.Gname objectAtIndex:row];
    }
    else {
        return [eventName objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.PickerView.tag==1) {
        self.SelectGroup.text=[self.Gname objectAtIndex:row];
         selectGroupId = [self.GId objectAtIndex:row];
    }
    if (self.PickerView.tag==2) {
        self.SelectEvent.text=[eventName objectAtIndex:row];
        self.EventDescription.text = [eventDesc objectAtIndex:row];
        selectEventId = [eventId objectAtIndex:row];
    }

}

@end
