//
//  BaseLabel.m
//  BaseDemo
//
//  Created by 王剑亮 on 2017/8/22.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

+ (BaseLabel *)CreateBaseLabelStr :(NSString *)str
                             Font :(UIFont *)font
                            Color :(UIColor *)color
                            Frame :(CGRect )frame
                        Alignment :(NSTextAlignment)textAlignment
                              Tag :(NSInteger)tag{

    BaseLabel *label = [[BaseLabel alloc]init];
    label.text = str;
    label.tag = tag;
    label.font =  font;
    label.textColor = color;
    label.frame = frame;
    label.textAlignment = textAlignment;
   
    return label;
}
#pragma mark - override

- (void)drawTextInRect:(CGRect)rect {
    CGRect curRect = CGRectMake(0, 0, rect.size.width + self.insets.left + self.insets.right, rect.size.height);
    [super drawTextInRect:UIEdgeInsetsInsetRect(curRect, self.insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += (self.insets.left + self.insets.right);
    size.height += (self.insets.top + self.insets.bottom);
    return size;
}

#pragma mark - getter && setter

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    [self layoutSubviews];
}
@end
