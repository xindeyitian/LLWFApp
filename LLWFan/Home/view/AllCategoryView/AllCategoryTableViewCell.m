//
//  AllCategoryTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/14.
//

#import "AllCategoryTableViewCell.h"

@interface AllCategoryTableViewCell()

@property (strong, nonatomic) MyLinearLayout *backView;


@end

@implementation AllCategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}
- (void)initCell{
    
    self.backView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.backView.myHorzMargin = 0;
    self.backView.myHeight = 50;
    self.backView.backgroundColor = color_f5;
    self.backView.gravity = MyGravity_Center;
    [self.contentView addSubview:self.backView];
    
    self.title = [BaseLabel CreateBaseLabelStr:@"一级分类" Font:[UIFont systemFontOfSize:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.title.myHorzMargin = 0;
    self.title.myHeight = MyLayoutSize.wrap;
    [self.backView addSubview:self.title];
    
}
- (void)setSelectCurCell:(BOOL)selectCurCell{
    
    _selectCurCell = selectCurCell;
    if (selectCurCell) {
        
        self.backView.backgroundColor = UIColor.whiteColor;
        self.title.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        self.title.textColor = [UIColor colorNamed:@"color-red"];
    }else{
        
        self.backView.backgroundColor = color_f5;
        self.title.font = [UIFont systemFontOfSize:13];
        self.title.textColor = color_3;
    }
}
@end
