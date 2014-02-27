//
//  AddBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBudget : UIViewController
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
    NSMutableArray *json;
    NSMutableArray *vendorname;
    NSMutableArray *vendorid;
    NSString *vendoridpass;
    
}

- (IBAction)save:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)donedate:(id)sender;
- (IBAction)canceldate:(UIBarButtonItem *)sender;

@end
