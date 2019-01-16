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

@interface ViewController () <RecordListDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordList.delegate = self;
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
-(void)clickImageWithRecord:(Record *)currentRecord{
   
    
    NSString *msg = [NSString stringWithFormat:@"%@ \n %@",currentRecord.year,currentRecord.decreaseMsg];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:DECREASE_TITLE message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //button click event
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    

}
@end
