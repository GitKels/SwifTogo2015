//
//  PickUpRequest.m
//  Uber
//
//  Created by Elluminati - macbook on 02/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "PickUpRequest.h"

@implementation PickUpRequest

@synthesize request_id;
@synthesize random_id;
@synthesize request_time;
@synthesize lattitude;
@synthesize logitude;
@synthesize client_id;
@synthesize driver_id;
@synthesize time_of_pickup;
@synthesize request_status;
@synthesize complete_status;
@synthesize cancel_flg;

@synthesize end_lattitude;
@synthesize end_logitude;
@synthesize payment_status;

#pragma mark -
#pragma mark - Init

-(id)init{
    self=[super init];
    if (self) {
       
    }
    return self;
}

+(PickUpRequest *)sharedObject{
    static PickUpRequest *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[PickUpRequest alloc] init];
    });
    return obj;
}

#pragma mark -
#pragma mark - Methods

-(void)setData:(NSDictionary *)dictData
{
    request_id=[dictData objectForKey:@"request_id"];
    random_id=[dictData objectForKey:@"random_id"];
    request_time=[dictData objectForKey:@"request_time"];
    lattitude=[dictData objectForKey:@"lattitude"];
    logitude=[dictData objectForKey:@"logitude"];
    client_id=[dictData objectForKey:@"client_id"];
    driver_id=[dictData objectForKey:@"driver_id"];
    time_of_pickup=[dictData objectForKey:@"time_of_pickup"];
    request_status=[dictData objectForKey:@"request_status"];
    complete_status=[dictData objectForKey:@"complete_status"];
    cancel_flg=[dictData objectForKey:@"cancel_flg"];
    
    end_lattitude=[dictData objectForKey:@"end_lattitude"];
    end_logitude=[dictData objectForKey:@"end_logitude"];
    payment_status=[dictData objectForKey:@"payment_status"];
}

@end
