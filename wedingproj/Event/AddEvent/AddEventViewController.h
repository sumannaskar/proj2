//
//  AddEventViewController.h
//  WedingProj
//
//  Created by Micronix on 24/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSArray *pkarray;
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextField *venuetxt;
    IBOutlet UITextField *nametxt;
    
    NSString *AddData;
    NSMutableArray *AddEventmessage;
    
    IBOutlet UIImageView *backgroundimgV;
    
    IBOutlet UIButton *addeventbtn;
    
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


- (IBAction)AddEventactn:(UIButton *)sender;

@end
