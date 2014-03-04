//
//  InvViewController.h
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvViewController : UIViewController
{
    IBOutlet UIButton *individually;
    
    IBOutlet UIButton *Groupwise;
    
    NSDictionary *jsondata;
    NSMutableArray *json;
    NSMutableArray *Gid;
    NSMutableArray *Gname;
}
- (IBAction)IndividuallySend:(UIButton *)sender;
- (IBAction)GroupwiseSend:(UIButton *)sender;


@end
