//
//  HistoryDetailVC.m
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "HistoryDetailVC.h"
#import "History.h"
#import "MapView.h"
#import "Place.h"

@interface HistoryDetailVC ()

@end

@implementation HistoryDetailVC

@synthesize history;

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super addBackButton];
    self.navigationItem.titleView=[[AppDelegate sharedAppDelegate]getHeader:[UIImage imageNamed:@"header_history_detail_icon"]withTitle:TITLE_HISTORYDETAIL];
    self.viewMap.layer.masksToBounds = YES;
    self.viewMap.layer.opaque = NO;
    self.viewMap.layer.cornerRadius=5;
    self.viewMap.layer.borderWidth=1;
    self.viewMap.layer.borderColor=[UIColor blueColor].CGColor;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fillData];
}

#pragma mark -
#pragma mark - Methods

-(void)fillData
{
    self.lblRefNo.text=history.random_id;
    self.lblClient.text=history.client_name;
    self.lblDriver.text=history.driver_name;
    /*
    NSDate *date=[[UtilityClass sharedObject]timestempToDate:history.time_of_pickup];
    self.lblPickUpTime.text=[[UtilityClass sharedObject] DateToString:date withFormate:@"HH:mm a"];
    */
    NSDate *date=[[UtilityClass sharedObject]timestempToDate:history.time_of_pickup];
    NSString *pickTime=[[UtilityClass sharedObject] DateToString:date withFormate:@"hh:mm a"];
    
    self.lblPickUpTime.text=[NSString stringWithFormat:@"%@ %@",history.request_time,pickTime];
    
    [self.viewMap initMapView];
    
    Place* home = [[Place alloc] init];
	home.name = @"";
	home.description = @"";
	home.latitude = [history.lattitude doubleValue];
	home.longitude = [history.logitude doubleValue];
    home.isFrom=YES;
	
	Place* office = [[Place alloc] init];
	office.name = @"";
	office.description = @"";
	office.latitude = [history.end_lattitude doubleValue];
	office.longitude = [history.end_logitude doubleValue];
	office.isFrom=NO;
    
	[self.viewMap showRouteFrom:home to:office];
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
