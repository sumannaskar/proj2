//
//  EditTaskViewController.m
//  WedingProj
//
//  Created by Micronix on 26/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditTaskViewController.h"

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
        
        return [pkarray count];
    }
    if (self.pickerVw.tag==2) {
        
        return [eventarray count];
    }
    if (self.pickerVw.tag==3) {
        
        return [vendorarray count];
    }
    if (self.pickerVw.tag ==4) {
        return [statusarray count];
    }
    return 0;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    
    
    if (self.pickerVw.tag==1) {
        return [pkarray objectAtIndex:row];
    }
    
    if (self.pickerVw.tag==2) {
        return [eventarray objectAtIndex:row];
    }
    if (self.pickerVw.tag==3) {
        return [vendorarray objectAtIndex:row];
    }
    
    
    else
    {
        return [statusarray objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (self.pickerVw.tag==1) {
        self.categorytxt.text=[pkarray objectAtIndex:row];
        
    }
    
    
    if (self.pickerVw.tag==2) {
        self.eventtxt.text=[eventarray objectAtIndex:row];
    }
    
    if (self.pickerVw.tag==3) {
        self.vendortxt.text=[vendorarray objectAtIndex:row];
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
        
        [self.categorytxt resignFirstResponder];
        
    }
    
    if (self.donebtn.tag==2) {
        if (!(self.eventtxt.text.length>0)) {
            
            self.eventtxt.text=[eventarray objectAtIndex:0];
            
        }
        
        [self.eventtxt resignFirstResponder];
        
    }
    if (self.donebtn.tag==3) {
        if (!(self.vendortxt.text.length>0)) {
            
            self.vendortxt.text=[vendorarray objectAtIndex:0];
            
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
        
        self.categorytxt.text=@"";
        [self.categorytxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==2) {
        
        self.eventtxt.text=@"";
        [self.eventtxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==3) {
        
        self.vendortxt.text=@"";
        [self.vendortxt resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==1) {
        
        self.statustxt.text=@"";
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

@end
