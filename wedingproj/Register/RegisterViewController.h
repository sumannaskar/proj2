//
//  RegisterViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    
    IBOutlet UITextField *bridenametxt;
    IBOutlet UITextField *passwrdtxt;
    IBOutlet UITextField *groomnametxt;
    
    IBOutlet UITextField *emailtxt;
    IBOutlet UITextField *confirmpwdtxt;
    
    IBOutlet UIScrollView *scroll;
    
    NSString *AddUserDataStr;
    NSMutableArray *AddUsermessage;
    
    NSMutableArray *totalCountrylist;
    NSMutableArray *totalCountryIdlist;
    
    NSString *countrycode;
    
}
@property (strong, nonatomic) IBOutlet UITextField *countrytxt;
@property (strong, nonatomic) IBOutlet UITextField *datetxt;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *donedatebtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *canceldatebtn;

@property (retain, nonatomic) IBOutlet UIView *respondingView;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;

@property (retain, nonatomic) IBOutlet UIView *datepickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datepickerVW;

- (IBAction)donedate:(UIBarButtonItem *)sender;
- (IBAction)canceldate:(UIBarButtonItem *)sender;


- (IBAction)registeractn:(UIButton *)sender;

@end
