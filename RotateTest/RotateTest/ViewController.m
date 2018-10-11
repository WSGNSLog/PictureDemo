//
//  ViewController.m
//  RotateTest
//
//  Created by shiguang on 2018/6/19.
//  Copyright © 2018年 shiguang. All rights reserved.
//

#import "ViewController.h"
#import "CutController.h"
#import "RotateController.h"
#import "RotateCustomController.h"
#import "RotateNormalController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CameraCutViewController *mCameraCutVC = [[CameraCutViewController alloc]initWithNibName:@"CameraCutViewController" bundle:nil];
//    mCameraCutVC.delegate = self;
//    mCameraCutVC.mIdentity = @"Camera";
//    mCameraCutVC.mTargetImage = _mTargetImage;
//    [[self.navigationController mCameraCutVC animated:NO completion:NULL];
    
}

- (IBAction)nextVCClick:(id)sender {
    //typeof(self) weakSelf = self;
    RotateNormalController *vc = [[RotateNormalController alloc]init];
    //    [vc addFinishBlock:^(UIImage *image) {
    //        weakSelf.imageView.image = image;
    //    }];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
