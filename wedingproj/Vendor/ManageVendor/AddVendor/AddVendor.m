//
//  AddVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "AddVendor.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "VendorViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_create&"]
#define kcategorylistURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_cat"]
#define kcategorylistURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]

@interface AddVendor ()

@end

@implementation AddVendor

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
    self.pickerVw.dataSource=self;
    self.pickerVw.delegate=self;
    self.pickerVw.showsSelectionIndicator=YES;
    [categorytext setInputView:self.respondingView];
    
    
    //Vendor-category Fetching....
    NSURL *tempcategoryurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@&user_id=%@%@",kcategorylistURL1,[SSKeychain passwordForService:@"LoginViewController" account:@"User"],kcategorylistURL2]];
    NSError *error;
    NSData* categoryListData = [NSData dataWithContentsOfURL: tempcategoryurl];
    NSDictionary* rawecategoryListDic = [NSJSONSerialization JSONObjectWithData:categoryListData options:kNilOptions error:&error];
    NSArray *rawcategoryList=[[NSArray alloc]init];
    //    NSArray* raweventList = [NSJSONSerialization JSONObjectWithData:eventListData options:kNilOptions error:&error];
    totalcategorylist=[[NSMutableArray alloc ]init];
    
    if ([[rawecategoryListDic valueForKey:@"availability"]isEqualToString:@"no"])
    {
        NSLog(@"Alert");
    }
    else
    {
        rawcategoryList = [rawecategoryListDic valueForKey:@"data"];
        for(int i=0;i<rawcategoryList.count;i++)
        {
            
            NSDictionary *tempDict=[rawcategoryList objectAtIndex:i];
            [totalcategorylist addObject:[tempDict objectForKey:@"category"]];
            
        }
    }


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)save:(id)sender
{
    NSString *savedata =[[NSString alloc]initWithFormat:@"user_id=%@&vendor_name=%@&category=%@&email=%@&contact=%@&apikey=micronix_10_2014_wedsimple_proj",[SSKeychain passwordForService:@"LoginViewController" account:@"User"],vendornametext.text,categorytext.text,emailtext.text,contactnotext.text];
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
    responce=[[NSMutableArray alloc]init];
    responce = [NSJSONSerialization
            JSONObjectWithData:urlData //1
            
            options:kNilOptions
            error:&error];

    
    if ([[responce valueForKey:@"status"] isEqual:@"Record Created"]) {
        UIAlertView *createvendor =[[UIAlertView alloc]initWithTitle:@"weding" message:@"vendor create" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [createvendor show];
        VendorViewController *VendorViewController_ =[[VendorViewController alloc]init];
        [self.navigationController pushViewController:VendorViewController_ animated:YES];
        
    }
    else
    {
        UIAlertView *createvendor =[[UIAlertView alloc]initWithTitle:@"weding" message:@"unable to vendor create" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [createvendor show];

    }

}
#pragma mark -
#pragma mark - picker view delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rowCount;
    //rowCount= [location count];
    rowCount=[totalcategorylist count];
    return rowCount;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    // return [location objectAtIndex:row];
    return [totalcategorylist objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    categorytext.text=[totalcategorylist objectAtIndex:row];
    
    
}

- (IBAction)done:(id)sender
{
    
    if (!(categorytext.text.length>0)) {
        //        mytxtfield.text=[stateList objectAtIndex:0];
        //        self.stateName=[stateList objectAtIndex:0];
        
        categorytext.text=[totalcategorylist objectAtIndex:0];
        //        addressdetailsText.text=[address objectAtIndex:0];
        //        loactionName=[location objectAtIndex:0];
    }
    
    [categorytext resignFirstResponder];
}
- (IBAction)cancel:(UIBarButtonItem *)sender
{
    categorytext.text=@"";
    
    //addressdetailsText.text=@"";
    
    
    [categorytext resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
