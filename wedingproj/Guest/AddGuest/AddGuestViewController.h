//
//  AddGuestViewController.h
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGuestViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    NSArray *GroupArray;
    NSArray *CompletedArray;
    NSArray *WithArray;
    
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextView *informationtxt;
    IBOutlet UITextField *nametxt;
}

@property (retain, nonatomic) IBOutlet UIView *respondingView;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelbtn;


@property (strong, nonatomic) IBOutlet UITextField *RoleText;
@property (strong, nonatomic) IBOutlet UITextField *EmailText;
@property (strong, nonatomic) IBOutlet UITextField *GroupText;
@property (strong, nonatomic) IBOutlet UITextField *WithText;
@property (strong, nonatomic) IBOutlet UITextField *completedText;

@end
