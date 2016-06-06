//
//  CellHistory.h
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class History;
@interface CellHistory : UITableViewCell
{
    History *history;
}
@property(nonatomic,strong)id parent;

@property(nonatomic,weak)IBOutlet UIView *viewBG;
@property(nonatomic,weak)IBOutlet UILabel *lblRefNo;
@property(nonatomic,weak)IBOutlet UILabel *lblPickUpTime;

-(void)setCellData:(History *)data;

-(IBAction)onClickGoToDetail:(id)sender;

@end
