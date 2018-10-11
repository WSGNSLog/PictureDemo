//
//  RotateNormalController.m
//  RotateTest
//
//  Created by shiguang on 2018/6/21.
//  Copyright © 2018年 shiguang. All rights reserved.
//

#import "RotateNormalController.h"
#import "UIImage+Rotate.h"
//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)
@interface RotateNormalController ()<UIGestureRecognizerDelegate>

@property (assign,nonatomic) CGFloat originAngle;
@property (assign,nonatomic) CGFloat rotateAngle;
@property (nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RotateNormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image = [UIImage imageNamed:@"test"];
    self.imageView.image = self.image;
    self.imageView.userInteractionEnabled = YES;
    //[self addRotateGesture];
}
- (IBAction)leftRotate:(id)sender {
    _imageView.image = [_imageView.image rotate:UIImageOrientationLeft];
}
- (IBAction)rightRotate:(id)sender {
    _imageView.image = [_imageView.image rotate:UIImageOrientationRight];
}

//左右翻转//垂直
- (IBAction)flipVertical:(id)sender {
    _imageView.image = [_imageView.image flipHorizontal];
}
//上下翻转//水平
- (IBAction)flipHorizontal:(id)sender {
    _imageView.image = [_imageView.image flipVertical];
}
- (void)addRotateGesture
{
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    
    rotate.delegate = self;
    [self.imageView addGestureRecognizer:rotate];
}
- (void)rotate:(UIRotationGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        _rotateAngle = self.originAngle;
        self.rotateAngle = 0;
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGAffineTransform transform = CGAffineTransformRotate(self.imageView.transform, recognizer.rotation);
        
        recognizer.view.transform = transform;
        CGFloat rotation = recognizer.rotation;
        _rotateAngle += rotation;
        NSLog(@"angle:%f rotation:%f",_rotateAngle,rotation);
        recognizer.rotation = 0.0;
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        //self.imageView.transform = CGAffineTransformIdentity;
//        if ((_rotateAngle-self.originAngle)>0) {
//            self.imageView.image = [self.imageView.image rotate:UIImageOrientationRight];
//
//        }else if((_rotateAngle-self.originAngle)<0){
//            self.imageView.image = [self.imageView.image rotate:UIImageOrientationLeft];
//        }
        
        
        __block CGAffineTransform transform = CGAffineTransformIdentity;
        NSLog(@"***:%f %f",self.rotateAngle,kDegreesToRadian(90)-(self.rotateAngle));
       
        
        [UIView animateWithDuration:0.25 animations:^{
            if ((self.rotateAngle)>0) {
                
                transform = CGAffineTransformRotate(recognizer.view.transform, kDegreesToRadian(90)-(self.rotateAngle));
            }else if((self.rotateAngle)<0){
                transform = CGAffineTransformRotate(recognizer.view.transform, kDegreesToRadian(-90)-(self.rotateAngle));
            }
            recognizer.view.transform = transform;
            CGFloat rotation = recognizer.rotation;
            _rotateAngle += rotation;
            NSLog(@"angle:%f rotation:%f",_rotateAngle,rotation);
            recognizer.rotation = 0.0;
//            self.originAngle = _rotateAngle;
        } completion:^(BOOL finished) {
            recognizer.view.transform = CGAffineTransformIdentity;
            if ((self.rotateAngle)>0) {
                self.imageView.image = [self.imageView.image rotate:UIImageOrientationRight];
            }else if((self.rotateAngle)<0){
                self.imageView.image = [self.imageView.image rotate:UIImageOrientationLeft];
            }
        }];
        
        
    }
    
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
//- (void)rotate:(UIRotationGestureRecognizer *)recognizer{
//
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        //        _rotateAngle = self.originAngle;
//        self.rotateAngle = 0;
//    }else if (recognizer.state == UIGestureRecognizerStateChanged){
//        CGAffineTransform transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
//
//        recognizer.view.transform = transform;
//        CGFloat rotation = recognizer.rotation;
//        _rotateAngle += rotation;
//        NSLog(@"angle:%f rotation:%f",_rotateAngle,rotation);
//        recognizer.rotation = 0.0;
//
//    }else if (recognizer.state == UIGestureRecognizerStateEnded){
//        //self.imageView.transform = CGAffineTransformIdentity;
//        //        if ((_rotateAngle-self.originAngle)>0) {
//        //            self.imageView.image = [self.imageView.image rotate:UIImageOrientationRight];
//        //
//        //        }else if((_rotateAngle-self.originAngle)<0){
//        //            self.imageView.image = [self.imageView.image rotate:UIImageOrientationLeft];
//        //        }
//
//
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        NSLog(@"***:%f %f",self.rotateAngle,kDegreesToRadian(90)-(self.rotateAngle));
//        if ((self.rotateAngle)>0) {
//
//            transform = CGAffineTransformRotate(recognizer.view.transform, kDegreesToRadian(90)-(self.rotateAngle));
//        }else if((self.rotateAngle)<0){
//            transform = CGAffineTransformRotate(recognizer.view.transform, kDegreesToRadian(-90)-(self.rotateAngle));
//        }
//        recognizer.view.transform = transform;
//        CGFloat rotation = recognizer.rotation;
//        _rotateAngle += rotation;
//        NSLog(@"angle:%f rotation:%f",_rotateAngle,rotation);
//        recognizer.rotation = 0.0;
//        self.originAngle = _rotateAngle;
//
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//
//
//    }
//
//}
@end
