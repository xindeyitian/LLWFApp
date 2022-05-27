//
//  AfterSaleCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "AfterSaleCell.h"

@interface AfterSaleCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *status, *tuikuanPrice;

@end

@implementation AfterSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 12;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.subviewVSpace = 8;
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.contentLy.subviewVSpace = 12;
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *statusLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    statusLy.myHorzMargin = 0;
    statusLy.myHeight = MyLayoutSize.wrap;
    statusLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:statusLy];
    
    UILabel *statusLable = [BaseLabel CreateBaseLabelStr:@"售后状态" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    statusLable.weight = 1;
    statusLable.myHeight = MyLayoutSize.wrap;
    [statusLy addSubview:statusLable];
    
    self.status = [BaseLabel CreateBaseLabelStr:@"已退运费" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.status.myWidth = self.status.myHeight = MyLayoutSize.wrap;
    [statusLy addSubview:self.status];
    
    MyLinearLayout *tuikuanLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    tuikuanLy.myHorzMargin = 0;
    tuikuanLy.myHeight = MyLayoutSize.wrap;
    tuikuanLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:tuikuanLy];
    
    UILabel *tuikuanLable = [BaseLabel CreateBaseLabelStr:@"退款金额" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    tuikuanLable.weight = 1;
    tuikuanLable.myHeight = MyLayoutSize.wrap;
    [tuikuanLy addSubview:tuikuanLable];
    
    self.tuikuanPrice = [BaseLabel CreateBaseLabelStr:@"¥94.89" Font:[UIFont systemFontOfSize:15] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.tuikuanPrice.myWidth = self.tuikuanPrice.myHeight = MyLayoutSize.wrap;
    [tuikuanLy addSubview:self.tuikuanPrice];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
