//
//  Record.h
//  SPMobileData
//
//  Created by theintunaung on 11/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Record : NSObject

@property (nonatomic) NSString* _id;
@property (nonatomic) NSString* year;
@property (nonatomic) NSNumber* volume_of_mobile_data;
@property (nonatomic) NSNumber* isDecrease;

@end

NS_ASSUME_NONNULL_END
