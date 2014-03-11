//
//  NPInsViewController.h
//  NewProjectThought
//
//  Created by Micronixtraining on 10/10/13.
//  Copyright (c) 2013 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPInsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *Insbgimgv;
@property (retain, nonatomic) IBOutlet UIImageView *InslightbgImgv;

@property (retain, nonatomic) IBOutlet UITextView *instxtV;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *exitButton;
-(IBAction)exitfromApp:(UIBarButtonItem *)sender;
@end
