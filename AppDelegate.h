//
//  AppDelegate.h
//  Uber
//
//  Created by Elluminati - macbook on 19/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginVC,MBProgressHUD,HomeVC,FooterView,SplashVC;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navMain;
@property (strong, nonatomic) SplashVC *vcSplash;
@property (strong, nonatomic) LoginVC *vcLogin;
@property (strong, nonatomic) HomeVC *vcHome;
@property (strong, nonatomic) FooterView *viewFooter;

-(void)goToSplash;
-(void)goToLogin;
-(void)goToHome;

-(UIButton *)getHeader:(UIImage *)imgHeader withTitle:(NSString *)strTitle;
-(NSMutableArray *)getCountry;
+(AppDelegate *)sharedAppDelegate;
-(void) showHUDLoadingView:(NSString *)strTitle;
-(void) hideHUDLoadingView;
-(void)showToastMessage:(NSString *)message;

@end
