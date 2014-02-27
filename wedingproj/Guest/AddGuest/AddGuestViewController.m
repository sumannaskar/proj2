//
//  AddGuestViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AddGuestViewController.h"

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
    nametxt.delegate=self;
    informationtxt.delegate=self;
    self.RoleText.delegate=self;
    self.EmailText.delegate=self;
    self.GroupText.delegate=self;
    self.completedText.delegate=self;
     self.WithText.delegate=self;
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    
    [self.GroupText setInputView:self.respondingView];
    [self.completedText setInputView:self.respondingView];
    [self.WithText setInputView:self.respondingView];
    
    self.GroupText.tag=1;
    self.completedText.tag=2;
    self.WithText.tag=3;
    
    scroll.contentSize=CGSizeMake(320, 500);
    
    GroupArray=[[NSArray alloc]initWithObjects:@"Group1",@"Group2",@"Group3",@"Group4",@"Group5",@"Group6", nil];
    
    CompletedArray=[[NSArray alloc]initWithObjects:@"YES",@"NO", nil];
    
    WithArray=[[NSArray alloc]initWithObjects:@"With 1 Person",@"With 2 Persons",@"With 3 Persons",@"With 4 Persons",@"With 5 Persons",@"With 6 Persons",@"With 7 Persons",@"With 8 Persons",@"With 9 Persons",@"With 10 Persons", nil];

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
    if (self.pickerVw.tag==2) {
        //rowCount=[eventarray count];
        return [CompletedArray count];
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
    else if (self.pickerVw.tag==2)
    {
        return [CompletedArray objectAtIndex:row];
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
    
    if (self.pickerVw.tag==2) {
        self.completedText.text=[CompletedArray objectAtIndex:row];
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
    
    if (self.donebtn.tag==2) {
        if (!(self.completedText.text.length>0)) {
            
            self.completedText.text=[CompletedArray objectAtIndex:0];
            
        }
        
        [self.completedText resignFirstResponder];
        
    }
    if (self.donebtn.tag==3) {
        if (!(self.completedText.text.length>0)) {
            
            self.WithText.text=[WithArray objectAtIndex:0];
            
        }
        
        [self.WithText resignFirstResponder];
        
    }
    
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    
    if (self.cancelbtn.tag==1) {
        
        self.GroupText.text=@"";
        [self.GroupText resignFirstResponder];
        
    }
    
    if (self.cancelbtn.tag==2) {
        
        self.completedText.text=@"";
        [self.completedText resignFirstResponder];
        
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

@end
