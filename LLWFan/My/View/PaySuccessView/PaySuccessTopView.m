//
//  PaySuccessTopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/18.
//

#import "PaySuccessTopView.h"

@interface PaySuccessTopView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;

@end

@implementation PaySuccessTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Horz_Center;
    self.contentLy.padding = UIEdgeInsetsMake(32, 0, 12, 0);
    [self.rootLy addSubview:self.contentLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    img.myWidth = img.myHeight = 65;
    [self.contentLy addSubview:img];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"订单支付成功！";
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = color_3;
    lable.myWidth = lable.myHeight = MyLayoutSize.wrap;
    lable.myTop = 16;
    [self.contentLy addSubview:lable];
    
    UILabel *check = [[UILabel alloc] initWithFrame:CGRectZero];
    check.font = [UIFont systemFontOfSize:12];
    check.textColor = color_9;
    check.text = @"您可以在我的-我的订单中查看";
    check.myWidth = check.myHeight = MyLayoutSize.wrap;
    check.myTop = 4;
    [self.contentLy addSubview:check];
    
    MyLinearLayout *imgLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    imgLy.myHeight = 40;
    imgLy.myHorzMargin = 0;
    imgLy.gravity = MyGravity_Center;
    imgLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.rootLy addSubview:imgLy];
    
    UIImageView *tuijian = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"tuijian")];
    tuijian.myWidth = tuijian.myHeight = MyLayoutSize.wrap;
    [imgLy addSubview:tuijian];
    
}
@end
