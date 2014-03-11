//
//  EditBudgetViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/7/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBudgetViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextField *NameText;
    
    IBOutlet UITextField *AmntText;
    
    IBOutlet UITextView *DescTextView;
    NSDictionary *json;
    
    
}
@property (strong, nonatomic) IBOutlet UIImageView *BackImgv;
@property (strong, nonatomic) IBOutlet UIButton *SaveBtn;
- (IBAction)SaveAction:(UIButton *)sender;

@property (strong, nonatomic) NSString *CatId;
@property (strong, nonatomic) NSString *CatName;
@property (strong, nonatomic) NSString *CatBudget;
@property (strong, nonatomic) NSString *CatDesc;
@property (strong, nonatomic) NSString *EventIdStr;

@end
