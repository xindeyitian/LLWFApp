//
//  FansTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "FansTableViewCell.h"

@interface FansTableViewCell()

@property (strong, nonatomic) UILabel *level, *name, *time;

@end

@implementation FansTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    MyLinearLayout *userLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    userLy.myHorzMargin = 0;
    userLy.myHeight = MyLayoutSize.wrap;
    userLy.paddingLeft = userLy.paddingRight = 12;
    userLy.paddingTop = 14;
    userLy.subviewHSpace = 8;
    userLy.gravity = MyGravity_Vert_Center;
    [self.contentView addSubview:userLy];
    
    self.level = [[UILabel alloc] initWithFrame:CGRectZero];
    self.level.font = [UIFont systemFontOfSize:13];
    self.level.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.level.text = @"粉丝";
    self.level.myWidth = self.level.myHeight = MyLayoutSize.wrap;
    [userLy addSubview:self.level];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectZero];
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.textColor = color_3;
    self.name.text = @"18888888888";
    self.name.myWidth = self.name.myHeight = MyLayoutSize.wrap;
    [userLy addSubview:self.name];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    nilView.backgroundColor = UIColor.clearColor;
    [userLy addSubview:nilView];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectZero];
    self.time.font = [UIFont systemFontOfSize:13];
    self.time.textColor = color_9;
    self.time.text = @"1990-04-04";
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [userLy addSubview:self.time];
    
}
@end
