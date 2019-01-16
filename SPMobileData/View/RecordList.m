//
//  RecordList.m
//  SPMobileData
//
//  Created by theintunaung on 11/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "RecordList.h"
#import "RecordCellTableViewCell.h"
#import "Record.h"


@interface RecordList () < RecordListViewModelDelegate, UITableViewDelegate, UITableViewDataSource,RecordCellTableViewCellDelegate >{
}
@property (strong, nonatomic) RecordListViewModel *recordListViewModel;

@property (strong, nonatomic) NSArray* records;
@end

@implementation RecordList

-(void)awakeFromNib {
    [super awakeFromNib];
    self.records = [[NSArray alloc]init];
    self.recordListViewModel = [[RecordListViewModel alloc]initWithDelegate:self];

    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadData];
        [self configureViews];
    }
    return self;
}

-(void)reloadData {
     [self configureViews];
}
-(void)configureViews {
    
    self.tableView = [self makeTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordCellTableViewCell" bundle:nil] forCellReuseIdentifier:RECORD_DETAIL];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    
}

-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width,height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.records count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        RecordCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:RECORD_DETAIL];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellIndexPath = indexPath;
        Record *aRecord = self.records[indexPath.row];
        [cell bind:aRecord];
        [cell alterCellTheme:(indexPath.row%2==0)];
        return cell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECORD_DETAIL];
//    cell.textLabel.text = @"Text";
//    cell.detailTextLabel.text = @"secondaryTitleKey";

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    ExpandableCellData* cellData = self.comparisonData[indexPath.section];
    //    NSArray<CellData*>* sectionData = cellData.sectionData[indexPath.row];
    //    return [CompareDetailCell2 calculateCellHeight:sectionData tableWidth:WIDTH(tableView)];
    RecordCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:RECORD_DETAIL];
    return cell.frame.size.height;
}

#pragma mark - RecordListViewModelDelegate
- (void)recordListViewModelDidFinishInit:(RecordListViewModel *)compareViewModel {
    self.records = compareViewModel.records;
    [self.tableView reloadData];
}
    


- (void)recordListViewModelDidReloadData:(RecordListViewModel *)compareViewModel {
   self.records = compareViewModel.records;
    [self.tableView reloadData];
}

#pragma mark - RecordCellTableViewCellDelegate
-(void)clickImageAtIndex:(NSIndexPath *)currentIndex{
    NSLog(@"clickImageAtIndex: %ld",(long)currentIndex.row );
    Record *aRecord = [self.records objectAtIndex:currentIndex.row];
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(clickImageWithRecord:)]) {
        [self.delegate clickImageWithRecord:aRecord];
    }
}



@end

