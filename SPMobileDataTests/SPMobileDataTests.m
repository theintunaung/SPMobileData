//
//  SPMobileDataTests.m
//  SPMobileDataTests
//
//  Created by TheinTunAung on 10/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "RecordList.h"
#import "GlobalConstants.h"
@interface SPMobileDataTests : XCTestCase {
@private
    UIApplication   *app;
    AppDelegate     *appDelegate;
    
    
}
@property (nonatomic, strong) ViewController *viewController;
@property (nonatomic, strong) RecordList     *recordList;
@end

@implementation SPMobileDataTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    app = [UIApplication sharedApplication];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.viewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    self.recordList = self.viewController.recordList;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
    }];
}

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.viewController.recordList, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.viewController.view.subviews;
    XCTAssertTrue([subviews containsObject:self.viewController.recordList], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.viewController.recordList, @"TableView not initiated");
}


#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.viewController.recordList conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}


- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.viewController.recordList conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}


- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    [self.recordList reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.recordList tableView:self.recordList.tableView cellForRowAtIndexPath:indexPath];
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:RECORD_DETAIL], @"Table does not create reusable cells");
    
   
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 5;
    XCTAssertTrue([self.recordList tableView:self.recordList.tableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.recordList  tableView:self.recordList.tableView numberOfRowsInSection:0], (long)expectedRows);
}
@end

