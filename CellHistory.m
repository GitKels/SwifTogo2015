//
//  CellHistory.m
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "CellHistory.h"
#import <QuartzCore/QuartzCore.h>
#import "History.h"
#import "HistoryVC.h"
#import "HistoryDetailVC.h"

@implementation CellHistory

@synthesize parent;

#pragma mark -
#pragma mark - Init

- (void)awakeFromNib
{
    // Initialization code
    /*
    self.viewBG.layer.masksToBounds = YES;
    self.viewBG.layer.opaque = NO;
    self.viewBG.layer.cornerRadius=5;
    self.viewBG.layer.borderWidth=1;
    self.viewBG.layer.borderColor=[UIColor whiteColor].CGColor;
     */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark -
#pragma mark - Methods

-(void)setCellData:(History *)data
{
    history=data;
    self.lblRefNo.text=history.random_id;
    NSDate *date=[[UtilityClass sharedObject]timestempToDate:history.time_of_pickup];
    NSString *pickTime=[[UtilityClass sharedObject] DateToString:date withFormate:@"hh:mm a"];
    
    self.lblPickUpTime.text=[NSString stringWithFormat:@"%@\n%@",history.request_time,pickTime];
}

#pragma mark -
#pragma mark - Actions

-(IBAction)onClickGoToDetail:(id)sender
{
    if ([parent isKindOfClass:[HistoryVC class]]) {
        HistoryVC *vcH=(HistoryVC *)parent;
        HistoryDetailVC *vc=[[HistoryDetailVC alloc]initWithNibName:@"HistoryDetailVC" bundle:nil];
        vc.history=history;
        [vcH.navigationController pushViewController:vc animated:YES];
    }
}

@end
