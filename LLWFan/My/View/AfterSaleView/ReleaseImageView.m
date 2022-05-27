//
//  ReleaseImageView.m
//  SeaEgret
//
//  Created by MAC on 2021/4/26.
//

#import "ReleaseImageView.h"

@interface ReleaseImageView()

@end

@implementation ReleaseImageView



- (IBAction)deleteImg:(id)sender {
    if (self.deleteClickHandler) {
        
        self.deleteClickHandler();
    }
}
@end
