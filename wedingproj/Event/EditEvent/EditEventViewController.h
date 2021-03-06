//
//  EditEventViewController.h
//  WedingProj
//
//  Created by Micronix on 26/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditEventViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSArray *pkarray;
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextField *venuetxt;
    IBOutlet UITextField *nametxt;
    
    IBOutlet UITextField *budgettxt;
    
    NSString *EditData;
    NSMutableArray *EditEventmessage;
    IBOutlet UIButton *savebtn;
    
    IBOutlet UIImageView *backgroundimgV;
}
@property (strong, nonatomic) NSString *eventidstr;
@property (strong, nonatomic) NSString *eventnamestr;
@property (strong, nonatomic) NSString *startstr;
@property (strong, nonatomic) NSString *endstr;
@property (strong, nonatomic) NSString *dresscodestr;
@property (strong, nonatomic) NSString *venuestr;
@property (strong, nonatomic) NSString *budgetstr;


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
- (IBAction)savechanges:(UIButton *)sender;


@end
