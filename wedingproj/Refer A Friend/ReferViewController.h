//
//  ReferViewController.h
//  wedingproj
//
//  Created by Micronix on 04/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextView *commntstxtV;
    NSDictionary *json;
    NSString *check;
}

@property (retain, nonatomic) IBOutlet UITextField *nametxt;

//@property (retain, nonatomic) IBOutlet UITextField *addresstxt;

@property (retain, nonatomic) IBOutlet UITextField *emailtxt;

//@property (retain, nonatomic) IBOutlet UITextField *contacttxt;

@property (retain, nonatomic) IBOutlet UIImageView *backgoundImgview;

@property (retain, nonatomic) IBOutlet UIButton *referencebtn;
@property(nonatomic,retain)NSString *userId;

- (IBAction)referencehit:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property(nonatomic,retain)NSString *refStatus;

@end
