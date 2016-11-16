传送门：https://github.com/azheng51714/MACProject
无意间从 Dribbble 上看到一个logo 设计图，感觉非常有意思，所以决定拿来玩玩；
![原图](http://upload-images.jianshu.io/upload_images/335970-184c1e88059bb9e9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240); 

分析其构造，基本确定有2部分组成，分别是：外环圆以及内部的三个收尾相连贝塞尔曲线；
设计：以外切圆心为中心点，构造一个等边三角形，计算三个顶点，pointA,pointB 以及 pointC，然后以三个顶点绘制三条贝塞尔曲线；

```
@interface LoadingView(){
    CGFloat _turnR;//旋转半径
    CGPoint _pointA;
    CGPoint _pointB;
    CGPoint _pointC;
}
@property (nonatomic,strong)     CAShapeLayer *bgLayer;
@property (nonatomic,strong)     CAShapeLayer *circleLayer;
@property (nonatomic,strong)     CAShapeLayer *leftLayer;
@property (nonatomic,strong)     CAShapeLayer *rightLayer;

@property (nonatomic,strong)     CAShapeLayer *bottomLayer;
@property (nonatomic,strong)     CABasicAnimation *animation;
@property (nonatomic,strong)     CABasicAnimation *turnAnimation;

-(void)setUp{
    _turnR = 30.0f;
    _pointA = CGPointMake(self.centerX-_turnR*cos(M_PI_2/3.0), self.centerY+_turnR*sin(M_PI_2/3.0));//A点
    _pointB = CGPointMake(self.centerX, self.centerY-_turnR);//B点
    _pointC = CGPointMake(self.centerX+_turnR*cos(M_PI_2/3.0), self.centerY+_turnR*sin(M_PI_2/3.0));//C点
    
    [self.layer addSublayer:self.bgLayer];
    
    [self.bgLayer addSublayer:self.circleLayer];
    [self.bgLayer addSublayer:self.leftLayer];
    [self.bgLayer addSublayer:self.rightLayer];
    [self.bgLayer addSublayer:self.bottomLayer];
    [self.bgLayer addAnimation:self.turnAnimation forKey:nil];
}
-(CAShapeLayer *)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.frame = self.frame;
        _bgLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _bgLayer;
}
-(CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center radius:80.0f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        [circlePath closePath];
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.path = circlePath.CGPath;
        _circleLayer.backgroundColor = [UIColor clearColor].CGColor;
        _circleLayer.fillColor       = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _circleLayer.lineWidth   = 5.0f;
        _circleLayer.lineCap = kCALineCapRound;
        _circleLayer.lineJoin = kCALineJoinRound;
        [_circleLayer addAnimation:self.animation forKey:nil];

    }
    return _circleLayer;
}

-(CABasicAnimation *)animation{
    if (!_animation) {
        _animation  = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.fromValue = @0.0;
        _animation.toValue = @1.0;
        _animation.autoreverses = NO;//default
        _animation.duration = 1.5;
    }
    return _animation;
}
-(CABasicAnimation *)turnAnimation{//开始旋转
    if (!_turnAnimation) {
        _turnAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _turnAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        _turnAnimation.duration = 1.5;
        _turnAnimation.cumulative = YES;
       // _turnAnimation.delegate = self;
        _turnAnimation.repeatCount = MAXFLOAT;
    }
    return _turnAnimation;
}

-(CAShapeLayer *)leftLayer{
    if (!_leftLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX - _turnR/cos(M_PI_2/3.0), self.centerY-_turnR*sin(M_PI_2/3.0)) ;
        UIBezierPath *leftPath = [UIBezierPath bezierPath];
        [leftPath moveToPoint:CGPointMake(_pointA.x-5.0, _pointA.y+25.0)];
        [leftPath addQuadCurveToPoint:_pointB controlPoint:controlPoint];
        _leftLayer = [CAShapeLayer layer];
        _leftLayer.path = leftPath.CGPath;
        _leftLayer.backgroundColor = [UIColor clearColor].CGColor;
        _leftLayer.fillColor       = [UIColor clearColor].CGColor;
        _leftLayer.strokeColor = [UIColor whiteColor].CGColor;
        _leftLayer.lineWidth   = 20.0f;
        [_leftLayer addAnimation:self.animation forKey:nil];
    }
    return _leftLayer;
}
-(CAShapeLayer *)rightLayer{
    if (!_rightLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX, self.centerY+_turnR) ;
        UIBezierPath *rightPath = [UIBezierPath bezierPath];
        [rightPath moveToPoint:CGPointMake(_pointC.x+25.0, _pointC.y-5.0)];
        [rightPath addQuadCurveToPoint:_pointA controlPoint:controlPoint];
        _rightLayer = [CAShapeLayer layer];
        _rightLayer.path = rightPath.CGPath;
        _rightLayer.backgroundColor = [UIColor clearColor].CGColor;
        _rightLayer.fillColor       = [UIColor clearColor].CGColor;
        _rightLayer.strokeColor = [UIColor whiteColor].CGColor;
        _rightLayer.lineWidth   = 20.0f;
        [_rightLayer addAnimation:self.animation forKey:nil];
    }
    return _rightLayer;
}

-(CAShapeLayer *)bottomLayer{
    if (!_bottomLayer) {
        CGPoint controlPoint = CGPointMake(self.centerX + _turnR/cos(M_PI_2/3.0), self.centerY-_turnR*sin(M_PI_2/3.0)) ;
        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(_pointB.x-20.0, _pointB.y-20.0)];
        [bottomPath addQuadCurveToPoint:_pointC controlPoint:controlPoint];
        
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.path = bottomPath.CGPath;
        _bottomLayer.backgroundColor = [UIColor clearColor].CGColor;
        _bottomLayer.fillColor       = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = [UIColor whiteColor].CGColor;
        _bottomLayer.lineWidth   = 20.0f;
        [_bottomLayer addAnimation:self.animation forKey:nil];
        
    }
    return _bottomLayer;
}

```
### 加载 Logo 动画 loadingView
![加载loadView ](https://github.com/azheng51714/MACProject/blob/master/pic/loadingView.gif)
