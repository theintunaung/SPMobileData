//
//  CommonUtils.h
//  SPMobileData
//
//  Created by TheinTunAung on 15/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtils : NSObject

+(NSString*)getFullPath:(NSString*)path;
+(id)readJSONFile:(NSString*)filePath error:(NSError**)error;
+(void)writeText:(NSString*)text toFileName:(NSString*)fileName append:(BOOL)append;
+(NSString *)toJsonString:(id)dictionaryOrArrayToOutput;

@end

NS_ASSUME_NONNULL_END
