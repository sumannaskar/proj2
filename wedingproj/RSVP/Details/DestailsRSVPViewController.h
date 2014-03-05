//
//  DestailsRSVPViewController.h
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestailsRSVPViewController : UIViewController
{
    NSDictionary *json;
    NSMutableArray *jsondata;
    
    NSMutableArray *guestId;
     NSMutableArray *guestName;
     NSMutableArray *guestResponse;
    
}
@property (strong, nonatomic) IBOutlet UITableView *rsvpTable;
@property (strong, nonatomic) IBOutlet UIImageView *backImgv;
@property (strong, nonatomic) NSString *eventId;

@end
