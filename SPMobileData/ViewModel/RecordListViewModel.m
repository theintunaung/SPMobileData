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
#import "Record.h"

@implementation RecordListViewModel

//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        self.records = [NSArray array];
//        [self reloadData];
//    }
//    return self;
//}

-(instancetype)initWithDelegate:(id)delegate{
    self = [super init];
    if (self) {
        self.records = [NSArray array];
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
    NSMutableArray* resultArray = [NSMutableArray array];
    if(dict!=nil)
    {
        if (error) {
            NSLog(@"loadDummyData failed!");
        }else {
            NSNumber *success = [dict valueForKeyPath:@"success"];
            if ([success boolValue]) {
                
                recordArray = [[dict valueForKeyPath:@"result"] valueForKey:@"records"];
                
                NSArray *years = [self getDataForYears];
                for (NSString *aYear in years) {
                    NSArray *results =[recordArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"quarter CONTAINS %@", aYear]];
                    
                    
                    Record *aRecord = [[Record alloc] init];
                    aRecord.year = aYear;
                    float mobileData = 0;
                    float totalMobileData = 0;
                    BOOL isDecreasing = NO;
                    NSString *previousQuarter;
                    NSString *currentQuarter;
                    
                    
                    for (NSDictionary *aDic in results) {
                        NSString *quarterlyData = [aDic valueForKey:@"volume_of_mobile_data"];
                        currentQuarter = [aDic valueForKey:@"quarter"];
                        float quarterlyDataLong = [quarterlyData floatValue];
                        if (mobileData > quarterlyDataLong ) {
                            aRecord.decreaseMsg = [NSString stringWithFormat:@"%f (%@) To %@ (%@) \n",mobileData,previousQuarter,quarterlyData,currentQuarter];
                            if (!isDecreasing) {
                                isDecreasing = YES;
                            }
                            
                        }
                        mobileData = quarterlyDataLong;
                        totalMobileData += quarterlyDataLong;
                        previousQuarter = currentQuarter;
                    }
                    aRecord.isDecrease = [NSNumber numberWithBool:isDecreasing];
                    aRecord.volume_of_mobile_data = [NSNumber numberWithFloat:totalMobileData];
                    [resultArray addObject:aRecord];
                }
                
                
                
            }
        }
    }
    return resultArray;
}

-(NSArray*)getDataForYears{
    return @[@"2018",@"2017",@"2016",@"2015",@"2014"];
}

@end
