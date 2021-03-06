//
//  EditTaskViewController.h
//  WedingProj
//
//  Created by Micronix on 26/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    NSArray *pkarray;
    NSArray *eventarray;
    NSArray *vendorarray;
    NSArray *statusarray;
    
    
    
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextView *informationtxt;
    IBOutlet UITextField *nametxt;
    
    NSString *EditData;
    NSMutableArray *EditTaskmessage;
    
    NSMutableArray *totaleventlist;
    NSMutableArray *totaleventIdlist;
       
    NSMutableArray *totalvendorlist;
    NSMutableArray *totalvendorIdlist;
    
    NSString *categoryName;
    
    
    NSMutableArray *totalcategorylist;
    
    IBOutlet UIImageView *backgroundimgV;
    
    IBOutlet UIButton *savebtn;
    
}
@property (strong, nonatomic) NSString *taskidstr;
@property (strong, nonatomic) NSString *tasknamestr;
@property (strong, nonatomic) NSString *duedatestr;
@property (strong, nonatomic) NSString *categorystr;
@property (strong, nonatomic) NSString *eventnamestr;
@property (strong, nonatomic) NSString *vendorstr;
@property (strong, nonatomic) NSString *statusstr;
@property (strong, nonatomic) NSString *infotxtstr;
@property (strong, nonatomic) NSString *Eventid;
@property (strong, nonatomic) NSString *Vendorid;





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

- (IBAction)savechanges:(UIButton *)sender;

@end
