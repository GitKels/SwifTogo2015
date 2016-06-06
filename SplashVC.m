//
//  SplashVC.m
//  Uber
//
//  Created by Elluminati - macbook on 21/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "SplashVC.h"
#import "LoginVC.h"
#import "HomeVC.h"

@interface SplashVC ()

@end

@implementation SplashVC

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
    if (IS_IPHONE_5) {
        self.imgSplash.image=[UIImage imageNamed:@"splash-568h"];
    }else{
        self.imgSplash.image=[UIImage imageNamed:@"splash"];
    }
    [self getPush];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}


-(void)getPush
{
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    
    [dictParam setObject:[User currentUser].client_id forKey:PARAM_USER_ID];
    if ([ClientAssignment sharedObject].random_id!=nil) {
        [dictParam setObject:[ClientAssignment sharedObject].random_id forKey:PARAM_RANDOM_ID];
    }
    
    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
    [afn getDataFromPath:FILE_CLIENT_PUSH withParamData:dictParam withBlock:^(id response, NSError *error)
     {
         if (response)
         {
             [[AppDelegate sharedAppDelegate] goToHome];
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
         }
     }];
}

-(void)handalClientPush:(NSDictionary *)dictPush
{
    [[ClientAssignment sharedObject]setData:[dictPush objectForKey:@"aps"]];
    //[self gotoView:[HomeVC sharedObject]];
    [[HomeVC sharedObject]pushRecived];
}


#pragma mark -
#pragma mark - ViewLife Cycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
