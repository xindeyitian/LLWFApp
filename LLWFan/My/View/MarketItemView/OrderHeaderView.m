//
//  OrderHeaderView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *marketName, *orderType;
@property (strong, nonatomic) UIView         *nilView;
@property (strong, nonatomic) UIImageView    *wait;

@end

@implementation OrderHeaderView
- (void)setHeaderWithModel:(OrderModel *)model{
    
    self.marketName.text = model.shopName;
    switch (model.orderState) {
        case -100:
        {
            self.orderType.visibility = MyVisibility_Gone;
            self.wait.visibility = MyVisibility_Visible;
        }
            break;
        case 1:
        {
            self.orderType.visibility = MyVisibility_Gone;
            self.wait.visibility = MyVisibility_Visible;
            self.orderType.text = @"待支付";
        }
            break;
        case 2:
        {
            self.orderType.visibility = MyVisibility_Visible;
            self.wait.visibility = MyVisibility_Gone;
            self.orderType.text = @"待发货";
        }
            break;
        case 3:
        {
            self.orderType.visibility = MyVisibility_Visible;
            self.wait.visibility = MyVisibility_Gone;
            self.orderType.text = @"待收货";
        }
            break;
        case 9:
        {
            self.orderType.text = @"交易完成";
            self.wait.visibility = MyVisibility_Gone;
        }
            break;
        case -1:
        {
            self.orderType.text = @"订单取消";
            self.wait.visibility = MyVisibility_Gone;
        }
            break;
        case -2:
        {
            self.orderType.text = @"订单取消";
            self.wait.visibility = MyVisibility_Gone;
        }
            break;
        default:
            break;
    }
}
- (void)setHeaderWithAfterSaleModel:(AfterSaleModel *)model{
    
    self.marketName.text = model.shopName;
    self.orderType.visibility = MyVisibility_Gone;
    self.wait.visibility = MyVisibility_Gone;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
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
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = 48;
    self.contentLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:self.contentLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"dianpu")];
    img.myWidth = img.myHeight = 18;
    [self.contentLy addSubview:img];
    
    self.marketName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.marketName.text = @"三只松鼠官方旗舰店";
    self.marketName.textColor = UIColor.blackColor;
    self.marketName.font = [UIFont systemFontOfSize:15];
    self.marketName.myWidth = MyLayoutSize.wrap;
    self.marketName.myHeight = 24;
    self.marketName.myLeft = 3;
    [self.contentLy addSubview:self.marketName];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right.myWidth = 15;
    right.myHeight = 15;
    right.myLeft = 8;
    [self.contentLy addSubview:right];
    
    self.nilView = [[UIView alloc] initWithFrame:CGRectZero];
    self.nilView.weight = 1;
    self.nilView.myHeight = 48;
    [self.contentLy addSubview:self.nilView];
    
    self.wait = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"等待付款")];
    self.wait.myHeight = 20;
    self.wait.myWidth = 140;
    self.wait.visibility = MyVisibility_Visible;
    [self.contentLy addSubview:self.wait];
    
    self.orderType = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderType.font = [UIFont systemFontOfSize:12];
    self.orderType.textColor = color_9;
    self.orderType.text = @"已完成";
    self.orderType.myWidth = self.orderType.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:self.orderType];
    
}
@end
