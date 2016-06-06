//
//  AccountVC.h
//  Uber
//
//  Created by Elluminati - macbook on 23/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "BaseVC.h"

@interface AccountVC : BaseVC<UITextFieldDelegate>
{
    NSMutableArray *arrCountry;
    Country *selectedCountry;
}
+(AccountVC *)sharedObject;

@property(nonatomic,weak)IBOutlet UIScrollView *scrAcc;

@property(nonatomic,weak)IBOutlet UITextField *txtUserName;
@property(nonatomic,weak)IBOutlet UITextField *txtSex;
@property(nonatomic,weak)IBOutlet UITextField *txtEmailID;
@property(nonatomic,weak)IBOutlet UITextField *txtDOB;
@property(nonatomic,weak)IBOutlet UITextField *txtMoNo;

@property(nonatomic,weak)IBOutlet UIView *viewCountryCode;
@property(nonatomic,weak)IBOutlet UIPickerView *pickCountryCode;
@property(nonatomic,weak)IBOutlet UITextField *txtCountryCode;

-(IBAction)onClickHistory:(id)sender;
-(IBAction)onClickUpdate:(id)sender;
-(IBAction)onClickLogout:(id)sender;
-(IBAction)onClickDoneContryCode:(id)sender;

@end
