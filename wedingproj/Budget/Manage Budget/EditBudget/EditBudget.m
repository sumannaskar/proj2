//
//  EditBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "EditBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_single&"]

@interface EditBudget ()

@end

@implementation EditBudget

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
    [paymentduedatetext setInputView:datepickerView];
    [vendernametext setInputView:respondingView];
    pkarray=[[NSArray alloc]initWithObjects:@"A",@"B", nil];
    [datepickerVW setDate:[NSDate date]];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy hh:mm a"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

#pragma -pickerview delecates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  
         return [pkarray count];
  
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
      return [pkarray objectAtIndex:row];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    vendernametext.text=[pkarray objectAtIndex:row];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
}

- (IBAction)done:(id)sender
{
    if (!(vendernametext.text.length>0)) {
        
    vendernametext.text=[pkarray objectAtIndex:0];
    }
    [vendernametext resignFirstResponder];
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    vendernametext.text=@"";
    [vendernametext resignFirstResponder];
}
- (IBAction)donedate:(id)sender
{
    paymentduedatetext.text=[self formatDate:datepickerVW.date];
    [paymentduedatetext resignFirstResponder];
}
- (IBAction)canceldate:(UIBarButtonItem *)sender
{
    paymentduedatetext.text=@"";
    [paymentduedatetext resignFirstResponder];
    
}

@end
