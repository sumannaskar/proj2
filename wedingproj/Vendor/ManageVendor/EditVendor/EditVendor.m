//
//  EditVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "EditVendor.h"
#import "ManageVendor.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_update&"]

@interface EditVendor ()

@end

@implementation EditVendor
@synthesize json;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        json =[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    vendornametext.text=[[json valueForKey:@"data" ] valueForKey:@"vendor_name"];
    categorytext.text =[[json valueForKey:@"data" ] valueForKey:@"category"];
    emailtext.text=[[json valueForKey:@"data" ] valueForKey:@"email"];
    contactnotext.text =[[json valueForKey:@"data" ] valueForKey:@"contact"];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)save:(id)sender
{
    NSString *savedata =[[NSString alloc]initWithFormat:@"vendor_id=%@&vendor_name=%@&category=%@&email=%@&contact=%@&apikey=micronix_10_2014_wedsimple_proj",[json valueForKey:@"vendor_id"],vendornametext.text,categorytext.text,emailtext.text,contactnotext.text];
    NSString* urlTextEscaped = [savedata stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,urlTextEscaped]] ;
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    responce =[[NSMutableArray alloc]init];
    
    responce=[[NSMutableArray alloc]init];
    responce = [NSJSONSerialization
                JSONObjectWithData:urlData //1
                
                options:kNilOptions
                error:&error];
    
    
    if ([[responce valueForKey:@"status"] isEqual:@"Record Updated"]) {
        UIAlertView *createvendor =[[UIAlertView alloc]initWithTitle:@"weding" message:@"vendor edit sucessfully" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [createvendor show];
        ManageVendor *ManageVendor_ =[[ManageVendor alloc]init];
        [self.navigationController pushViewController:ManageVendor_ animated:YES];
        
    }
    else
    {
        UIAlertView *createvendor =[[UIAlertView alloc]initWithTitle:@"weding" message:@"unable to vendor edit" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [createvendor show];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
