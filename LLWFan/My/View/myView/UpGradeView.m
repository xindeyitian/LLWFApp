//
//  UpGradeView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/5.
//

#import "UpGradeView.h"

@interface UpGradeView()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *levelImg, *headerImg;
@property (strong, nonatomic) UILabel        *userName, *upgradeState, *upgradeLevel;

@end

@implementation UpGradeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCusView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCusView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth - 80;
    self.rootLy.myHeight = 220;
    self.rootLy.layer.cornerRadius = 12;
    self.rootLy.layer.masksToBounds = YES;
    self.rootLy.backgroundImage = IMAGE_NAMED(@"fwsBack");
    self.rootLy.contentMode = UIViewContentModeScaleToFill;
    self.rootLy.gravity = MyGravity_Horz_Center;
    [self addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(36, 20, 20, 20);
    contentLy.myTop = 20;
    [self.rootLy addSubview:contentLy];
    
    self.levelImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"")];
    self.levelImg.myWidth = 30;
    self.levelImg.myHeight = 10;
    self.levelImg.backgroundColor = UIColor.grayColor;
    [contentLy addSubview:self.levelImg];
    self.levelImg.layer.zPosition = 1;
    
    self.headerImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.headerImg.myWidth = self.headerImg.myHeight = 50;
    self.headerImg.layer.cornerRadius = 25;
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.myLeft = -30;
    [contentLy addSubview:self.headerImg];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.myHorzMargin = 0;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.myLeft = 20;
    [contentLy addSubview:infoLy];
    
    self.userName = [BaseLabel CreateBaseLabelStr:@"188****8888" Font:[UIFont systemFontOfSize:17] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.userName];
    
    MyLinearLayout *isUpgradeCurLevleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    isUpgradeCurLevleLy.myWidth = MyLayoutSize.wrap;
    isUpgradeCurLevleLy.myHeight = 20;
    isUpgradeCurLevleLy.padding = UIEdgeInsetsMake(5, 0, 5, 10);
    isUpgradeCurLevleLy.layer.cornerRadius = 10;
    isUpgradeCurLevleLy.layer.masksToBounds = YES;
    isUpgradeCurLevleLy.gravity = MyGravity_Vert_Center;
    isUpgradeCurLevleLy.myTop = 8;
    isUpgradeCurLevleLy.subviewHSpace = 5;
    [infoLy addSubview:isUpgradeCurLevleLy];
    isUpgradeCurLevleLy.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake([isUpgradeCurLevleLy sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width, 20) direction:IHGradientChangeDirectionLevel startColor:[UIColor colorWithHexString:@"#424242"] endColor:[UIColor colorWithHexString:@"#131313"]];
    
    UIImageView *star = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"upgradeStar")];
    star.myWidth = star.myHeight = 20;
    [isUpgradeCurLevleLy addSubview:star];
    
    self.upgradeLevel = [BaseLabel CreateBaseLabelStr:@"服务商" Font:[UIFont systemFontOfSize:12] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.upgradeLevel.myWidth = self.upgradeLevel.myHeight = MyLayoutSize.wrap;
    [isUpgradeCurLevleLy addSubview:self.upgradeLevel];
    
    self.upgradeState = [BaseLabel CreateBaseLabelStr:@"已经开通金牌云店" Font:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] Color:[UIColor colorWithHexString:@"#BE7D40"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.upgradeState.myWidth = self.upgradeState.myHeight = MyLayoutSize.wrap;
    self.upgradeState.myTop = 14;
    [infoLy addSubview:self.upgradeState];
    
}
@end
