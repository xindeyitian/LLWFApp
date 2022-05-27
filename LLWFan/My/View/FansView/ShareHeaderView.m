//
//  ShareHeaderView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/6.
//

#import "ShareHeaderView.h"

@interface ShareHeaderView()

@property (strong, nonatomic) UIImageView    *userImage;
@property (strong, nonatomic) UILabel        *userName, *time;
@property (strong, nonatomic) MyLinearLayout *contentLy;

@end

@implementation ShareHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initHeaderView];
        
        //    添加刷新标记
        [self setNeedsLayout];
        //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
        [self layoutIfNeeded];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.contentLy.bounds   byRoundingCorners:UIRectCornerTopLeft   |   UIRectCornerTopRight    cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.contentLy.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.contentLy.layer.mask = maskLayer1;
    }
    return self;
}
- (void)initHeaderView{
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myWidth = ScreenWidth;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.backgroundImage = IMAGE_NAMED(@"shareHeaderImg");
    [self addSubview:rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 12;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    self.contentLy.subviewVSpace = 8;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:self.contentLy];
    
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = MyLayoutSize.wrap;
    titleLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:titleLy];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"shareLine")];
    line.myWidth = 11;
    line.myHeight = 22;
    [titleLy addSubview:line];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"邀请记录" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [titleLy addSubview:title];
    
    MyLinearLayout *firstPersonLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    firstPersonLy.myHorzMargin = 0;
    firstPersonLy.myHeight = MyLayoutSize.wrap;
    firstPersonLy.gravity = MyGravity_Vert_Center;
    firstPersonLy.subviewHSpace = 12;
    [self.contentLy addSubview:firstPersonLy];
    
    self.userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.userImage.myWidth = self.userImage.myHeight = 28;
    self.userImage.layer.cornerRadius = 14;
    self.userImage.layer.masksToBounds = YES;
    [self.userImage setImage:IMAGE_NAMED(@"img")];
    [firstPersonLy addSubview:self.userImage];
    
    self.userName = [BaseLabel CreateBaseLabelStr:@"188****8888" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
    [firstPersonLy addSubview:self.userName];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [firstPersonLy addSubview:nilView];
    
    self.time = [BaseLabel CreateBaseLabelStr:@"1990-04-04  08:20" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [firstPersonLy addSubview:self.time];
}
@end
