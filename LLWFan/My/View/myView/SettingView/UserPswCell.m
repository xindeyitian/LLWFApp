//
//  UserPswCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/5.
//

#import "UserPswCell.h"
#import "ChangePswViewController.h"

@interface UserPswCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;

@end

@implementation UserPswCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self initCell];
    }
    return self;
}
- (void)tapCell:(UITapGestureRecognizer *)tap{
    
    ChangePswViewController *vc = [[ChangePswViewController alloc] init];
    vc.type = tap.view.tag;
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
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
    MyLinearLayout *changeLoginPswLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    changeLoginPswLy.myHorzMargin = 0;
    changeLoginPswLy.myHeight = MyLayoutSize.wrap;
    changeLoginPswLy.gravity = MyGravity_Vert_Center;
    changeLoginPswLy.subviewHSpace = 4;
    [changeLoginPswLy addGestureRecognizer:tap];
    changeLoginPswLy.tag = 0;
    [contentLy addSubview:changeLoginPswLy];
    
    UILabel *changeLoginPswLable = [BaseLabel CreateBaseLabelStr:@"修改登录密码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    changeLoginPswLable.myWidth = changeLoginPswLable.myHeight = MyLayoutSize.wrap;
    [changeLoginPswLy addSubview:changeLoginPswLable];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [changeLoginPswLy addSubview:nilView];
    
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right1.myWidth = right1.myHeight = 18;
    [changeLoginPswLy addSubview:right1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    
    MyLinearLayout *changeWithDrawPSwLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    changeWithDrawPSwLy.myHorzMargin = 0;
    changeWithDrawPSwLy.myHeight = MyLayoutSize.wrap;
    changeWithDrawPSwLy.gravity = MyGravity_Vert_Center;
    changeWithDrawPSwLy.subviewHSpace = 4;
    [changeWithDrawPSwLy addGestureRecognizer:tap1];
    changeWithDrawPSwLy.tag = 1;
    [contentLy addSubview:changeWithDrawPSwLy];
    
    UILabel *idLable = [BaseLabel CreateBaseLabelStr:@"修改提现密码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    idLable.myWidth = idLable.myHeight = MyLayoutSize.wrap;
    [changeWithDrawPSwLy addSubview:idLable];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    [changeWithDrawPSwLy addSubview:nilView1];
    
    UIImageView *right2 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right2.myWidth = right2.myHeight = 18;
    [changeWithDrawPSwLy addSubview:right2];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
