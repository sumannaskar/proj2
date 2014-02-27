//
//  EditEventViewController.m
//  WedingProj
//
//  Created by Micronix on 26/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditEventViewController.h"

@interface EditEventViewController ()

@end

@implementation EditEventViewController

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
    NSLog(@"%@",self.venuestr);
    nametxt.delegate=self;
    budgettxt.delegate=self;
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
    
    pkarray=[[NSArray alloc]initWithObjects:@"Formal",@"Casual", nil];
    [self alreadyinrecord];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
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
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy hh:mm a"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
-(void)alreadyinrecord
{
    nametxt.text=self.eventnamestr;
    self.datetxt.text=self.startstr;
    self.dateendtxt.text=self.endstr;
    self.dresscodetxt.text=self.dresscodestr;
    venuetxt.text=self.venuestr;
    budgettxt.text=self.budgetstr;
    
    
    
    
}

@end
