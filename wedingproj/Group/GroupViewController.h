//
//  GroupViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/6/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UIViewController
{
    IBOutlet UIImageView *BackImgv;
    
    IBOutlet UITableView *GroupTable;
    NSDictionary *jsondata;
    NSMutableArray *json;
    NSMutableArray *Gid;
    NSMutableArray *Gname;
    
    NSString *GroupId;
    NSDictionary *jsonUpdate;
}

@end
