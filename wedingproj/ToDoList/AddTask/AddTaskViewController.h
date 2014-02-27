//
//  AddTaskViewController.h
//  WedingProj
//
//  Created by Micronix on 24/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    NSArray *pkarray;
    NSArray *eventarray;
    NSArray *vendorarray;
    NSArray *statusarray;

    

    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextView *informationtxt;
    IBOutlet UITextField *nametxt;
    NSString *AddData;
    NSMutableArray *AddTaskmessage;
   
}


@property (retain, nonatomic) IBOutlet UIView *respondingView;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebtn;

@property (strong, nonatomic) IBOutlet UITextField *datetxt;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelbtn;

@property (strong, nonatomic) IBOutlet UITextField *categorytxt;
@property (strong, nonatomic) IBOutlet UITextField *eventtxt;
@property (strong, nonatomic) IBOutlet UITextField *vendortxt;
@property (strong, nonatomic) IBOutlet UITextField *statustxt;

@property (retain, nonatomic) IBOutlet UIView *datepickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datepickerVW;

- (IBAction)donedate:(id)sender;
- (IBAction)canceldate:(UIBarButtonItem *)sender;

- (IBAction)AddTaskactn:(UIButton *)sender;


@end
