//
//  ViewController.m
//  MirroAndRotateDemo
//
//  Created by shiguang on 2018/10/11.
//  Copyright © 2018年 shiguang. All rights reserved.



#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic)    CGAffineTransform transform;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  参考https://blog.csdn.net/C_calary/article/details/77888122
    
}
- (IBAction)makeTrasform:(id)sender {
    //旋转90度
    CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*0.5);
    self.transform = transform;
    _imageView.transform = self.transform;
}

/*
 方法1
 可以多个transform叠加
*/
- (IBAction)makeMirror1:(id)sender {
    
    //获得初始transform
    CGAffineTransform transform = CGAffineTransformIdentity;
    /*
     更改位置，x、y轴各平移100
     //transform = CGAffineTransformTranslate(transform, 100, 100);
     //旋转角度
     // transform = CGAffineTransformRotate(<#CGAffineTransform t#>, <#CGFloat angle#>)
     */
    //进行镜像变换(x轴左右反转)
    transform = CGAffineTransformScale(transform, -1, 1);
    _imageView.transform = transform;

}
/*
 方法2
 只能设置一个单一的transform
*/
- (IBAction)makeMirror2:(id)sender {

    CGAffineTransform transform = CGAffineTransformMakeScale(-1,1);
    _imageView.transform = transform;
}
@end
