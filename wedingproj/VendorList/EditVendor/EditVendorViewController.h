//
//  EditVendorViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditVendorViewController : UIViewController<UITextFieldDelegate>
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
    
    NSDictionary *savejson;
    

}

- (IBAction)save:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *respondingView;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)done:(UIBarButtonItem *)sender;

@property (retain, nonatomic) NSString *Vid;
@property (retain, nonatomic) NSString *Vname;
@property (retain, nonatomic) NSString *Vcat;
@property (retain, nonatomic) NSString *Vemail;
@property (retain, nonatomic) NSString *Vcontact;
@end
