//
//  Cell.m
//  customcell
//
//  Created by Micronixtraining on 7/26/13.
//  Copyright (c) 2013 Micronixtraining. All rights reserved.
//

#import "Cell.h"

@implementation Cell
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
