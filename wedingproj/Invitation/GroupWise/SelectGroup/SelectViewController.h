//
//  SelectViewController.h
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController<UITextFieldDelegate>
{
    NSDictionary *jsondata;
    NSMutableArray *json;
    NSMutableArray *eventName;
    NSMutableArray *eventId;
    NSMutableArray *eventDesc;
    NSString *selectEventId;
     NSString *selectGroupId;
}
- (IBAction)SelectGroup:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *SelectGroup;

@property (strong, nonatomic) IBOutlet UITextField *SelectEvent;
@property (strong, nonatomic) IBOutlet UITextView *EventDescription;
@property (strong, nonatomic) IBOutlet UIButton *Proced;
@property (strong, nonatomic) IBOutlet UIView *respondView;
@property (strong, nonatomic) IBOutlet UIPickerView *PickerView;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
- (IBAction)DoneAction:(UIBarButtonItem *)sender;


@property (strong, nonatomic) NSMutableArray *GId;
@property (strong, nonatomic) NSMutableArray *Gname;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *done;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancel;



@end
