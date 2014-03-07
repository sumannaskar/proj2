//
//  AddBudgetViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/7/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBudgetViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextField *NameText;
    
    IBOutlet UITextField *AmntText;
    
    IBOutlet UITextView *DescTextView;
    NSDictionary *json;
}
@property (strong, nonatomic) IBOutlet UIImageView *BackImgv;
@property (strong, nonatomic) IBOutlet UIButton *SaveBtn;
- (IBAction)AddAction:(UIButton *)sender;
@property (strong, nonatomic) NSString *eventidstr;
@end
