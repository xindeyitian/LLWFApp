//
//  DKSButton.m
//  FlashSDKDemo
//
//  Created by aDu on 2017/8/30.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSButton.h"

@interface DKSButton ()

/**
 图片距离上下的距离
 */
@property (nonatomic, assign) CGFloat space;

@property (strong, nonatomic) JSBadgeView *badgeView;

@end

@implementation DKSButton

+ (id)buttonWithType:(UIButtonType)buttonType withSpace:(CGFloat)space {
    DKSButton *button = [super buttonWithType:buttonType];
    button.space = space;
    return button;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //文案的宽度
    CGFloat labelWidth = self.titleLabel.frame.size.width;
    //文案的高度
    CGFloat labelHeight = self.titleLabel.frame.size.height;
    //button的image
    UIImage *image = self.imageView.image;
    
    switch (self.buttonStyle) {
        case DKSButtonImageLeft: {
            //设置后的image显示的高度
            CGFloat imageHeight = self.frame.size.height - (2 * self.space);
            //文案和图片居中显示时距离两边的距离
            CGFloat edgeSpace = (self.frame.size.width - imageHeight - labelWidth - self.padding) / 2;
            self.imageEdgeInsets = UIEdgeInsetsMake(self.space, edgeSpace, self.space, edgeSpace + labelWidth + self.padding);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width + imageHeight + self.padding, 0, 0);
        }
            break;
        case DKSButtonImageRight: {
            //设置后的image显示的高度
            CGFloat imageHeight = self.frame.size.height - (2 * self.space);
            //文案和图片居中显示时距离两边的距离
            CGFloat edgeSpace = (self.frame.size.width - imageHeight - labelWidth - self.padding) / 2;
            self.imageEdgeInsets = UIEdgeInsetsMake(self.space, edgeSpace + labelWidth + self.padding, self.space, edgeSpace);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width - self.padding - imageHeight, 0, 0);
        }
            break;
        case DKSButtonImageTop: {
            //设置后的image显示的高度
            CGFloat imageHeight = self.frame.size.height - (2 * self.space) - labelHeight - self.padding;
            if (imageHeight > image.size.height) {
                imageHeight = image.size.height;
            }
            self.imageEdgeInsets = UIEdgeInsetsMake(self.space, (self.frame.size.width - imageHeight) / 2, self.space + labelHeight + self.padding, (self.frame.size.width - imageHeight) / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(self.space + imageHeight + self.padding, -image.size.width, self.space, 0);
        }
            break;
        case DKSButtonImageBottom: {
            //设置后的image显示的高度
            CGFloat imageHeight = self.frame.size.height - (2 * self.space) - labelHeight - self.padding;
            if (imageHeight > image.size.height) {
                imageHeight = image.size.height;
            }
            self.imageEdgeInsets = UIEdgeInsetsMake(self.space + labelHeight + self.padding, (self.frame.size.width - imageHeight) / 2, self.space, (self.frame.size.width - imageHeight) / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(self.space, -image.size.width, self.padding + imageHeight + self.space, 0);
        }
            break;
        default:
            break;
    }
}
- (void)reloadPointWithNum:(NSInteger )num{
    
    if (num != 0) {
        
        //新标识视图
        //1、在父控件（parentView）上显示，显示的位置TopRight
        self.badgeView = [[JSBadgeView alloc]initWithParentView:self alignment:JSBadgeViewAlignmentTopRight];
        //2、如果显示的位置不对，可以自己调整，超爽啊！
        self.badgeView.badgePositionAdjustment = CGPointMake(-15, 10);
        //3、如果多个的badge,可以设置tag要辨别
        self.badgeView.tag = 0;
        //1、背景色
        self.badgeView.badgeBackgroundColor = [UIColor redColor];
        //2、没有反光面
        self.badgeView.badgeOverlayColor = [UIColor clearColor];
        //3、外圈的颜色，默认是白色
        self.badgeView.badgeStrokeColor = [UIColor redColor];

        /*****设置数字****/
        //1、用字符串来ym
        if (num > 99) {
            
            self.badgeView.badgeText = @"99+";
        }else{
            
            self.badgeView.badgeText = NSStringFormat(@"%ld",num);
        }
          
        //当更新数字时，最好刷新，不然由于frame固定的，数字为2位时，红圈变形
        [self.badgeView setNeedsLayout];
    }else{
        [self.badgeView removeFromSuperview];
    }
}
@end
