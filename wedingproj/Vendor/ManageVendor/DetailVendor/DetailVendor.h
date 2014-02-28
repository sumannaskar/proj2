//
//  DetailVendor.h
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVendor : UIViewController
{
    IBOutlet UILabel *vendorname;
    IBOutlet UILabel *vendornametext;
    
    IBOutlet UILabel *category;
    IBOutlet UILabel *categorytext;
    
    IBOutlet UILabel *email;
    IBOutlet UILabel *emailtext;
    
    IBOutlet UILabel *contactno;
    IBOutlet UILabel *contactnotext;
    
    IBOutlet UIButton *edit;
    IBOutlet UIButton *done;
    
    
    
    
    
}
- (IBAction)edit:(id)sender;
- (IBAction)done:(id)sender;
@property(nonatomic,retain)NSString *vendoridpass;
@property(nonatomic,retain)NSMutableArray *json;

@end
