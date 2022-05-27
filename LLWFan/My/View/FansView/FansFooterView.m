//
//  FansFooterView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "FansFooterView.h"

@interface FansFooterView()

@property (strong, nonatomic) MyLinearLayout *rootLy;

@end

@implementation FansFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        //    添加刷新标记
        [self setNeedsLayout];
        //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
        [self layoutIfNeeded];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.rootLy.bounds   byRoundingCorners:UIRectCornerBottomLeft   |   UIRectCornerBottomRight    cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.rootLy.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.rootLy.layer.mask = maskLayer1;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = 12;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.rootLy];
    
}

@end
