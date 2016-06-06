//
//  Country.m
//  Free_Towber
//
//  Created by Elluminati - macbook on 29/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "Country.h"

@implementation Country

@synthesize name;
@synthesize alpha2;
@synthesize countryCode;
@synthesize phoneCode;

-(void)setData:(NSDictionary *)dict
{
    name=[dict objectForKey:@"name"];
    alpha2=[dict objectForKey:@"alpha-2"];
    countryCode=[dict objectForKey:@"country-code"];
    phoneCode=[dict objectForKey:@"phone-code"];
}

@end

