//
//  MoreView.m
//  Tinder
//
//  Created by Elluminati - macbook on 04/06/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "FooterView.h"

#import "AccountVC.h"
#import "HomeVC.h"
#import "SettingVC.h"

@implementation FooterView

@synthesize parent;

#pragma mark -
#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:self options:nil];
    for (UIView *view in arr)
    {
        if ([view isKindOfClass:[FooterView class]])
        {
            self=(FooterView *)view;
        }
    }
    if (self==nil)
    {
        self = [super initWithFrame:frame];
    }
    if (self)
    {
        self.frame=frame;
        self.backgroundColor=[UIColor clearColor];
        
        [self.btnSetting setBackgroundImage:[UIImage imageNamed:@"tab_about_icon"] forState:UIControlStateNormal];
    }
    [self removeAll];
    [self.btnJob setImage:[UIImage imageNamed:@"tab_icon_over"] forState:UIControlStateNormal];
    return self;
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onClickAccount:(id)sender
{
    [self removeAll];
    [self.btnShowProfile setImage:[UIImage imageNamed:@"tab_icon_over"] forState:UIControlStateNormal];
    [self gotoView:[AccountVC sharedObject]];
}

-(IBAction)onClickJobs:(id)sender
{
    [self removeAll];
    [self.btnJob setImage:[UIImage imageNamed:@"tab_icon_over"] forState:UIControlStateNormal];
    [self gotoView:[HomeVC sharedObject]];
}

-(IBAction)onClickSttings:(id)sender
{
    [self removeAll];
    [self.btnSetting setImage:[UIImage imageNamed:@"tab_icon_over"] forState:UIControlStateNormal];
    [self gotoView:[SettingVC sharedObject]];
}

-(void)removeAll
{
    [self.btnShowProfile setImage:nil forState:UIControlStateNormal];
    [self.btnJob setImage:nil forState:UIControlStateNormal];
    [self.btnSetting setImage:nil forState:UIControlStateNormal];
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
