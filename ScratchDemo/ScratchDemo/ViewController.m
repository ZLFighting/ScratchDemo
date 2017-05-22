//
//  ViewController.m
//  ScratchDemo
//
//  Created by ZL on 2017/3/30.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView *scratchedImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupSubViews];
}

/**
 注意:
 1. 这两个控件的位置要相同
 2. 一定要先创建下面的:展示刮出来的效果的, 再创建被刮的图片
 */
- (void)setupSubViews {
    
    // 1.展示刮出来的效果的view
    // 设置刮开后,显示的文字Label :刮刮乐效果展示
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 274, 145)];
    showLabel.center = self.view.center;
    showLabel.backgroundColor = [UIColor redColor];
    showLabel.textColor = [UIColor yellowColor];
    showLabel.text = @"恭喜你中奖了";
    showLabel.font = [UIFont systemFontOfSize:30];
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    
    // 2.被刮的图片
    // 设置遮挡在外面的Image
    UIImageView *scratchedImg = [[UIImageView alloc] initWithFrame:showLabel.frame];
    scratchedImg.image = [UIImage imageNamed:@"scratched"];
    [self.view addSubview:scratchedImg];
    self.scratchedImg = scratchedImg;
}

// 3.在touchesMoved方法里面实现操作
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.scratchedImg];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 20, 20);
    // 默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.scratchedImg.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.scratchedImg.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    
    self.scratchedImg.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
