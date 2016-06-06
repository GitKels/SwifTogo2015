//
//  MoreView.h
//  Tinder
//
//  Created by Elluminati - macbook on 04/06/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UIView
{
    
}
@property(nonatomic,strong)id parent;

@property(nonatomic,weak)IBOutlet UIButton *btnShowProfile;
@property(nonatomic,weak)IBOutlet UIButton *btnJob;
@property(nonatomic,weak)IBOutlet UIButton *btnSetting;

-(IBAction)onClickAccount:(id)sender;
-(IBAction)onClickJobs:(id)sender;
-(IBAction)onClickSttings:(id)sender;

@end
