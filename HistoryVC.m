//
//  HistoryVC.m
//  Uber
//
//  Created by Elluminati - macbook on 24/06/14.
//  Copyright (c) 2014 Elluminati MacBook Pro 1. All rights reserved.
//

#import "HistoryVC.h"
#import "CellHistory.h"
#import "HistoryDetailVC.h"
#import "History.h"

@interface HistoryVC ()

@end

@implementation HistoryVC

#pragma mark -
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"History";
    }
    return self;
}

#pragma mark -
#pragma mark - ViewLife Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super addBackButton];
    self.navigationItem.titleView=[[AppDelegate sharedAppDelegate]getHeader:[UIImage imageNamed:@"header_history_detail_icon"]withTitle:TITLE_HISTORY];
    arrHistory=[[NSMutableArray alloc]init];
    [self getHistory];
}

#pragma mark -
#pragma mark - Methods

-(void)getHistory
{
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    
    [dictParam setObject:USER_TYPE forKey:PARAM_IS_DRIVER];
    [dictParam setObject:[User currentUser].client_id forKey:PARAM_USER_ID];
    
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@""];
    AFNHelper *afn=[[AFNHelper alloc]initWithRequestMethod:POST_METHOD];
    [afn getDataFromPath:FILE_GET_HISTORY withParamData:dictParam withBlock:^(id response, NSError *error)
    {
        [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        if (response)
        {
            NSMutableDictionary *dict=[response objectForKey:WS_UBER_ALPHA];
            if ([[dict objectForKey:WS_STATUS]isEqualToString:WS_STATUS_SUCCESS])
            {
                NSArray *arr=[dict objectForKey:WS_DETAILS];
                if (arr)
                {
                    [arrHistory removeAllObjects];
                    for (NSDictionary *dic in arr)
                    {
                        History *his=[[History alloc]initWithData:dic];
                        [arrHistory addObject:his];
                    }
                    [self.tblHistory reloadData];
                }
            }
            else{
                [[AppDelegate sharedAppDelegate]showToastMessage:[dict objectForKey:WS_MESSAGE]];
            }
        }
    }];
}

#pragma mark -
#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrHistory count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor clearColor];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifire=@"CellHistory";
    CellHistory *cell=(CellHistory *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifire];
    
    if (cell==nil)
    {
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CellHistory" owner:self options:nil];
        for (UIView *view in arr)
        {
            if ([view isKindOfClass:[CellHistory class]])
            {
                cell=(CellHistory *)view;
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell setCellData:[arrHistory objectAtIndex:indexPath.row]];
    cell.parent=self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    HistoryDetailVC *vc=[[HistoryDetailVC alloc]initWithNibName:@"HistoryDetailVC" bundle:nil];
    vc.history=[arrHistory objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    */
}

#pragma mark -
#pragma mark - Memory Mgmt

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
