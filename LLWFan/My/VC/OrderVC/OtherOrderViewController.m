//
//  OtherOrderViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "OtherOrderViewController.h"

@interface OtherOrderViewController ()



@end

@implementation OtherOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}
#pragma mark - JXCategoryListContentViewDelegate -
//- (UIScrollView *)listScrollView {
//    return self.merchantCollection;
//}
//
//- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
//    self.scrollCallback = callback;
//}

- (UIView *)listView {
    return self.view;
}
@end
