//
//  EditVendor.h
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditVendor : UIViewController
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
}


- (IBAction)save:(id)sender;
@property(nonatomic,retain)NSMutableArray *json;
@end
