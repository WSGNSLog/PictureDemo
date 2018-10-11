//
//  RotateCustomController.m
//  RotateTest
//
//  Created by shiguang on 2018/6/20.
//  Copyright © 2018年 shiguang. All rights reserved.
//

#import "RotateCustomController.h"
#import "PECropView.h"

@interface RotateCustomController ()
{
    PECropView *_cropView;
    
    ImageBlock _block;
    
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (assign,nonatomic) CGFloat rotateAngle;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) CGAffineTransform originTransform;
@end

@implementation RotateCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.originTransform = CGAffineTransformRotate(self.imgView.transform,0);
    self.image = [UIImage imageNamed:@"test"];
    _cropView = [[PECropView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40 - 70)];
    _cropView.image = self.image;
    _cropView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_cropView];
    
    [self.view bringSubviewToFront:self.bottomView];
}

- (IBAction)resetClick:(id)sender {
    [_cropView resetCropRect];
    
//    self.imgView.transform = transform;
//    self.imgView.image = self.originImg;
}
- (IBAction)cancleClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveClick:(id)sender {
    self.image = _cropView.croppedImage;
    if (_block) {
//        _block(self.image);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
-(void)addFinishBlock:(ImageBlock)block
{
    _block = block;
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
