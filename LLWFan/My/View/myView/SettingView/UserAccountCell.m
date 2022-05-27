//
//  UserAccountCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/5.
//

#import "UserAccountCell.h"

@interface UserAccountCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel *account;

@end

@implementation UserAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self initCell];
    }
    return self;
}
- (void)tapCell:(UITapGestureRecognizer *)tap{
    
//    tap.view.tag
}
- (void)initCell{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.rootLy.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.subviewVSpace = 20;
    [self.rootLy addSubview:contentLy];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    MyLinearLayout *accountLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    accountLy.myHorzMargin = 0;
    accountLy.myHeight = MyLayoutSize.wrap;
    accountLy.gravity = MyGravity_Vert_Center;
    accountLy.subviewHSpace = 4;
    [accountLy addGestureRecognizer:tap];
    accountLy.tag = 0;
    [contentLy addSubview:accountLy];
    
    UILabel *accountLable = [BaseLabel CreateBaseLabelStr:@"手机号码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    accountLable.myWidth = accountLable.myHeight = MyLayoutSize.wrap;
    [accountLy addSubview:accountLable];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [accountLy addSubview:nilView];
    
    UILabel *account = [BaseLabel CreateBaseLabelStr:@"手机号码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    account.myWidth = account.myHeight = MyLayoutSize.wrap;
    [accountLy addSubview:account];
    
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right1.myWidth = right1.myHeight = 18;
    [accountLy addSubview:right1];
    
    MyLinearLayout *zhuxiaoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    zhuxiaoLy.myHorzMargin = 0;
    zhuxiaoLy.myHeight = MyLayoutSize.wrap;
    zhuxiaoLy.gravity = MyGravity_Vert_Center;
    zhuxiaoLy.subviewHSpace = 4;
    [zhuxiaoLy addGestureRecognizer:tap];
    zhuxiaoLy.tag = 0;
    [contentLy addSubview:zhuxiaoLy];
    
    UILabel *zhuxiaoLable = [BaseLabel CreateBaseLabelStr:@"用户注销" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    zhuxiaoLable.myWidth = zhuxiaoLable.myHeight = MyLayoutSize.wrap;
    [zhuxiaoLy addSubview:zhuxiaoLable];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    [zhuxiaoLy addSubview:nilView1];
    
    UIImageView *right2 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right2.myWidth = right2.myHeight = 18;
    [zhuxiaoLy addSubview:right2];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
