//
//  AddressTopCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "AddressTopCell.h"
#import "AddressListViewController.h"

@interface AddressTopCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel        *addressType, *address, *addressDetail, *userInfo;

@end

@implementation AddressTopCell
- (void)setCellWithAddressArr:(NSArray *)arr{
    
    if (arr.count) {
        
        for (AddressModel *model in arr) {
            
            if (model.ifDefault) {
        
                self.addressType.visibility = MyVisibility_Visible;
                
                self.address.text = NSStringFormat(@"%@%@%@",model.provinceName,model.cityName,model.areaName);
                self.addressDetail.text = model.address;
                self.userInfo.text = NSStringFormat(@"%@ %@",model.realName,model.phoneNum);
                if (self.returnAddressModelBlock) {
                    
                    self.returnAddressModelBlock(model);
                }
            }else{
                
                self.address.visibility = MyVisibility_Gone;
                self.addressType.visibility = MyVisibility_Gone;
                self.userInfo.visibility = MyVisibility_Gone;
                self.addressDetail.text = @"请点击选择收货地址";
            }
        }
    }else{
        
        self.address.visibility = MyVisibility_Gone;
        self.addressType.visibility = MyVisibility_Gone;
        self.userInfo.visibility = MyVisibility_Gone;
        self.addressDetail.text = @"请点击选择收货地址";
    }
}
- (void)chooseAddress{
    
    AddressListViewController *vc = [[AddressListViewController alloc] init];
    vc.chosedAddressBlock = ^(AddressModel * _Nonnull model) {
        
        if (model.ifDefault) {
            
            self.addressType.visibility = MyVisibility_Visible;
        }else{
            
            self.addressType.visibility = MyVisibility_Gone;
        }
        
        self.address.text = NSStringFormat(@"%@%@%@",model.provinceName,model.cityName,model.areaName);
        self.addressDetail.text = model.address;
        self.userInfo.text = NSStringFormat(@"%@ %@",model.realName,model.phoneNum);
        if (self.returnAddressModelBlock) {
            
            self.returnAddressModelBlock(model);
        }
    };
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    UITapGestureRecognizer *chooseAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAddress)];
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.subviewVSpace = 8;
    [self.rootLy addGestureRecognizer:chooseAddress];
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.gravity = MyGravity_Vert_Center;
    topLy.subviewHSpace = 8;
    topLy.myTop = 12;
    topLy.myLeft = 24;
    topLy.myRight = 12;
    [self.rootLy addSubview:topLy];
    
    
    self.addressType = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressType.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.addressType.myWidth = 40;
    self.addressType.myHeight = 16;
    self.addressType.font = [UIFont systemFontOfSize:11];
    self.addressType.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.addressType.textAlignment = NSTextAlignmentCenter;
    self.addressType.text = @"默认";
    [topLy addSubview:self.addressType];
    
    self.address = [[UILabel alloc] initWithFrame:CGRectZero];
    self.address.font = [UIFont systemFontOfSize:13];
    self.address.textColor = color_3;
    self.address.text = @"";
    self.address.weight = 1;
    self.address.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:self.address];
    
    MyLinearLayout *midLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    midLy.myHorzMargin = 0;
    midLy.myHeight = MyLayoutSize.wrap;
    midLy.gravity = MyGravity_Vert_Center;
    midLy.subviewHSpace = 8;
    midLy.myLeft = 24;
    midLy.myRight = 12;
    [self.rootLy addSubview:midLy];
    
    self.addressDetail = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressDetail.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.addressDetail.textColor = color_3;
    self.addressDetail.text = @"";
    self.addressDetail.weight = 1;
    self.addressDetail.myHeight = MyLayoutSize.wrap;
    [midLy addSubview:self.addressDetail];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right.myWidth = 13;
    right.myHeight = 13;
    [midLy addSubview:right];
    
    self.userInfo = [[UILabel alloc] initWithFrame:CGRectZero];
    self.userInfo.font = [UIFont systemFontOfSize:13];
    self.userInfo.textColor = color_3;
    self.userInfo.text = @"";
    self.userInfo.myHorzMargin = 0;
    self.userInfo.myHeight = MyLayoutSize.wrap;
    self.userInfo.myLeft = 24;
    self.userInfo.myRight = 12;
    [self.rootLy addSubview:self.userInfo];
    
    UIImageView *bottomImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"addressBottom")];
    bottomImg.myHorzMargin = 0;
    bottomImg.myHeight = 3;
    [self.rootLy addSubview:bottomImg];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
