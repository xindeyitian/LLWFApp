//
//  SettingTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *userImage;
@property (strong, nonatomic) UILabel        *userName, *normalLable, *secondLable, *rightLable;

@end

@implementation SettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        self.rootLy.myWidth = ScreenWidth;
        self.rootLy.myHeight = MyLayoutSize.wrap;
        self.rootLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
        self.rootLy.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.rootLy];
        
        
        MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5 headIndent:12 tailIndent:12];
        self.rootLy.bottomBorderline = line;
    }
    return self;
}
- (void)setCellWithType:(CellType )type{
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.gravity = MyGravity_Vert_Center;
    contentLy.subviewHSpace = 8;
    [self.rootLy addSubview:contentLy];
    
    switch (type) {
        case INFO:
        {
            self.userImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"")];
            self.userImage.myWidth = self.userImage.myHeight = 40;
            self.userImage.layer.cornerRadius = 20;
            self.userImage.layer.masksToBounds = YES;
            [self.userImage sd_setImageWithURL:[NSURL URLWithString:THUserManagerShareTHUserManager.userModel.avatar] placeholderImage:IMAGE_NAMED(@"")];
            [contentLy addSubview:self.userImage];
            
            MyLinearLayout *nameLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
            nameLy.weight = 1;
            nameLy.myHeight = MyLayoutSize.wrap;
            nameLy.subviewVSpace = 3;
            [contentLy addSubview:nameLy];
            
            self.userName = [[UILabel alloc] initWithFrame:CGRectZero];
            self.userName.font = [UIFont systemFontOfSize:17];
            self.userName.textColor = color_3;
            self.userName.text = [DHCCToolsMethod phoneFromPhoneString:THUserManagerShareTHUserManager.userModel.userAccount];
            self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
            [nameLy addSubview:self.userName];
            
            UILabel *changeInfoLable = [[UILabel alloc] initWithFrame:CGRectZero];
            changeInfoLable.font = [UIFont systemFontOfSize:15];
            changeInfoLable.textColor = color_9;
            changeInfoLable.text = @"点击修改个人信息";
            changeInfoLable.myWidth = changeInfoLable.myHeight = MyLayoutSize.wrap;
            [nameLy addSubview:changeInfoLable];
            
            UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
            right.myWidth = right.myHeight = 18;
            [contentLy addSubview:right];
            
        }
            break;
        case NORMAL:
        {
            self.normalLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.normalLable.text = self.normalTitle;
            self.normalLable.font = [UIFont systemFontOfSize:17];
            self.normalLable.textColor = color_3;
            self.normalLable.weight = 1;
            self.normalLable.myHeight = MyLayoutSize.wrap;
            [contentLy addSubview:self.normalLable];
            
            UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
            right.myWidth = right.myHeight = 18;
            [contentLy addSubview:right];
        }
            break;
        case LINE:
        {
            
            MyLinearLayout *lineLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
            lineLy.weight = 1;
            lineLy.myHeight = MyLayoutSize.wrap;
            lineLy.subviewVSpace = 3;
            [contentLy addSubview:lineLy];
            
            self.normalLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.normalLable.text = self.normalTitle;
            self.normalLable.font = [UIFont systemFontOfSize:17];
            self.normalLable.textColor = color_3;
            self.normalLable.myWidth = self.normalLable.myHeight = MyLayoutSize.wrap;
            [lineLy addSubview:self.normalLable];
            
            self.secondLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.secondLable.text = self.secondTitle;
            self.secondLable.font = [UIFont systemFontOfSize:15];
            self.secondLable.textColor = color_9;
            self.secondLable.myWidth = self.secondLable.myHeight = MyLayoutSize.wrap;
            [lineLy addSubview:self.secondLable];
            
            UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
            right.myWidth = right.myHeight = 18;
            [contentLy addSubview:right];
            
        }
            break;
        case RIGHT:
        {
            self.normalLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.normalLable.text = self.normalTitle;
            self.normalLable.font = [UIFont systemFontOfSize:17];
            self.normalLable.textColor = color_3;
            self.normalLable.weight = 1;
            self.normalLable.myHeight = MyLayoutSize.wrap;
            [contentLy addSubview:self.normalLable];
            
            self.rightLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.rightLable.text = self.rightTitle;
            self.rightLable.font = [UIFont systemFontOfSize:15];
            self.rightLable.textColor = color_9;
            self.rightLable.myWidth = self.rightLable.myHeight = MyLayoutSize.wrap;
            [contentLy addSubview:self.rightLable];
            
            UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
            right.myWidth = right.myHeight = 18;
            [contentLy addSubview:right];
        }
            break;
        case RIGHTTEXT:
        {
            self.normalLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.normalLable.text = self.normalTitle;
            self.normalLable.font = [UIFont systemFontOfSize:17];
            self.normalLable.textColor = color_3;
            self.normalLable.weight = 1;
            self.normalLable.myHeight = MyLayoutSize.wrap;
            [contentLy addSubview:self.normalLable];
            
            self.rightLable = [[UILabel alloc] initWithFrame:CGRectZero];
            self.rightLable.text = self.rightTitle;
            self.rightLable.font = [UIFont systemFontOfSize:15];
            self.rightLable.textColor = color_9;
            self.rightLable.myWidth = self.rightLable.myHeight = MyLayoutSize.wrap;
            [contentLy addSubview:self.rightLable];
        }
            break;
            
        default:
            break;
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
