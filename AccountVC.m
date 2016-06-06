//
//  AccountVC.m
//  Uber
//
//  Created by Elluminati - macbook on 23/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "AccountVC.h"
#import "HistoryVC.h"

@interface AccountVC ()

@end

@implementation AccountVC

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"My Account";
    }
    return self;
}

+(AccountVC *)sharedObject
{
    static AccountVC *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[AccountVC alloc] initWithNibName:@"AccountVC" bundle:nil];
    });
    return obj;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView=[[AppDelegate sharedAppDelegate]getHeader:[UIImage imageNamed:@"header_account_icon"]withTitle:TITLE_ACCOUNT];
    
    self.txtCountryCode.inputView=self.viewCountryCode;
    
    self.scrAcc.contentSize=CGSizeMake(320, 400);
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    
    [dictParam setObject:USER_TYPE forKey:PARAM_IS_DRIVER];
    [dictParam setObject:[User currentUser].client_id forKey:PARAM_USER_ID];
    
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@""];
    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
    [afn getDataFromPath:FILE_GET_PROFILE withParamData:dictParam withBlock:^(id response, NSError *error)
    {
        [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        if (response)
        {
            NSMutableDictionary *dict=[response objectForKey:WS_UBER_ALPHA];
            if ([[dict objectForKey:WS_STATUS]isEqualToString:WS_STATUS_SUCCESS])
            {
                [[User currentUser]setUser:[dict objectForKey:WS_DETAILS]];
                [self fillData];
            }
            else{
                [[AppDelegate sharedAppDelegate]showToastMessage:[dict objectForKey:WS_MESSAGE]];
            }
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

#pragma mark -
#pragma mark - Methods

-(void)fillData
{
    self.txtUserName.text=[User currentUser].name;
    self.txtEmailID.text=[User currentUser].email;
    self.txtMoNo.text=[User currentUser].contact;
    self.txtDOB.text=[[UtilityClass sharedObject] getAge:[[UtilityClass sharedObject]stringToDate:[User currentUser].date_of_birth withFormate:DATE_FORMATE_DOB]];
    self.txtSex.text=[User currentUser].gender;
    self.txtCountryCode.text=[User currentUser].country_code;
    /*
    if ([[User currentUser].gender isEqualToString:VALUE_GENDER_MALE] )
    {
        self.imgMaleFemale.image=[UIImage imageNamed:@"sex_selector_male"];
    }
    else{
        self.imgMaleFemale.image=[UIImage imageNamed:@"sex_selector_female"];
    }
     */
    arrCountry=[[AppDelegate sharedAppDelegate]getCountry];
    [self.pickCountryCode reloadAllComponents];
}

-(void)updateAccount
{
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:self.txtUserName.text forKey:PARAM_NAME];
    [dictParam setObject:self.txtMoNo.text forKey:PARAM_CONTACT];
    
    [dictParam setObject:USER_TYPE forKey:PARAM_IS_DRIVER];
    [dictParam setObject:[User currentUser].client_id forKey:PARAM_USER_ID];
    
    if (selectedCountry==nil) {
        [dictParam setObject:self.txtCountryCode.text forKey:PARAM_COUNTRY_CODE];
    }else{
        [dictParam setObject:selectedCountry.phoneCode forKey:PARAM_COUNTRY_CODE];
    }
    
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@""];
    
    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
    [afn getDataFromPath:FILE_EDIT_PROFILE withParamData:dictParam withBlock:^(id response, NSError *error) {
        [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        if (response) {
            NSMutableDictionary *dict=[response objectForKey:WS_UBER_ALPHA];
            if ([[dict objectForKey:WS_STATUS]isEqualToString:WS_STATUS_SUCCESS]) {
                [[AppDelegate sharedAppDelegate]showToastMessage:[dict objectForKey:WS_MESSAGE]];
                [[User currentUser]setUser:[dict objectForKey:WS_DETAILS]];
            }else{
                [[AppDelegate sharedAppDelegate]showToastMessage:[dict objectForKey:WS_MESSAGE]];
            }
        }else{
            [[AppDelegate sharedAppDelegate]showToastMessage:@"Server error, please try again"];
        }
    }];
}

#pragma mark -
#pragma mark - Actions


-(IBAction)onClickHistory:(id)sender
{
    HistoryVC *vc=[[HistoryVC alloc]initWithNibName:@"HistoryVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)onClickUpdate:(id)sender
{
    [self textFieldShouldReturn:self.txtMoNo];
    
    if (self.txtUserName.text.length==0 || self.txtMoNo.text.length==0)
    {
        [[UtilityClass sharedObject]showAlertWithTitle:@"Error!" andMessage:@"Plase enter name and Phone no."];
        return;
    }
    [self updateAccount];
}

-(IBAction)onClickLogout:(id)sender
{
    [[User currentUser]logout];
    [[AppDelegate sharedAppDelegate]goToLogin];
}

-(IBAction)onClickDoneContryCode:(id)sender
{
    self.txtCountryCode.text=selectedCountry.phoneCode;
    [self.txtCountryCode resignFirstResponder];
    [self.txtMoNo becomeFirstResponder];
}

#pragma mark -
#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    int y=0;
    if (textField==self.txtMoNo || textField==self.txtCountryCode)
    {
        y=150;
    }
    [self.scrAcc setContentOffset:CGPointMake(0, y) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtUserName)
    {
        [self.txtCountryCode becomeFirstResponder];
    }
    if (textField==self.txtCountryCode)
    {
        [self.txtMoNo becomeFirstResponder];
    }
    else if (textField==self.txtMoNo){
        [self.txtMoNo resignFirstResponder];
        [self.scrAcc setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //[textField resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark - UIPickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrCountry count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Country *contry=[arrCountry objectAtIndex:row];
    NSString *strTitle=[NSString stringWithFormat:@"%@ - %@",contry.phoneCode,contry.name];
    return strTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedCountry=[arrCountry objectAtIndex:row];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
