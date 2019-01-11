//
//  ViewController.m
//  SPMobileData
//
//  Created by TheinTunAung on 10/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
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
            }];
        }

    }];
}


@end
