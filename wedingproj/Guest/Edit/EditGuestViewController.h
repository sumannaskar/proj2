//
//  EditGuestViewController.h
//  WedingProj
//
//  Created by Micronixtraining on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGuestViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    
    NSArray *CompletedArray;
    NSArray *WithArray;
    NSDictionary *jsondata;
    NSMutableArray *json;
     NSMutableArray *GroupArray;
    NSMutableArray *GroupIdArray;
    
    IBOutlet UIScrollView *scroll;
    
    
    IBOutlet UITextField *nametxt;
    
    NSMutableArray *UpdateArray;
     NSString *savedata;
    
    IBOutlet UIImageView *backgroundimgV;
    
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

@property (strong, nonatomic) NSString *GidString;
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *roleString;
@property (strong, nonatomic) NSString *emailString;
@property (strong, nonatomic) NSString *groupString;
//@property (strong, nonatomic) NSString *groupIdString;
@property (strong, nonatomic) NSString *withString;

@property (strong, nonatomic) NSString *GroupIdString;


@property (strong, nonatomic) IBOutlet UIButton *save;

- (IBAction)SaveAction:(UIButton *)sender;


@end
