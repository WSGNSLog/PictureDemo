//
//  CutController.h
//  RotateTest
//
//  Created by shiguang on 2018/6/19.
//  Copyright © 2018年 shiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoCutDelegate<NSObject>
@optional
- (void)getImageFromCut:(UIImage *)resultImage;
@end
@interface CutController : UIViewController

@property (nonatomic,weak) id<PhotoCutDelegate>delegate;

@end
