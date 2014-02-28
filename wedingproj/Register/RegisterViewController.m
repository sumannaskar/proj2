//
//  RegisterViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "RegisterViewController.h"

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
    // Do any additional setup after loading the view from its nib.
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
    return 0;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    // return [location objectAtIndex:row];
   // return [pkarray objectAtIndex:row];
    return 0;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
   // self.dresscodetxt.text=[pkarray objectAtIndex:row];
    
    
}


- (IBAction)done:(id)sender
{
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    
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

@end
