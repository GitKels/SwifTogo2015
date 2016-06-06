//
//  DriverInfo.h
//  Uber
//
//  Created by Elluminati - macbook on 17/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverInfo : NSObject

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *contact;
@property(nonatomic,copy)NSString *lattitude;
@property(nonatomic,copy)NSString *logitude;
@property(nonatomic,copy)NSString *rating;

-(void)setData:(NSDictionary *)dict;

@end

