//
//  AddressCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/16.
//

#import "AddressCell.h"
#import "AddAddressViewController.h"

@interface AddressCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UIButton       *chooseBtn, *editBtn;
@property (strong, nonatomic) UILabel        *addressType, *addressName, *addressDetail, *userInfo;
@property (strong, nonatomic) AddressModel   *addressModel;

@end

@implementation AddressCell
- (void)editCustomAddress{
    
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    vc.addressModel = self.addressModel;
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)setCellWithModel:(AddressModel *)model{
    
    self.addressModel = model;
    if (model.ifDefault) {
        
        self.addressType.visibility = MyVisibility_Visible;
    }else{
        
        self.addressType.visibility = MyVisibility_Gone;
    }
    self.addressName.text = NSStringFormat(@"%@%@%@",model.provinceName,model.cityName,model.areaName);
    self.addressDetail.text = model.address;
    self.userInfo.text = NSStringFormat(@"%@ %@",model.realName,model.phoneNum);
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    [self.contentView addSubview:self.rootLy];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#E5E5E5"] thick:0.5];
    self.rootLy.bottomBorderline = line;
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.contentLy.subviewHSpace = 12;
    [self.rootLy addSubview:self.contentLy];
//    
//    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseBtnClicked) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
//    self.chooseBtn.myWidth = MyLayoutSize.wrap;
//    self.chooseBtn.myVertMargin = 0;
//    [self.contentLy addSubview:self.chooseBtn];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.subviewVSpace = 8;
    [self.contentLy addSubview:infoLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.gravity = MyGravity_Vert_Center;
    topLy.subviewHSpace = 8;
    [infoLy addSubview:topLy];
    
    self.addressType = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressType.myWidth = 38;
    self.addressType.myHeight = 16;
    self.addressType.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.addressType.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.addressType.font = [UIFont systemFontOfSize:11];
    self.addressType.textAlignment = NSTextAlignmentCenter;
    self.addressType.layer.cornerRadius = 2;
    self.addressType.layer.masksToBounds = YES;
    self.addressType.text = @"默认";
    [topLy addSubview:self.addressType];
    
    self.addressName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressName.font = [UIFont systemFontOfSize:13];
    self.addressName.textColor = color_3;
    self.addressName.text = @"浙江省杭州市余杭区仓前街道";
    self.addressName.weight = 1;
    self.addressName.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:self.addressName];
    
    self.addressDetail = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressDetail.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.addressDetail.textColor = color_3;
    self.addressDetail.text = @"利尔达物联网科技园6幢405室";
    self.addressDetail.myHorzMargin = 0;
    self.addressDetail.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.addressDetail];
    
    self.userInfo = [[UILabel alloc] initWithFrame:CGRectZero];
    self.userInfo.font = [UIFont systemFontOfSize:13];
    self.userInfo.textColor = color_3;
    self.userInfo.text = @"雍先生 188****5510";
    self.userInfo.myHorzMargin = 0;
    self.userInfo.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.userInfo];
    
    self.editBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(editCustomAddress) Font:[UIFont systemFontOfSize:12] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"bianji" HeightLightBackgroundImage:@"bianji"];
    self.editBtn.myWidth = 16;
    self.editBtn.myVertMargin = 0;
    [self.contentLy addSubview:self.editBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
