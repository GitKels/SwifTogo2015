//
//  ClientAssignment.m
//  Uber
//
//  Created by Elluminati - macbook on 03/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "ClientAssignment.h"

@implementation ClientAssignment

@synthesize alert;
@synthesize random_id;
@synthesize id_;
@synthesize badge;
@synthesize sound;
@synthesize time_of_pickup;
@synthesize status;
@synthesize message;

@synthesize pushClientID;

@synthesize dateETAClient;

#pragma mark -
#pragma mark - Init

-(id)init
{
    self=[super init];
    if (self)
    {
        NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:UD_CLIENTASSIGNMENT];
        if (dict!=nil)
        {
            [self setData:dict];
        }
    }
    return self;
}

+(ClientAssignment *)sharedObject
{
    static ClientAssignment *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ClientAssignment alloc] init];
    });
    return obj;
}

-(id)initWithClientAssignment:(ClientAssignment *)ca
{
    self=[super init];
    if (self)
    {
        alert=ca.alert;
        random_id=ca.random_id;
        id_=ca.id_;
        badge=ca.badge;
        sound=ca.sound;
        time_of_pickup=ca.time_of_pickup;
        status=ca.status;
        message=ca.message;
        pushClientID=ca.pushClientID;
    }
    return self;
}

#pragma mark -
#pragma mark - Methods

-(void)setData:(NSDictionary *)dictData
{
    if (dictData==nil)
    {
        return;
    }
    alert=[dictData objectForKey:@"alert"];
    random_id=[dictData objectForKey:@"random_id"];
    id_=[dictData objectForKey:@"id"];
    sound=[dictData objectForKey:@"sound"];
    badge=[dictData objectForKey:@"badge"];
    time_of_pickup=[dictData objectForKey:@"time_of_pickup"];
    status=[dictData objectForKey:@"status"];
    message=[dictData objectForKey:@"message"];
    
    if ([id_ intValue]==1)
    {
        pushClientID=PushClientIdPickUpTimeSet;
    }
    else if([id_ intValue]==2)
    {
        pushClientID=PushClientIdJobDone;
    }
    else if ([id_ intValue]==5)
    {
        pushClientID=PushClientIdDriverReched;
    }
    else{
        pushClientID=PushClientIdDeleteRequest;
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:dictData forKey:UD_CLIENTASSIGNMENT];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (time_of_pickup!=nil)
    {
        double currentTime=[[NSDate date]timeIntervalSince1970];
        double timeToAdd=([time_of_pickup doubleValue]/1000);
        double newTime=currentTime+timeToAdd;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:newTime];
        [self setETAClient:date];
    }
}

-(BOOL)isActiveJob
{
    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:UD_CLIENTASSIGNMENT];
    if (dict!=nil)
    {
        return YES;
    }
    else{
        return NO;
    }
}

-(void)setETAClient:(NSDate *)date
{
    if (date==nil)
    {
        return;
    }
    dateETAClient=date;
    [[NSUserDefaults standardUserDefaults]setObject:date forKey:UD_DATE_ETA_CLIENT];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)removeAllData
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UD_CLIENTASSIGNMENT];
    [[NSUserDefaults standardUserDefaults]synchronize];
    alert=nil;
    random_id=nil;
    time_of_pickup=nil;
    id_=nil;
    badge=nil;
    sound=nil;
    status=nil;
    message=nil;
    pushClientID=PushClientIdDeleteRequest;
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UD_DATE_ETA_CLIENT];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UD_AMOUNT_PAID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
