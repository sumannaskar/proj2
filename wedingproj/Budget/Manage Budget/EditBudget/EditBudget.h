//
//  EditBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBudget : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UIImageView *background;
    IBOutlet UILabel *eventname;
    IBOutlet UITextField *eventnametext;
    IBOutlet UILabel *paymentduedate;
    IBOutlet UITextField *paymentduedatetext;
    IBOutlet UILabel *totalamountdue;
    IBOutlet UITextField *totalamountduetext;
    IBOutlet UILabel *amountpaidtodate;
    IBOutlet UITextField *amountpaidtodatetext;
    IBOutlet UILabel *info;
    IBOutlet UITextView *infotext;
    IBOutlet UIButton *save;
    IBOutlet UIView *respondingView;
    IBOutlet UIPickerView *pickerVw;
    IBOutlet UIView *datepickerView;
    IBOutlet UIDatePicker *datepickerVW;
    IBOutlet UILabel *vendername;
    IBOutlet UITextField *vendernametext;
    NSArray *pkarray;//delete after use
    IBOutlet UIToolbar *picekrtoolbr;
    

    
}
- (IBAction)save:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)donedate:(id)sender;
- (IBAction)canceldate:(UIBarButtonItem *)sender;


@end
