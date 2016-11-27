//
//  ViewController1.m
//  导航模态连用获取window当前vc
//
//  Created by 惊蛰 on 16/11/27.
//  Copyright © 2016年 Miao. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // [self getCurrentVC];
    ViewController2 *vc=[[ViewController2 alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
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
                }
            }
        }

        if ([[view nextResponder] isKindOfClass:[UIViewController class]]) {
            return [view nextResponder];
        }
    }
    return window.rootViewController;
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
