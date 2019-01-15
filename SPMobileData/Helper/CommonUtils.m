//
//  CommonUtils.m
//  SPMobileData
//
//  Created by TheinTunAung on 15/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "CommonUtils.h"
#import "GlobalConstants.h"
@implementation CommonUtils

+ (NSString*)getFullPath:(NSString*)path {
    return [[self getResourcePath] stringByAppendingString:path];
}

+ (NSString*)getResourcePath {
    NSString *resouceapp = @"/resources.app/";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths.firstObject stringByAppendingString:resouceapp];
    
    BOOL isDirectory = YES;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError* error = nil;
    if (![fm fileExistsAtPath:basePath isDirectory:&isDirectory]) {
        [fm createDirectoryAtPath:basePath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:&error];
    }
    return basePath;
}

+(id)readJSONFile:(NSString*)filePath error:(NSError**)error{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data==nil) {
        return nil;
    }
    NSError* jsonError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    if (jsonError) {
        *error = jsonError;
    }
    return json;
}

+(void)writeText:(NSString*)text toFileName:(NSString*)fileName append:(BOOL)append{
    NSString *documentsDirectory = [self getResourcePath];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSLog(@"writeText:fileName:, fileName: %@, path: %@, message: %@", fileName, path, text);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(!append || ![fileManager fileExistsAtPath:path])
    {
        NSError* error = nil;
        [text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"writeText failed! error: %@", error);
        }
    }
    else
    {
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myHandle seekToEndOfFile];
        [myHandle writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

+(NSString *) toJsonString:(id)dictionaryOrArrayToOutput {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryOrArrayToOutput
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return nil;
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}
@end
