//
//  Country.h
//  Free_Towber
//
//  Created by Elluminati - macbook on 29/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *alpha2;
@property(nonatomic,copy)NSString *countryCode;
@property(nonatomic,copy)NSString *phoneCode;

-(void)setData:(NSDictionary *)dict;

@end

