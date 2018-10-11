//
//  RotateController.m
//  RotateTest
//
//  Created by shiguang on 2018/6/19.
//  Copyright © 2018年 shiguang. All rights reserved.
//

#import "RotateController.h"
#import "UIImage+Rotate.h"
#import "CDCircleOverlayView.h"
#import "CDCircle.h"
#import "TripView.h"
#import "UIImage+SubImage.h"

@interface RotateController ()<UIGestureRecognizerDelegate,CDCircleDelegate, CDCircleDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (assign,nonatomic) CGFloat rotateAngle;
@property (nonatomic,retain) UIImage *originImg;
@property (nonatomic,assign) CGAffineTransform originTransform;
@property (nonatomic,assign) TripType selectedCripType;
@property (nonatomic,retain) TripView * tripView;
@end

@implementation RotateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rotateAngle = 0;
    self.originImg = [UIImage imageNamed:@"careAlarmLiveBg"];
    self.imgView.image = [UIImage imageNamed:@"careAlarmLiveBg"];
    self.imgView.userInteractionEnabled = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.originTransform = CGAffineTransformRotate(self.imgView.transform,0);
    [self addRotateGesture];
    //[self addPan];
    self.selectedCripType = TripTypeFree;
    //[self addCircleView];
}
- (void)addCircleView{
    // Do any additional setup after loading the view, typically from a nib.
    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , self.bgView.frame.origin.y+self.bgView.frame.size.height-150, 300, 300) numberOfSegments:36 ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    //overlay.backgroundColor = [UIColor redColor];
    [self.view insertSubview:circle belowSubview:self.bgView];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
    [self.view insertSubview:overlay belowSubview:circle];
    
}
- (void)addRotateGesture
{
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    
    rotate.delegate = self;
    [self.imgView addGestureRecognizer:rotate];
}
- (void)rotate:(UIRotationGestureRecognizer *)recognizer
{
   

    CGAffineTransform transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    
    recognizer.view.transform = transform;
    CGFloat rotation = recognizer.rotation;
    _rotateAngle += rotation;
    NSLog(@"angle:%f rotation:%f",_rotateAngle,rotation);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        
    }
    recognizer.rotation = 0.0;
}
- (void)addPan{
    UIPanGestureRecognizer* panGensture = [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector (handlePanGesture:)];
    panGensture.delegate = self;
    [self.imgView addGestureRecognizer:panGensture];
}
- (void)handlePanGesture:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.view == self.imgView) {
        CGPoint translation = [recognizer translationInView:self.imgView];
        NSLog(@"pan.x:%f pan.y:%f",translation.x,translation.y);
        //放大
        if (recognizer.state == UIGestureRecognizerStateChanged) {
            //            CGFloat delta = translation.x;
            //            self.imageView.bounds = CGRectMake(0, 0, self.imageView.bounds.size.width + delta, self.imageView.bounds.size.height + delta);
        }
        [recognizer setTranslation:CGPointZero inView:self.imgView];
        
        //旋转
        CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        CGPoint anthorPoint = self.imgView.center;
        CGFloat height = newCenter.y - anthorPoint.y;
        CGFloat width = newCenter.x - anthorPoint.x;
        CGFloat angle1 = atan(height / width);
        height = recognizer.view.center.y - anthorPoint.y;
        width = recognizer.view.center.x - anthorPoint.x;
        CGFloat angle2 = atan(height / width);
        CGFloat angle = angle1 - angle2;
        
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, angle);
        //        _rotateAngle += angle;
    }
    
}
-(void)tripConfirmClick{
    
    double scale =  self.imgView.image.size.width/self.imgView.frame.size.width;
    CGRect tripRect = [self.tripView tripRect];
    CGRect imageRect = CGRectMake(tripRect.origin.x * scale, tripRect.origin.y * scale, tripRect.size.width * scale, tripRect.size.height * scale);
    UIImage * image = [self.imgView.image subImageWithRect: imageRect];
    self.imgView.image = image;
    //[self setImageViewFrame:YES];
    [self setUpTripImageView];
    
    [self removeTripView];
    
    self.tripView = [[TripView alloc]initWithFrame:self.imgView.bounds];
    self.tripView.type = TripTypeFree;
    [self.imgView addSubview:self.tripView];

    
}
- (void)setUpTripImageView{
    
    CGSize imageSize = self.imgView.image.size;
    double imageViewHeight;
    double imageViewWidth;
    double imageBgHeigt = self.bgView.bounds.size.height;
    double imageBgWidth = self.bgView.bounds.size.width;
    if (imageSize.width/imageSize.height > imageBgWidth/imageBgHeigt) {
        imageViewWidth = imageBgWidth;
        imageViewHeight = imageSize.height/imageSize.width * imageViewWidth;
        self.imgView.frame = CGRectMake(0, (imageBgHeigt - imageViewHeight)/2.0, imageViewWidth, imageViewHeight);
    }else{
        imageViewHeight = imageBgHeigt;
        imageViewWidth = imageSize.width/imageSize.height * imageViewHeight;
        
        self.imgView.frame = CGRectMake((imageBgWidth - imageViewWidth)/2.0,0, imageViewWidth, imageViewHeight);
    }
    
}
-(void)setupOriginalImageView{
    
    
    self.imgView.image = self.originImg;
    
    
    CGSize imageSize = self.imgView.image.size;
    double imageViewHeight;
    double imageViewWidth;
    double imageBgHeigt = self.bgView.bounds.size.height;
    double imageBgWidth = self.bgView.bounds.size.width;
    if (imageSize.width/imageSize.height > imageBgWidth/imageBgHeigt) {
        imageViewWidth = imageBgWidth;
        imageViewHeight = imageSize.height/imageSize.width * imageViewWidth;
        self.imgView.frame = CGRectMake(0, (imageBgHeigt - imageViewHeight)/2.0, imageViewWidth, imageViewHeight);
    }else{
        imageViewHeight = imageBgHeigt;
        imageViewWidth = imageSize.width/imageSize.height * imageViewHeight;
        
        self.imgView.frame = CGRectMake((imageBgWidth - imageViewWidth)/2.0,0, imageViewWidth, imageViewHeight);
    }
    
    
    
}
- (void)tripBtnClick{
    [self removeTripView];
    self.tripView = [[TripView alloc]initWithFrame:self.imgView.bounds];
    self.tripView.type = self.selectedCripType;
    [self.imgView addSubview:self.tripView];
    
}
- (void)removeTripView{
    if (self.tripView) {
        [self.tripView removeFromSuperview];
        self.tripView = nil;
    }
}
- (IBAction)rotateClick:(UIButton *)sender {
    if (self.tripView) {
        [self removeTripView];
        
    }else{
        [self setupOriginalImageView];
        [self tripBtnClick];
    }
}
- (IBAction)reset:(UIButton *)sender {
    CGAffineTransform transform = CGAffineTransformRotate(self.originTransform, 0);
    self.imgView.transform = transform;
    self.imgView.image = self.originImg;
}

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
    NSLog(@"%@",[NSString stringWithFormat:@"Segment's tag: %li", (long)segment]);
    
    
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil] lastObject];
    
    return [UIImage imageWithContentsOfFile:fileString];
    
}

@end
