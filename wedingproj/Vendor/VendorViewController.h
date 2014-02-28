//
//  VendorViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorViewController : UIViewController


{
    
    IBOutlet UIButton *addvendor;
    IBOutlet UIButton *managevendor;
}
- (IBAction)managevendor:(id)sender;
- (IBAction)addvendor:(id)sender;

@end
