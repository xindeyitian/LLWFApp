//
//  YLJHeaderView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "YLJHeaderView.h"
#import "FiltratePopView.h"

@interface YLJHeaderView()<FiltratePopViewDelegate>

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) DKSButton      *chooseMonthBtn, *filtrateBtn;
@property (strong, nonatomic) UILabel        *earningLable;
@property (strong, nonatomic) LSTPopView     *popView;

@end

@implementation YLJHeaderView

- (void)chooseMonth{
    
    BRDatePickerView *pickView = [[BRDatePickerView alloc] initWithPickerMode:BRDatePickerModeYM];
    pickView.resultBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        
    };
    [pickView show];

}
- (void)filtrateData{
    
    FiltratePopView *pop = [[FiltratePopView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 480, ScreenWidth, 480)];
    pop.delegate = self;
    
    self.popView = [LSTPopView initWithCustomView:pop popStyle:LSTPopStyleSmoothFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    self.popView.hemStyle = LSTHemStyleBottom;
    self.popView.popDuration = 0.25;
    self.popView.dismissDuration = 0.25;
    self.popView.isClickFeedback = YES;
    self.popView.bgColor = [UIColor colorWithHexString:@"#000000" alpha:0.55];
    weakSelf(self.popView)
    self.popView.bgClickBlock = ^{
        
        [weakSelf dismiss];
    };
    
    [self.popView pop];
}
- (void)sureChoose{
    
    [self.popView dismiss];
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCustomView];
//        //    添加刷新标记
        [self setNeedsLayout];
//        //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
        [self layoutIfNeeded];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.contentLy.bounds   byRoundingCorners:UIRectCornerTopLeft   |   UIRectCornerTopRight    cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.contentLy.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.contentLy.layer.mask = maskLayer1;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.paddingTop = 12;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 12;
    self.contentLy.myHeight = 100;
    self.contentLy.padding = UIEdgeInsetsMake(12, 8, 10, 8);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Center;
    self.contentLy.subviewVSpace = 4;
    [self.rootLy addSubview:self.contentLy];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"weinituijian")];
    image.myWidth = 100;
    image.myHeight = 25;
    [self.contentLy addSubview:image];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:topLy];
    
    self.chooseMonthBtn = [[DKSButton alloc] init];
    self.chooseMonthBtn.buttonStyle = DKSButtonImageRight;
    self.chooseMonthBtn.padding = 4;
    self.chooseMonthBtn.myWidth = 80;
    self.chooseMonthBtn.myHeight = 30;
    [self.chooseMonthBtn setTitle:@"10月" forState:UIControlStateNormal];
    [self.chooseMonthBtn setTitleColor:[UIColor colorWithHexString:@"222222"] forState:UIControlStateNormal];
    self.chooseMonthBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.chooseMonthBtn setImage:IMAGE_NAMED(@"xiajiantou") forState:UIControlStateNormal];
    [self.chooseMonthBtn addTarget:self action:@selector(chooseMonth) forControlEvents:UIControlEventTouchUpInside];
    [topLy addSubview:self.chooseMonthBtn];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.chooseMonthBtn.titleLabel.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] range:NSMakeRange(self.chooseMonthBtn.titleLabel.text.length - 1, 1)];
    self.chooseMonthBtn.titleLabel.attributedText = attr;
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [topLy addSubview:nilView];
    
    self.filtrateBtn = [[DKSButton alloc] initWithFrame:CGRectZero];
    self.filtrateBtn.buttonStyle = DKSButtonImageRight;
    self.filtrateBtn.padding = 4;
    self.filtrateBtn.myWidth = MyLayoutSize.wrap;
    self.filtrateBtn.myHeight = 30;
    [self.filtrateBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self.filtrateBtn setTitleColor:color_3 forState:UIControlStateNormal];
    self.filtrateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.filtrateBtn setImage:IMAGE_NAMED(@"shaixuan") forState:UIControlStateNormal];
    [self.filtrateBtn addTarget:self action:@selector(filtrateData) forControlEvents:UIControlEventTouchUpInside];
    [topLy addSubview:self.filtrateBtn];
    
    self.earningLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.earningLable.font = [UIFont systemFontOfSize:12];
    self.earningLable.textColor = color_3;
    self.earningLable.text = @"收入¥100,000.00 支出¥98,000.00";
    self.earningLable.myHorzMargin = 0;
    self.earningLable.myHeight = MyLayoutSize.wrap;
    self.earningLable.myLeft = 4;
    self.earningLable.textAlignment = NSTextAlignmentLeft;
    [self.contentLy addSubview:self.earningLable];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
