//
//  UIImage+PureColor.m
//  image
//
//  Created by Mac on 2017/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIImage+SCPureColor.h"

@implementation UIImage (SCPureColor)

+ (instancetype)pureColorImageSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}
@end
