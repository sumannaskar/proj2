//
//  EditBudgetViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/7/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBudgetViewController : UIViewController
{
    IBOutlet UITextField *NameText;
    
    IBOutlet UITextField *AmntText;
    
    IBOutlet UITextView *DescTextView;
}
@property (strong, nonatomic) IBOutlet UIImageView *BackImgv;
@property (strong, nonatomic) IBOutlet UIButton *SaveBtn;
- (IBAction)SaveAction:(UIButton *)sender;


@end
