//
//  SelectEventViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/1/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectEventViewController : UIViewController
{
    NSDictionary *jsondata;
    NSMutableArray *json;
    NSMutableArray *eventName;
    NSMutableArray *eventId;
     NSMutableArray *eventDesc;
    NSString *selectEventId;
}
@property (strong, nonatomic) IBOutlet UITextField *SelectEvent;
@property (strong, nonatomic) IBOutlet UITextView *EventDescription;
@property (strong, nonatomic) IBOutlet UIButton *Proced;
- (IBAction)ProcedAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *respondView;
@property (strong, nonatomic) IBOutlet UIPickerView *PickerView;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)DoneAction:(UIBarButtonItem *)sender;

@end
