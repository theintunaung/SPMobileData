//
//  RecordCellTableViewCell.m
//  SPMobileData
//
//  Created by TheinTunAung on 15/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import "RecordCellTableViewCell.h"

@implementation RecordCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bind:(Record *)data{
    
    self.label1.text = data.year;
    self.label2.text = [NSString stringWithFormat:@"%@",data.volume_of_mobile_data];
    if ([data.isDecrease boolValue]) {
        self.image.hidden = NO;
    }else {
        self.image.hidden = YES;
    }
}

-(void)alterCellTheme:(BOOL)alter{
    if (alter) {
        [self setCellTheme:CellThemeDark];
    }else{
        [self setCellTheme:CellThemeDefault];
    }
}

#pragma mark - Private Methods
-(void)setCellTheme:(CellTheme)theme{
    switch (theme) {
        case CellThemeDark:
            [self setCellThemeDark];
            break;
        default:
            [self setCellThemeLight];
            break;
    }
}

-(void)setCellThemeDark{
    self.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
}

-(void)setCellThemeLight{
    self.backgroundColor = [UIColor whiteColor];
}

- (IBAction)didClickedImage {
    NSLog(@"didClickedImage");

    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(clickImageAtIndex:)]) {
        [self.delegate clickImageAtIndex:self.cellIndexPath];
    }
}

@end
