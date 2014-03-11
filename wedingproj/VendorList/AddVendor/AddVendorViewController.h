//
//  AddVendorViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVendorViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIImageView *BackImgv;
    
    IBOutlet UIScrollView *Scroll;
    
IBOutlet UILabel *vendorname;
IBOutlet UITextField *vendornametext;

IBOutlet UILabel *category;
IBOutlet UITextField *categorytext;

IBOutlet UILabel *email;
IBOutlet UITextField *emailtext;

IBOutlet UILabel *contactno;
IBOutlet UITextField *contactnotext;

IBOutlet UIButton *save;
    
    
    NSDictionary *json;
    NSMutableArray *Jsondata;
    
    NSDictionary *addjson;
}
- (IBAction)save:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *respondingView;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)done:(UIBarButtonItem *)sender;


@end
