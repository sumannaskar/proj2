//
//  AddBudgetViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/7/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "AddBudgetViewController.h"
#import "EventViewController.h"
#define UpdateCat [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_create&"]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface AddBudgetViewController ()

@end

@implementation AddBudgetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     scroll.contentSize=CGSizeMake(320, 550);
    NameText.delegate = self;
    AmntText.delegate = self;
    DescTextView.delegate = self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddAction:(UIButton *)sender {
    json = [[NSDictionary alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"event_id=%@&category_name=%@&estimate_budget=%@&description=%@&apikey=micronix_10_2014_wedsimple_proj",self.eventidstr,NameText.text,AmntText.text,DescTextView.text];
    NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UpdateCat,urlTextEscaped]];
    //NSLog(@"my--%@",url);
    
    // [HUD showUIBlockingIndicatorWithText:@"Loading.."];
    dispatch_async
    (kBgQueue, ^
     {
         NSData* data = [NSData dataWithContentsOfURL:
                         url];
         NSString *tempstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         
         if (data.length<1 || [tempstring isEqualToString:@"null"])
         {
             
             
             //[self performSelectorOnMainThread:@selector(serverFail) withObject:nil waitUntilDone:YES];
             
         }
         
         else
         {
             [self performSelectorOnMainThread:@selector(fetchedData:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );

}
-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    // NSLog(@"%@",[json valueForKey:@"status"]);
    if([[json valueForKey:@"status" ] isEqualToString:@"Record Created"])
    {
        UIAlertView *addsuccess=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Record Created" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        EventViewController *list = [[EventViewController alloc]init];
        [self.navigationController pushViewController:list animated:YES];

        
        [addsuccess show];
        
    }
    else
    {
        UIAlertView *addfailed=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Fail to create\nTry again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [addfailed show];
    }
    
}

@end