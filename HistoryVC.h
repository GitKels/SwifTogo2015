//
//  HistoryVC.h
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "BaseVC.h"

@interface HistoryVC : BaseVC<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrHistory;
}
@property(nonatomic,weak)IBOutlet UITableView *tblHistory;

@end
