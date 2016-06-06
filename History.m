//
//  History.m
//  Uber
//
//  Created by Elluminati - macbook on 27/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "History.h"

@implementation History

@synthesize random_id;
@synthesize lattitude;
@synthesize logitude;
@synthesize client_id;
@synthesize driver_id;
@synthesize time_of_pickup;
@synthesize end_lattitude;
@synthesize end_logitude;
@synthesize driver_name;
@synthesize client_name;
@synthesize request_time;

#pragma mark -
#pragma mark - Init

-(id)initWithData:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        [self setData:dict];
    }
    return self;
}

#pragma mark -
#pragma mark - Methods

-(void)setData:(NSDictionary *)dict
{
    random_id=[dict objectForKey:@"random_id"];
    lattitude=[dict objectForKey:@"lattitude"];
    logitude=[dict objectForKey:@"logitude"];
    client_id=[dict objectForKey:@"client_id"];
    driver_id=[dict objectForKey:@"driver_id"];
    time_of_pickup=[dict objectForKey:@"time_of_pickup"];
    end_lattitude=[dict objectForKey:@"end_lattitude"];
    end_logitude=[dict objectForKey:@"end_logitude"];
    driver_name=[dict objectForKey:@"driver_name"];
    client_name=[dict objectForKey:@"client_name"];
    
    if ([dict objectForKey:@"request_time"]!=nil) {
        NSDate *date=[[UtilityClass sharedObject]stringToDate:[dict objectForKey:@"request_time"] withFormate:@"yyyy-MM-dd HH:mm:ssZ"];
        request_time=[[UtilityClass sharedObject]DateToString:date withFormate:@"yyyy-MM-dd"];
    }
    //request_time=[dict objectForKey:@"request_time"];
    //2014-06-11 12:48:14+05:30
}

@end
