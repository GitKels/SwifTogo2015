//
//  DriverInfo.m
//  Uber
//
//  Created by Elluminati - macbook on 17/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "DriverInfo.h"

@implementation DriverInfo

@synthesize user_id;
@synthesize name;
@synthesize contact;
@synthesize lattitude;
@synthesize logitude;
@synthesize rating;

-(void)setData:(NSDictionary *)dict
{
    user_id=[dict objectForKey:@"user_id"];
    name=[dict objectForKey:@"name"];
    contact=[dict objectForKey:@"contact"];
    lattitude=[dict objectForKey:@"lattitude"];
    logitude=[dict objectForKey:@"logitude"];
    rating=[dict objectForKey:@"rating"];
}

@end
