//
//  SharePersonCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/6.
//

#import "SharePersonCell.h"

@interface SharePersonCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *userImage;
@property (strong, nonatomic) UILabel        *userName, *time;

@end

@implementation SharePersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCurCell];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCurCell{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.rootLy.backgroundColor = color_f5;
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    contentLy.gravity = MyGravity_Vert_Center;
    contentLy.subviewHSpace = 12;
    contentLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:contentLy];
    
    self.userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.userImage.myWidth = self.userImage.myHeight = 28;
    self.userImage.layer.cornerRadius = 14;
    self.userImage.layer.masksToBounds = YES;
    [self.userImage setImage:IMAGE_NAMED(@"img")];
    [contentLy addSubview:self.userImage];
    
    self.userName = [BaseLabel CreateBaseLabelStr:@"188****8888" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:self.userName];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [contentLy addSubview:nilView];
    
    self.time = [BaseLabel CreateBaseLabelStr:@"1990-04-04  08:20" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:self.time];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
