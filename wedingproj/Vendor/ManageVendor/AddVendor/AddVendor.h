//
//  AddVendor.h
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVendor : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UILabel *vendorname;
    IBOutlet UITextField *vendornametext;
    
    IBOutlet UILabel *category;
    IBOutlet UITextField *categorytext;
    
    IBOutlet UILabel *email;
    IBOutlet UITextField *emailtext;
    
    IBOutlet UILabel *contactno;
    IBOutlet UITextField *contactnotext;
    
    IBOutlet UIButton *save;
    NSMutableArray *responce;
    
    NSMutableArray *totalcategorylist;
}


- (IBAction)save:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *respondingView;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerVw;


@end
