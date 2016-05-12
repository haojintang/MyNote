#pop动画
##1.基本简介
- 使用原理先不深究，pop不是CoreAnimation的简单封装，他可以对任意Object进行动画，以后细读pop源码
- 为什么使用pop，不满足Apple自身动画框架的单调，pop致力于创造一个逼真的、充满物理效应的体验。pop动画极为流畅，其秘密在于Engine中的popAnimator里，POP通过CADisplayLink高达60FPS的特性，打造了一个游戏级别的动画引擎
- springBounciness：【0，20】，default 4
- springSpeed：【0，20】，default 12，动画的速度
http://www.cocoachina.com/industry/20140527/8565.html
http://www.cocoachina.com/industry/20140704/9034.html
