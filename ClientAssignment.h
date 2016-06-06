//
//  ClientAssignment.h
//  Uber
//
//  Created by Elluminati - macbook on 03/07/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UD_CLIENTASSIGNMENT     @"ClientAssignment"
#define UD_DATE_ETA_CLIENT      @"dateETAClient"
#define UD_AMOUNT_PAID          @"amountPaid"

@interface ClientAssignment : NSObject

@property(nonatomic,copy)NSString *alert;
@property(nonatomic,copy)NSString *random_id;
@property(nonatomic,copy)NSString *time_of_pickup;
@property(nonatomic,copy)NSString *id_;
@property(nonatomic,copy)NSString *badge;
@property(nonatomic,copy)NSString *sound;

@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *message;

@property(nonatomic,assign)PushClientID pushClientID;

@property(nonatomic,copy)NSDate *dateETAClient;


-(id)initWithClientAssignment:(ClientAssignment *)ca;
+(ClientAssignment *)sharedObject;
-(void)setData:(NSDictionary *)dictData;
-(BOOL)isActiveJob;
-(void)removeAllData;

/*
 
 "aps": {
 "alert": "Your payment amount is 10.00",
 "random_id": "-zHa17",
 "amount": "10.00",
 "status": "success",
 "paypal_id": "AUhsOBDXuFpQoyczrsPlopdO9D1zlxzWR50HEZvlNAmlXioYU98X5rUBxT08",
 "id": "3",
 "badge": 1,
 "sound": "default"
 }
 */


@end

