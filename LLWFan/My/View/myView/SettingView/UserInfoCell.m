//
//  UserInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/5.
//

#import "UserInfoCell.h"

@interface UserInfoCell()<AllPopNoticeViewDelegate>

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel        *userID, *nickName, *sex, *birthday, *location;

@end

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self initCell];
    }
    return self;
}
- (void)changeUserRealName:(NSString *)realName{
    
    [THHttpManager changeRealNameWithRealName:realName AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"修改昵称成功" AndType:success IsHideBg:YES AnddataBlock:nil];
        }
    }];
}
- (void)tapCell:(UITapGestureRecognizer *)tap{
    
    switch (tap.view.tag) {
        case 1:
        {
            AllPopNoticeView *pop = [[AllPopNoticeView alloc] initTextFieldPopWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 170) AndTitle:@"昵称修改"];
            pop.delegate = self;
            LSTPopView *popView = [LSTPopView initWithCustomView:pop parentView:self.currentViewController.view popStyle:LSTPopStyleSmoothFromTop dismissStyle:LSTDismissStyleSmoothToTop];
            LSTPopViewWK(popView)
            popView.hemStyle = LSTHemStyleCenter;
            popView.isClickFeedback = YES;
            popView.popDuration = 0.2;
            popView.bgClickBlock = ^{
                [wk_popView dismiss];
            };
            pop.block = ^{
                [wk_popView dismiss];
            };
            [popView pop];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
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
    
    MyLinearLayout *idLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    idLy.myHorzMargin = 0;
    idLy.myHeight = MyLayoutSize.wrap;
    idLy.gravity = MyGravity_Vert_Center;
    idLy.subviewHSpace = 4;
    idLy.tag = 0;
    [contentLy addSubview:idLy];
    
    UILabel *idLable = [BaseLabel CreateBaseLabelStr:@"ID" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    idLable.myWidth = idLable.myHeight = MyLayoutSize.wrap;
    [idLy addSubview:idLable];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [idLy addSubview:nilView];
    
    self.userID = [BaseLabel CreateBaseLabelStr:@"123456" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userID.myWidth = self.userID.myHeight = MyLayoutSize.wrap;
    self.userID.text = THUserManagerShareTHUserManager.userModel.userID;
    [idLy addSubview:self.userID];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    MyLinearLayout *nickNameLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    nickNameLy.myHorzMargin = 0;
    nickNameLy.myHeight = MyLayoutSize.wrap;
    nickNameLy.gravity = MyGravity_Vert_Center;
    nickNameLy.subviewHSpace = 4;
    nickNameLy.tag = 1;
    [nickNameLy addGestureRecognizer:tap1];
    [contentLy addSubview:nickNameLy];
    
    UILabel *nickNameLable = [BaseLabel CreateBaseLabelStr:@"昵称" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    nickNameLable.myWidth = nickNameLable.myHeight = MyLayoutSize.wrap;
    [nickNameLy addSubview:nickNameLable];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    [nickNameLy addSubview:nilView1];
    
    self.nickName = [BaseLabel CreateBaseLabelStr:@"张三" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.nickName.myWidth = self.nickName.myHeight = MyLayoutSize.wrap;
    self.nickName.text = THUserManagerShareTHUserManager.userModel.realName;
    [nickNameLy addSubview:self.nickName];
    
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right1.myWidth = right1.myHeight = 18;
    [nickNameLy addSubview:right1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    MyLinearLayout *sexLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    sexLy.myHorzMargin = 0;
    sexLy.myHeight = MyLayoutSize.wrap;
    sexLy.gravity = MyGravity_Vert_Center;
    sexLy.subviewHSpace = 4;
    sexLy.tag = 2;
    [sexLy addGestureRecognizer:tap2];
    [contentLy addSubview:sexLy];
    
    UILabel *sexLable = [BaseLabel CreateBaseLabelStr:@"性别" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    sexLable.myWidth = sexLable.myHeight = MyLayoutSize.wrap;
    [sexLy addSubview:sexLable];
    
    UIView *nilView2 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView2.weight = 1;
    nilView2.myHeight = 1;
    [sexLy addSubview:nilView2];
    
    self.sex = [BaseLabel CreateBaseLabelStr:@"男" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.sex.myWidth = self.sex.myHeight = MyLayoutSize.wrap;
    [sexLy addSubview:self.sex];
    
    UIImageView *right2 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right2.myWidth = right2.myHeight = 18;
    [sexLy addSubview:right2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    MyLinearLayout *birthdayLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    birthdayLy.myHorzMargin = 0;
    birthdayLy.myHeight = MyLayoutSize.wrap;
    birthdayLy.gravity = MyGravity_Vert_Center;
    birthdayLy.subviewHSpace = 4;
    birthdayLy.tag = 3;
    [birthdayLy addGestureRecognizer:tap3];
    [contentLy addSubview:birthdayLy];
    
    UILabel *birthdayLable = [BaseLabel CreateBaseLabelStr:@"生日" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    birthdayLable.myWidth = birthdayLable.myHeight = MyLayoutSize.wrap;
    [birthdayLy addSubview:birthdayLable];
    
    UIView *nilView3 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView3.weight = 1;
    nilView3.myHeight = 1;
    [birthdayLy addSubview:nilView3];
    
    self.birthday = [BaseLabel CreateBaseLabelStr:@"未选择" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.birthday.myWidth = self.birthday.myHeight = MyLayoutSize.wrap;
    [birthdayLy addSubview:self.birthday];
    
    UIImageView *right3 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right3.myWidth = right3.myHeight = 18;
    [birthdayLy addSubview:right3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    MyLinearLayout *locationLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    locationLy.myHorzMargin = 0;
    locationLy.myHeight = MyLayoutSize.wrap;
    locationLy.gravity = MyGravity_Vert_Center;
    locationLy.subviewHSpace = 4;
    locationLy.tag = 4;
    [locationLy addGestureRecognizer:tap4];
    [contentLy addSubview:locationLy];
    
    UILabel *locationLable = [BaseLabel CreateBaseLabelStr:@"所在地" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    locationLable.myWidth = locationLable.myHeight = MyLayoutSize.wrap;
    [locationLy addSubview:locationLable];
    
    UIView *nilView4 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView4.weight = 1;
    nilView4.myHeight = 1;
    [locationLy addSubview:nilView4];
    
    self.location = [BaseLabel CreateBaseLabelStr:@"未选择" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.location.myWidth = self.location.myHeight = MyLayoutSize.wrap;
    [locationLy addSubview:self.location];
    
    UIImageView *right4 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    right4.myWidth = right4.myHeight = 18;
    [locationLy addSubview:right4];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
