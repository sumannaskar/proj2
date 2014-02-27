//
//  Cell.h
//  customcell
//
//  Created by Micronixtraining on 7/26/13.
//  Copyright (c) 2013 Micronixtraining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *checkImgv;
@property (strong, nonatomic) IBOutlet UILabel *guestLbl;
@property (strong, nonatomic) IBOutlet UIButton *statusBtn;

@end
