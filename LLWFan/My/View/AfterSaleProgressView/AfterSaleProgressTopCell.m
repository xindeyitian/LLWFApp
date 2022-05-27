//
//  AfterSaleProgressTopCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/1.
//

#import "AfterSaleProgressTopCell.h"

@interface AfterSaleProgressTopCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *progressLy, *lableLy;
@property (strong, nonatomic) NSMutableArray<UILabel *> *roundArr, *lableArr;

@end

@implementation AfterSaleProgressTopCell
- (void)initCellWithModel:(AfterSaleDetailModel *)model{
    
    [self.progressLy removeAllSubviews];
    [self.lableLy removeAllSubviews];
    //处理状态（1 等待商家同意、2等待揽件、3等待退款、4待商家确认收货、9退货完成、-1退货失败、-2客户取消、-3商家取消）
    self.roundArr = @[].mutableCopy;
    for (int i = 0; i < (model.applyType == 1 ? 3 : 5) ; i++) {
        
        UILabel *round = [[UILabel alloc] initWithFrame:CGRectZero];
        round.myWidth = round.myHeight = 12;
        round.layer.cornerRadius = 6;
        round.layer.masksToBounds = YES;
        round.layer.borderColor = [UIColor colorNamed:@"color-red"].CGColor;
        round.layer.borderWidth = 0.5;
        round.backgroundColor = UIColor.whiteColor;
        [self.roundArr addObject:round];
        [self.progressLy addSubview:round];
    }
    
    NSArray *threeTitleArr = @[@"发起申请",@"商家确认",@"售后完成"];
    NSArray *fiveTitleArr = @[@"发起申请",@"商家确认",@"售后完成",@"商家收货",@"售后完成"];
    self.lableArr = @[].mutableCopy;
    for (int i = 0; i < (model.applyType == 1 ? 3 : 5); i++) {
        
        UILabel *round = [[UILabel alloc] initWithFrame:CGRectZero];
        round.myWidth = round.myHeight = MyLayoutSize.wrap;
        round.layer.cornerRadius = 6;
        round.layer.masksToBounds = YES;
        round.textColor = color_3;
        if (model.applyType == 1) {
            
            round.text = threeTitleArr[i];
        }else{
            
            round.text = fiveTitleArr[i];
        }
        round.font = [UIFont systemFontOfSize:13];
        [self.lableArr addObject:round];
        [self.lableLy addSubview:round];
    }
    
    if (model.applyType == 1) {
        
        switch (model.dealSign) {
            case 1:
            {
                [self setLableStatus:0];
            }
                break;
            case 3:
            {
                [self setLableStatus:1];
            }
                break;
            case 9:
            {
                [self setLableStatus:2];
            }
                break;
            default:
                break;
        }
    }else{
        
        switch (model.dealSign) {
            case 1:
            {
                [self setLableStatus:0];
            }
                break;
            case 2:
            {
                [self setLableStatus:1];
            }
                break;
            case 3:
            {
                [self setLableStatus:2];
            }
                break;
            case 4:
            {
                [self setLableStatus:3];
            }
                break;
            case 9:
            {
                [self setLableStatus:4];
            }
                break;
            default:
                break;
        }
    }
}
- (void)setLableStatus:(NSInteger )type{
    
    [self.roundArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
        if (idx <= type) {
            obj.backgroundColor = [UIColor colorNamed:@"color-red"];
        }
    }];
    [self.lableArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx <= type) {
            obj.textColor = [UIColor colorNamed:@"color-red"];
        }
    }];
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
    
    UILabel *progress = [BaseLabel CreateBaseLabelStr:@"售后进度" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    progress.myWidth = progress.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:progress];
    
    self.progressLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.progressLy.myHorzMargin = 20;
    self.progressLy.myHeight = MyLayoutSize.wrap;
    self.progressLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Between;
    self.progressLy.myTop = 20;
    self.progressLy.backgroundImage = IMAGE_NAMED(@"line");
    [contentLy addSubview:self.progressLy];
    
    self.lableLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.lableLy.myHorzMargin = 0;
    self.lableLy.myHeight = MyLayoutSize.wrap;
    self.lableLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Between;
    self.lableLy.myTop = 12;
    [contentLy addSubview:self.lableLy];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
