//
//  HistoryDetailVC.h
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "BaseVC.h"

#import <MapKit/MapKit.h>

@class MapView;
@class History;
@interface HistoryDetailVC : BaseVC<MKMapViewDelegate>
{
    
}
@property(nonatomic,weak)IBOutlet MapView *viewMap;
@property(nonatomic,weak)IBOutlet MKMapView *map;
@property(nonatomic,weak)IBOutlet UILabel *lblRefNo;
@property(nonatomic,weak)IBOutlet UILabel *lblClient;
@property(nonatomic,weak)IBOutlet UILabel *lblDriver;
@property(nonatomic,weak)IBOutlet UILabel *lblPickUpTime;

@property(nonatomic,strong)History *history;

@end
