//
//  AfterSaleMerchantOperationCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/29.
//

#import "AfterSaleMerchantOperationCell.h"

@interface AfterSaleMerchantOperationCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *remarkLy;
@property (strong, nonatomic) UILabel        *operationTime, *operationResult, *remark;

@end

@implementation AfterSaleMerchantOperationCell
- (void)initCellWithModel:(AfterSaleDetailModel *)model{
    
//    self.operationTime.text = model.
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.subviewVSpace = 12;
    contentLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:contentLy];
    
    UILabel *merchantOperationTitle = [BaseLabel CreateBaseLabelStr:@"商家处理" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    merchantOperationTitle.myWidth = merchantOperationTitle.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:merchantOperationTitle];
    
    MyLinearLayout *operationTimeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    operationTimeLy.myHorzMargin = 0;
    operationTimeLy.myHeight = MyLayoutSize.wrap;
    operationTimeLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:operationTimeLy];
    
    UILabel *operationTimeLable = [BaseLabel CreateBaseLabelStr:@"操作时间" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    operationTimeLable.weight = 1;
    operationTimeLable.myHeight = MyLayoutSize.wrap;
    [operationTimeLy addSubview:operationTimeLable];
    
    self.operationTime = [BaseLabel CreateBaseLabelStr:@"2022-04-29" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.operationTime.myWidth = self.operationTime.myHeight = MyLayoutSize.wrap;
    [operationTimeLy addSubview:self.operationTime];
    
    MyLinearLayout *operationResultLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    operationResultLy.myHorzMargin = 0;
    operationResultLy.myHeight = MyLayoutSize.wrap;
    operationResultLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:operationResultLy];
    
    UILabel *operationResultLable = [BaseLabel CreateBaseLabelStr:@"处理结果" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    operationResultLable.weight = 1;
    operationResultLable.myHeight = MyLayoutSize.wrap;
    [operationResultLy addSubview:operationResultLable];
    
    self.operationResult = [BaseLabel CreateBaseLabelStr:@"已同意" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.operationResult.myWidth = self.operationResult.myHeight = MyLayoutSize.wrap;
    [operationResultLy addSubview:self.operationResult];
    
    self.remarkLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.remarkLy.myHorzMargin = 0;
    self.remarkLy.myHeight = MyLayoutSize.wrap;
    self.remarkLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:self.remarkLy];
    
    UILabel *remarkLable = [BaseLabel CreateBaseLabelStr:@"备注" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    remarkLable.weight = 1;
    remarkLable.myHeight = MyLayoutSize.wrap;
    [self.remarkLy addSubview:remarkLable];
    
    self.remark = [BaseLabel CreateBaseLabelStr:@"系产品质量问题，同意退货退款" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentRight Tag:0];
    self.remark.myWidth = self.remark.myHeight = MyLayoutSize.wrap;
    [self.remarkLy addSubview:self.remark];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
