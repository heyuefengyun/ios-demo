//
//  ViewController5.m
//  导航模态连用获取window当前vc
//
//  Created by 惊蛰 on 16/11/27.
//  Copyright © 2016年 Miao. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()

@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    for (UIView *view in [window subviews]) {
        NSLog(@"%@==%@",[view class],[[view nextResponder] class]);
        if ([view isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            for (UIView *view1 in [view subviews]) {
                if ([view1.nextResponder isKindOfClass:[UIViewController class]]) {
                    NSLog(@"%@--%@",[view1 class],[[view1 nextResponder] class]);
                      return [view1 nextResponder];
                }
            }
        }
        /*
         2016-11-27 14:16:30.907 导航模态连用获取window当前vc[29382:815175] UITransitionView==UIWindow
         2016-11-27 14:16:32.371 导航模态连用获取window当前vc[29382:815175] UITransitionView==UIWindow
         2016-11-27 14:16:33.845 导航模态连用获取window当前vc[29382:815175] UITransitionView==UIWindow
         2016-11-27 14:16:41.710 导航模态连用获取window当前vc[29382:815175] UITransitionView==UIWindow
         2016-11-27 14:16:46.707 导航模态连用获取window当前vc[29382:815175] UIView--ViewController5
         */
        /*
         总结1：只要过程当中用了模态
         for (UIView *view in [window subviews])这句的view的类型一定是UITransitionView   UITransitionView的nextresponder肯定是window 毕竟是window的子视图  所以只能for in UITransitionView获取UITransitionView的子视图  除了最后一个UITransitionView  前面的UITransitionView的子视图全部为空
         2：当最顶上是导航时如Viewcontroller4中 UITransitionView的子视图是navigationcontroller的UILayoutContainerView  UILayoutContainerView的nextresponder当然就是导航了  既这时候试图层级顺序先
             0 uiwindow
             1 UITransitionView
             2 UILayoutContainerView
             3 导航的栈顶试图

         3：当用过导航在模态时UILayoutContainerView 不作为uiwindow的子视图   获取到的是最后一个UITransitionView
         4：猜测当将导航作为window的根视图切中间不含导航时可直接for in window的子视图获得导航 也可以直接获取根视图控制器获取导航
         5：导航后模态道理同1
         6：tabbar和模态连用时  tabbar应该是和导航同样的位置
         7: 模态是直接跳出层级关系的感觉  模态一次多一个UITransitionView作为window的子视图
         8：所以想获取当前的viewcontroller（获取到导航也算）
            1：要先判断正常窗口
            2：没模态则直接for in 子视图 判断子视图的nextresponder
            3：中间过程在复杂点模态导航无限连用的话  第2不会return no
               这是后for in window 获取UITransitionView   在for in UITransitionView  获取最后一个UITransitionView上的子视图  这时候的nextresponder肯定是uiviewcontroller类型
         10：这种时候处理通知  如果全导航 就用导航 如果不是全导航可以经过vc.presentingviewcontroller或者vc.navigationcontroller来判断当前vc是处在模态还是处在导航中  然后进行相应的通知详情试图处理
         
         */
        if ([[view nextResponder] isKindOfClass:[UIViewController class]]) {
            return [view nextResponder];
        }
    }
    return window.rootViewController;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getCurrentVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
