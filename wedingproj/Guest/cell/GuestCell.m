//
//  GuestCell.m
//  wedingproj
//
//  Created by Micronixtraining on 2/27/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "GuestCell.h"

@implementation GuestCell
@synthesize guestLbl,checkImgv,statusBtn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
