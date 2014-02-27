//
//  EditGuestViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditGuestViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=groups&apikey=micronix_10_2014_wedsimple_proj"]
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
    // Do any additional setup after loading the view from its nib.
    json = [[NSMutableArray alloc]init];
    GroupArray = [[NSMutableArray alloc]init];
    
     nametxt.text = self.nameString;
     self.RoleText.text = self.roleString;
     self.EmailText.text = self.emailString;
    // self.GroupText.text = self.groupString;
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
    
     WithArray=[[NSArray alloc]initWithObjects:@"With 1 Person",@"With 2 Persons",@"With 3 Persons",@"With 4 Persons",@"With 5 Persons",@"With 6 Persons",@"With 7 Persons",@"With 8 Persons",@"With 9 Persons",@"With 10 Persons", nil];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URL]];
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
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    
    // [HUD hideUIBlockingIndicator];
    for(NSString *loc in [json valueForKey:@"group_name"]) {
        
        [GroupArray addObject:loc];
        
    }
    
    for(NSString *loc in [json valueForKey:@"id"]) {
        int i=0;
        if ([loc isEqualToString:self.groupString]) {
            self.GroupText.text = [GroupArray objectAtIndex:i];
            break;
        }
        i = i+1;
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

@end
