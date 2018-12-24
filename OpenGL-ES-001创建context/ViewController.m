//
//  ViewController.m
//  OpenGL-ES-001创建context
//
//  Created by zhongding on 2018/12/24.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong ,nonatomic) EAGLContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     //EAGLContent是苹果在ios平台下实现的opengles渲染层，用于渲染结果在目标surface上的更新
     kEAGLRenderingAPIOpenGLES1 ->OpenGL ES 1.0，固定管线
     kEAGLRenderingAPIOpenGLES2 ->OpenGL ES 2.0
     kEAGLRenderingAPIOpenGLES3 ->OpenGL ES 3.0
     
     */
    //新建OpenGL ES上下文
    self.context = [[EAGLContext alloc] initWithAPI:(kEAGLRenderingAPIOpenGLES3)];
    
    if(self.context == nil){
        NSLog(@"初始化context出错");
        return;
    }

    //创建一个OpenGL ES上下文并将其分配给从storyboard加载的视图
    //注意：这里需要把stroyBoard记得添加为GLKView
    GLKView *view = (GLKView*)self.view;
    
    //配置视图创建的渲染缓冲区
    /*
     OpenGL ES 另一个缓存区，深度缓冲区。帮助我们确保可以更接近观察者的对象显示在远一些的对象前面。
     （离观察者近一些的对象会挡住在它后面的对象）
     默认：OpenGL把接近观察者的对象的所有像素存储到深度缓冲区，当开始绘制一个像素时，它（OpenGL）
     首先检查深度缓冲区，看是否已经绘制了更接近观察者的什么东西，如果是则忽略它（要绘制的像素，
     就是说，在绘制一个像素之前，看看前面有没有挡着它的东西，如果有那就不用绘制了）。否则，
     把它增加到深度缓冲区和颜色缓冲区。
     缺省值是GLKViewDrawableDepthFormatNone，意味着完全没有深度缓冲区。
     但是如果你要使用这个属性（一般用于3D游戏），你应该选择GLKViewDrawableDepthFormat16
     或GLKViewDrawableDepthFormat24。这里的差别是使用GLKViewDrawableDepthFormat16
     将消耗更少的资源，但是当对象非常接近彼此时，你可能存在渲染问题（）
     */
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    view.context = self.context;
    
    [EAGLContext setCurrentContext:self.context];
    
    //开启深度测试，就是让离你近的物体可以遮挡离你远的物体。
    glEnable(GL_DEPTH_TEST);
    
    //设置surface的清除颜色，也就是渲染到屏幕上的背景色。
    glClearColor(1, 0.1f, 1, 1);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    //清除surface内容，恢复至初始状态。
    glClear(GL_DEPTH_BUFFER_BIT|GL_COLOR_BUFFER_BIT);
}



@end
