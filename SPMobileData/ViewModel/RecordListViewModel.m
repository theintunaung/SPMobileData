//
//  RecordListViewModel.m
//  SPMobileData
//
//  Created by theintunaung on 11/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "RecordListViewModel.h"
#import "CommonUtils.h"
#import "GlobalConstants.h"

@implementation RecordListViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        [self reloadData];
    }
    return self;
}

-(instancetype)initWithDelegate:(id)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self initData];

    }
    return self;
}

-(void)initData{
     self.records = [self generateData];
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(recordListViewModelDidFinishInit:)]) {
        [self.delegate recordListViewModelDidFinishInit:self];
    }
}

-(void)reloadData{
    self.records = [self generateData];
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(recordListViewModelDidReloadData:)]) {
        [self.delegate recordListViewModelDidReloadData:self];
    }
}

-(NSArray*)generateData{
    NSError* error = nil;
    NSString* jsonFileName = [NSString stringWithFormat:@"%@",DATA_JSON];
    NSString *filePath = [CommonUtils getFullPath:jsonFileName];
    NSDictionary* dict = [CommonUtils readJSONFile:filePath error:&error];
    NSArray* recordArray;
    
    if(dict!=nil)
    {
        if (error) {
            NSLog(@"loadDummyData failed!");
        }else {
            NSNumber *success = [dict valueForKeyPath:@"success"];
            if ([success boolValue]) {
                
                recordArray = [[dict valueForKeyPath:@"result"] valueForKey:@"records"];
                
            }
        }
    }
    return recordArray;
}

-(NSArray*)getRecords {
    return self.records;
}

-(NSArray*)getRecordsByYear:(NSString *)year {
    NSArray *filtered = [self.records filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"quarter CONTAINS %@", year]];
    return filtered;
}

@end
