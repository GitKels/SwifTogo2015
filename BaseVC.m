//
//  BaseVC.m
//  Uber
//
//  Created by Elluminati - macbook on 21/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    if (IS_IPHONE_5)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg_4"]]];
    }
    else{
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg"]]];
    }
     */
}

#pragma mark -
#pragma mark - Utility methods

-(void)addBackButton
{
    UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame=CGRectMake(0, 0, 24, 30);
    [btnBack setImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btnBack];
}

-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoView:(id)vc
{
    BOOL isPush=NO;
    for (id viewControl in [AppDelegate sharedAppDelegate].navMain.viewControllers)
    {
        if (viewControl==vc)
        {
            isPush=YES;
        }
    }
    if (isPush)
    {
        [[AppDelegate sharedAppDelegate].navMain popToViewController:vc animated:NO];
    }
    else{
        [[AppDelegate sharedAppDelegate].navMain pushViewController:vc animated:NO];
    }
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
