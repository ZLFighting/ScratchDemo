# ScratchDemo
iOS-仿支付宝刮刮乐效果

支付宝里有个刮刮乐中奖, 和大街小巷里的类似彩票刮刮乐的效果一样。

![刮刮乐](https://github.com/ZLFighting/ScratchDemo/blob/master/ScratchDemo/B18955F7-9EE7-4FAE-97AE-F58CA3CEBF68.png)

实现思路, 其实很简单的三步:
>1.  展示刮出来的效果的view: 即刮开后刮刮乐效果展示-显示的文字Label
2. 设置遮挡在外面的Image(被刮的图片)
3. 在touchesMoved方法里面实现操作: 刮开图片获取文字

虽然思路简单,但是还需要**注意:**
1. 这两个控件的位置切记要相同!
2. 一定要先创建下面的展示刮出来的效果控件的, 再创建上面的被刮的图片控件!

下面就直接上代码!
```
- (void)setupSubViews {

// 1.展示刮开出来的效果:显示的文字 label
UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 274, 145)];
showLabel.center = self.view.center;
showLabel.backgroundColor = [UIColor redColor];
showLabel.textColor = [UIColor yellowColor];
showLabel.text = @"恭喜你中奖了";
showLabel.font = [UIFont systemFontOfSize:30];
showLabel.textAlignment = NSTextAlignmentCenter;
[self.view addSubview:showLabel];

// 2.设置遮挡在外面的Image(被刮的图片)
UIImageView *scratchedImg = [[UIImageView alloc] initWithFrame:showLabel.frame];
scratchedImg.image = [UIImage imageNamed:@"scratched"];
[self.view addSubview:scratchedImg];
self.scratchedImg = scratchedImg;
}
```
```
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
```


您的支持是作为程序媛的我最大的动力, 如果觉得对你有帮助请送个Star吧,谢谢啦
