//
//  History.h
//  Uber
//
//  Created by Elluminati - macbook on 27/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

@property(nonatomic,copy)NSString *random_id;
@property(nonatomic,copy)NSString *lattitude;
@property(nonatomic,copy)NSString *logitude;
@property(nonatomic,copy)NSString *client_id;
@property(nonatomic,copy)NSString *driver_id;
@property(nonatomic,copy)NSString *time_of_pickup;
@property(nonatomic,copy)NSString *end_lattitude;
@property(nonatomic,copy)NSString *end_logitude;
@property(nonatomic,copy)NSString *driver_name;
@property(nonatomic,copy)NSString *client_name;

@property(nonatomic,copy)NSString *request_time;

-(id)initWithData:(NSDictionary *)dict;
-(void)setData:(NSDictionary *)dict;

@end

