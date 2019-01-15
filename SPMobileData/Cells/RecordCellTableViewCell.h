//
//  RecordCellTableViewCell.h
//  SPMobileData
//
//  Created by TheinTunAung on 15/1/19.
//  Copyright © 2019 Thein Tun Aung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

typedef enum : NSUInteger {
    CellThemeLight,
    CellThemeDark,
    CellThemeDefault
} CellTheme;

NS_ASSUME_NONNULL_BEGIN
@protocol RecordCellTableViewCellDelegate <NSObject>
@optional
-(void)clickImageAtIndex:(NSIndexPath *)currentIndex;

@end

@interface RecordCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) NSIndexPath *cellIndexPath;
@property(nonatomic, unsafe_unretained) id<RecordCellTableViewCellDelegate> delegate;
-(void)bind:(Record *)data;
-(void)alterCellTheme:(BOOL)alter;

@end

NS_ASSUME_NONNULL_END
