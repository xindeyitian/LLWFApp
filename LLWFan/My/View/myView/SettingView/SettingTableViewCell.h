//
//  SettingTableViewCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    INFO,//用户信息
    NORMAL,//单行文字 带箭头
    LINE,//两行文字 带箭头
    RIGHT,//右侧带文字
    RIGHTTEXT//右侧文字 无箭头
} CellType;

@interface SettingTableViewCell : ThBaseTableViewCell

- (void)setCellWithType:(CellType )type;

@property (copy, nonatomic) NSString *normalTitle;
@property (copy, nonatomic) NSString *secondTitle;
@property (copy, nonatomic) NSString *rightTitle;

@end

NS_ASSUME_NONNULL_END
