//
//  RecordListViewModel.h
//  SPMobileData
//
//  Created by theintunaung on 11/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RecordListViewModelDelegate;
@interface RecordListViewModel : NSObject

@property (nonatomic) NSArray* records;
@property(nonatomic, unsafe_unretained) IBOutlet id<RecordListViewModelDelegate> delegate;

-(instancetype)initWithDelegate:(id)delegate;
-(void)initData;
-(NSArray*)getRecords;
-(NSArray*)getRecordsByYear:(NSString *)year;
@end

@protocol RecordListViewModelDelegate <NSObject>

@optional
- (void)recordListViewModelDidFinishInit:(RecordListViewModel *)compareViewModel ;
- (void)recordListViewModelDidReloadData:(RecordListViewModel *)compareViewModel ;

@end

NS_ASSUME_NONNULL_END
