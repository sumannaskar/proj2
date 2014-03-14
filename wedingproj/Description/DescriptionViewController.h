//
//  DescriptionViewController.h
//  wedingproj
//
//  Created by Micronix on 04/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController

{
    
    IBOutlet UITextView *descriptxtview;
    
    IBOutlet UIImageView *backgroundimgV;
    
}

@property(nonatomic,retain) NSString *descriptiontxt;

@end
