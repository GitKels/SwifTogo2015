//
//  PickUpRequest.h
//  Uber
//
//  Created by Elluminati - macbook on 02/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickUpRequest : NSObject

@property(nonatomic,copy)NSString *request_id;
@property(nonatomic,copy)NSString *random_id;
@property(nonatomic,copy)NSString *request_time;
@property(nonatomic,copy)NSString *lattitude;
@property(nonatomic,copy)NSString *logitude;
@property(nonatomic,copy)NSString *client_id;
@property(nonatomic,copy)NSString *driver_id;
@property(nonatomic,copy)NSString *time_of_pickup;
@property(nonatomic,copy)NSString *request_status;
@property(nonatomic,copy)NSString *complete_status;
@property(nonatomic,copy)NSString *cancel_flg;

@property(nonatomic,copy)NSString *end_lattitude;
@property(nonatomic,copy)NSString *end_logitude;
@property(nonatomic,copy)NSString *payment_status;

+(PickUpRequest *)sharedObject;
-(void)setData:(NSDictionary *)dictData;

@end
