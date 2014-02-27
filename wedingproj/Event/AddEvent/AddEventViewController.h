//
//  AddEventViewController.h
//  WedingProj
//
//  Created by Micronix on 24/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSArray *pkarray;
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextField *venuetxt;
    IBOutlet UITextField *nametxt;
    
    IBOutlet UITextField *budgettxt;
    
}

@property (strong, nonatomic) IBOutlet UITextField *dresscodetxt;

@property (strong, nonatomic) IBOutlet UITextField *datetxt;

@property (strong, nonatomic) IBOutlet UITextField *dateendtxt;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *donedatebtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *canceldatebtn;

@property (retain, nonatomic) IBOutlet UIView *respondingView;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;

@property (retain, nonatomic) IBOutlet UIView *datepickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datepickerVW;

- (IBAction)donedate:(id)sender;
- (IBAction)canceldate:(UIBarButtonItem *)sender;

@end
