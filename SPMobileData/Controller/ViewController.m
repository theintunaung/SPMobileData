//
//  ViewController.m
//  SPMobileData
//
//  Created by TheinTunAung on 10/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "GlobalConstants.h"
#import "CommonUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NetworkManager getDatastoreonCompletion:^(BOOL success, id JSON) {
        NSLog(@"message %@",JSON);

        if (success){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSNumber *page = [JSON objectForKey:@"page"];
//                self.downloadedPageFor2018 = [page integerValue];
                if (JSON!=nil) {
                    [CommonUtils writeText:[CommonUtils toJsonString:JSON] toFileName:DATA_JSON append:NO];
                    [self reloadData];
                }
                
            }];
        }

    }];
}

-(void)reloadData {
    [self.recordList reloadData];
}
#pragma mark - RecordListDelegate
-(void)clickImageAtIndex:(NSIndexPath *)currentIndex{
    NSLog(@"From VC clickImageAtIndex: %ld",(long)currentIndex.row );

}
@end
