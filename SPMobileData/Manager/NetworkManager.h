//
//  NetworkManager.h
//  Movies
//
//  Created by TheinTunAung on 10/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject


+ (void) getDatastoreonCompletion:(void (^)(BOOL success, id JSON))completion;
@end

NS_ASSUME_NONNULL_END
