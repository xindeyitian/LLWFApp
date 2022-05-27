//
//  orderDetailAddressCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "orderDetailAddressCell.h"

@interface orderDetailAddressCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *userName, *userPhone, *address;

@end

@implementation orderDetailAddressCell
- (void)setCellWithModel:(OrderModel *)model{
    
    self.userName.text = model.deliveryRealName;
    self.userPhone.text = model.deliveryPhoneNum;
    self.address.text = model.deliveryAddress;
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
    self.contentLy.layer.cornerRadius = 12;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *userAddressLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    userAddressLy.myHorzMargin = 0;
    userAddressLy.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:userAddressLy];
    
    MyLinearLayout *userLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    userLy.myHorzMargin = 0;
    userLy.myHeight = MyLayoutSize.wrap;
    userLy.subviewHSpace = 4;
    [userAddressLy addSubview:userLy];
    
    UIImageView *dingweiImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"userAddress")];
    dingweiImg.myWidth = dingweiImg.myHeight = 16;
    [userLy addSubview:dingweiImg];
    
    self.userName = [BaseLabel CreateBaseLabelStr:@"何先生" Font:[UIFont systemFontOfSize:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
    [userLy addSubview:self.userName];
    
    self.userPhone = [BaseLabel CreateBaseLabelStr:@"186****5795" Font:[UIFont fontWithName:@"DIN-Medium" size:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userPhone.myWidth = self.userPhone.myHeight = MyLayoutSize.wrap;
    [userLy addSubview:self.userPhone];
    
    self.address = [BaseLabel CreateBaseLabelStr:@"地址：浙江省杭州市余杭区仓前街道利尔达物联网科技园6幢406室" Font:[UIFont systemFontOfSize:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.address.numberOfLines = 0;
    self.address.myHorzMargin = 0;
    self.address.myHeight = MyLayoutSize.wrap;
    [userAddressLy addSubview:self.address];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
