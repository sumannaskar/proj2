//
//  EditBudgetViewController.m
//  wedingproj
//
//  Created by Micronixtraining on 3/7/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "EditBudgetViewController.h"
#import "EventViewController.h"
#define UpdateCat [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=category_update&"]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface EditBudgetViewController ()

@end

@implementation EditBudgetViewController

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
    [self image];
    NameText.delegate = self;
     AmntText.delegate = self;
     DescTextView.delegate = self;
    
    scroll.contentSize=CGSizeMake(320, 550);
    NameText.text = self.CatName;
    AmntText.text = self.CatBudget;
    DescTextView.text = self.CatDesc;
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

- (IBAction)SaveAction:(UIButton *)sender {
    
    json = [[NSDictionary alloc]init];
    
    NSString *string =[[NSString alloc]initWithFormat:@"category_id=%@&event_id=%@&category_name=%@&estimate_budget=%@&description=%@&apikey=micronix_10_2014_wedsimple_proj",self.CatId,self.EventIdStr,NameText.text,AmntText.text,DescTextView.text];
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
    if([[json valueForKey:@"status" ] isEqualToString:@"Record Updated"])
    {
        UIAlertView *addsuccess=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Record Updated" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        EventViewController *list = [[EventViewController alloc]init];
        [self.navigationController pushViewController:list animated:YES];
    
        [addsuccess show];
        
    }
    else
    {
        UIAlertView *addfailed=[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"Fail to update\nTry again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [addfailed show];
    }

}
#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [self.SaveBtn setBackgroundImage:[UIImage imageNamed:@"save-chenages_iphone.png"] forState:UIControlStateNormal];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [self.BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [self.BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [self.BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [self.BackImgv setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            [self.SaveBtn setBackgroundImage:[UIImage imageNamed:@"save-changes.png"] forState:UIControlStateNormal];
            
        }
        
    }
}


@end
