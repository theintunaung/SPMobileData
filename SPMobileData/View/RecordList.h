//
//  RecordList.h
//  SPMobileData
//
//  Created by theintunaung on 11/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordListViewModel.h"
#import "Record.h"
#import "GlobalConstants.h"
NS_ASSUME_NONNULL_BEGIN
@protocol RecordListDelegate <NSObject>
@optional
-(void)clickImageWithRecord:(Record *)currentRecord;
@end

@interface RecordList : UIView
@property(nonatomic, unsafe_unretained) id<RecordListDelegate> delegate;
@property (strong, nonatomic) UITableView *tableView;
-(void)reloadData;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
