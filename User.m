//
//  User.m
//  Uber
//
//  Created by Elluminati - macbook on 26/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize client_id,name,email,contact,date_of_birth,gender,reg_time,country_code;

#pragma mark -
#pragma mark - Init

-(id)init
{
    self=[super init];
    if (self)
    {
        NSMutableDictionary *dict=[[UserDefaultHelper sharedObject]userInfo];
        if (dict!=nil)
        {
            [self setUser:dict];
        }
    }
    return self;
}

+(User *)currentUser
{
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}

#pragma mark -
#pragma mark - Methods

-(void)setUser:(NSMutableDictionary *)dict{
    
    name=[dict objectForKey:@"name"];
    email=[dict objectForKey:@"email"];
    contact=[dict objectForKey:@"contact"];
    date_of_birth=[dict objectForKey:@"date_of_birth"];
    gender=[dict objectForKey:@"gender"];
    reg_time=[dict objectForKey:@"reg_time"];

    client_id=[dict objectForKey:@"client_id"];
    
    country_code=[dict objectForKey:@"country_code"];
    
    [[UserDefaultHelper sharedObject]setUserInfo:dict];
}

-(BOOL)isLogin
{
    BOOL isLogin=NO;
    if (client_id!=nil)
    {
        isLogin=YES;
    }
    return isLogin;
}

-(void)logout
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UD_USER_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
    client_id=nil;
}

-(void)changeDriverStat:(NSMutableDictionary *)dictStat
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[[UserDefaultHelper sharedObject]userInfo]];
    [dict setObject:[dictStat objectForKey:@"is_busy"] forKey:@"is_busy"];
    [dict setObject:[dictStat objectForKey:@"driver_busy_stat"] forKey:@"driver_busy_stat"];
    [self setUser:dict];
}

@end
