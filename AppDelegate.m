//
//  AppDelegate.m
//  Uber
//
//  Created by Elluminati - macbook on 19/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LoginVC.h"
#import "HomeVC.h"
#import "FooterView.h"
#import "LocationHelper.h"
#import "SplashVC.h"

@implementation AppDelegate


#pragma mark -
#pragma mark - UIApplication Launch

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //For Push Noti Reg.
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      UITextAttributeTextColor,
      [UIFont systemFontOfSize:18.0],
      UITextAttributeFont,
      [UIColor lightGrayColor],
      UITextAttributeTextShadowColor,
      nil]];
    
    //[[UIView appearance] setTintColor:[UIColor blackColor]];
    
    
    if (ISIOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_bg"] forBarMetrics:UIBarMetricsDefault];
        self.navMain.navigationBar.tintColor=[UIColor whiteColor];
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_bg"] forBarMetrics:UIBarMetricsDefault];
        self.navMain.navigationBar.translucent=YES;
    }
    
    if(ISIOS7){
        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                              green:173.0/255.0
                                               blue:234.0/255.0
                                              alpha:1.0];
        [self.window setTintColor:tintColor];
    }
    
    //User *user=[[User sharedUser]retriveCurrentUser];
    if ([[User currentUser]isLogin])
    {
        //[self goToHome];
        //[self getPush];
        [self goToSplash];
    }
    else{
        [self goToLogin];
    }
    
    [[LocationHelper sharedObject]startLocationUpdatingWithBlock:^(CLLocation *newLocation, CLLocation *oldLocation, NSError *error)
    {
    
    }];
    
    return YES;
}

#pragma mark -
#pragma mark - Nav Methods

-(void)getPush
{
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    
    [dictParam setObject:[User currentUser].client_id forKey:PARAM_USER_ID];
    if ([ClientAssignment sharedObject].random_id!=nil) {
        [dictParam setObject:[ClientAssignment sharedObject].random_id forKey:PARAM_RANDOM_ID];
    }
    
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@""];
    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
    [afn getDataFromPath:FILE_CLIENT_PUSH withParamData:dictParam withBlock:^(id response, NSError *error)
     {
         [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
         if (response)
         {
             NSMutableDictionary *dict=[response objectForKey:@"aps"];
             if ([[dict objectForKey:@"id"] intValue]==0) {
                 
                 //PickUpRequest *pick=[[PickUpRequest alloc]init];
                 //[pick setData:dict];
                 [[ClientAssignment sharedObject]setData:dict];
                 //[ClientAssignment sharedObject].random_id=pick.random_id;
                 
             }
             else if ([[dict objectForKey:@"id"] intValue]==4)
             {
                 [[ClientAssignment sharedObject]removeAllData];
             }
             else{
                 [self handalClientPush:response];
             }
             [self goToHome];
         }
     }];
}


-(void)goToSplash
{
    self.vcSplash = [[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
    self.navMain=[[UINavigationController alloc]initWithRootViewController:self.vcSplash];
    
    [self.window setRootViewController:self.navMain];
    [self.window makeKeyAndVisible];
}

-(void)goToLogin
{
    self.vcLogin = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
    self.navMain=[[UINavigationController alloc]initWithRootViewController:self.vcLogin];
    
    [self.window setRootViewController:self.navMain];
    [self.window makeKeyAndVisible];
}

-(void)goToHome
{
    //self.vcHome = [[HomeVC alloc]initWithNibName:@"HomeVC" bundle:nil];
    self.navMain=[[UINavigationController alloc]initWithRootViewController:[HomeVC sharedObject]];
    
    [self.window setRootViewController:self.navMain];
    //[self.window makeKeyAndVisible];
    
    //Add Footer
    float height =[[UIScreen mainScreen] bounds].size.height;
    self.viewFooter=[[FooterView alloc]initWithFrame:CGRectMake(0, height-65, 320, 50)];
    [[self window] addSubview:self.viewFooter];
}

#pragma mark -
#pragma mark - Handel Push Methods

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	DLog(@"My token is: %@", deviceToken);
    NSString *dt = [[deviceToken description] stringByTrimmingCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UserDefaultHelper sharedObject]setDeviceToken:dt];
    //[[UtilityClass sharedObject]showAlertWithTitle:@"deviceToken" andMessage:dt];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	DLog(@"Failed to get token, error: %@", error);
    NSString *dt =@"IOS_SIMULATOR";
    dt=@"e34fec1203fef82fb1910accc44db1951b97e733831f91f14beb6b917d377de2";
    [[UserDefaultHelper sharedObject]setDeviceToken:dt];
    //[[UtilityClass sharedObject]showAlertWithTitle:@"deviceToken" andMessage:dt];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                       options:(NSJSONWritingOptions)    (YES ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    NSString *strMsg=@"";
    if (! jsonData)
    {
        strMsg=error.localizedDescription;
    }
    else {
        strMsg=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    //[[UtilityClass sharedObject]showAlertWithTitle:@"RemoteNotification" andMessage:strMsg];
    //[self handalClientPush:userInfo];
     [self getPush];
}

-(void)handalClientPush:(NSDictionary *)dictPush
{
    [[ClientAssignment sharedObject]setData:[dictPush objectForKey:@"aps"]];
    [self gotoView:[HomeVC sharedObject]];
    [[HomeVC sharedObject]pushRecived];
}

-(void)gotoView:(id)vc
{
    BOOL isPush=NO;
    for (id viewControl in [AppDelegate sharedAppDelegate].navMain.viewControllers) {
        if (viewControl==vc) {
            isPush=YES;
        }
    }
    if (isPush) {
        [[AppDelegate sharedAppDelegate].navMain popToViewController:vc animated:NO];
    }else{
        [[AppDelegate sharedAppDelegate].navMain pushViewController:vc animated:NO];
    }
}

#pragma mark -
#pragma mark - UIApplication Delegate
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark - getHeader

-(UIButton *)getHeader:(UIImage *)imgHeader withTitle:(NSString *)strTitle
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[btn setImage:imgHeader forState:UIControlStateNormal];
    //[btn setImage:imgHeader forState:UIControlStateHighlighted];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitle:strTitle forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font=[UIFont systemFontOfSize:20];
    btn.userInteractionEnabled=NO;
    btn.frame=CGRectMake(0, 0, 200, 40);
    return btn;
}

-(NSMutableArray *)getCountry
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countrycodes" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error: NULL];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    NSMutableArray *arrCountry=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in arr) {
        Country *con=[[Country alloc]init];
        [con setData:dict];
        [arrCountry addObject:con];
    }
    return arrCountry;
}

#pragma mark -
#pragma mark - sharedAppDelegate

+(AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark - Loading View

-(void) showHUDLoadingView:(NSString *)strTitle
{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    //HUD.delegate = self;
    //HUD.labelText = [strTitle isEqualToString:@""] ? @"Loading...":strTitle;
    HUD.detailsLabelText=[strTitle isEqualToString:@""] ? @"Loading...":strTitle;
    [HUD show:YES];
}

-(void) hideHUDLoadingView
{
    [HUD removeFromSuperview];
}

-(void)showToastMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window
                                              animated:YES];
    
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.detailsLabelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2.0];
}

@end
