//
//  ViewController.m
//  导航模态连用获取window当前vc
//
//  Created by 惊蛰 on 16/11/27.
//  Copyright © 2016年 Miao. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn=[[UIButton alloc]initWithFrame:self.view.frame];
    btn.backgroundColor=[UIColor whiteColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)click
{
    
    ViewController1 *vc=[[ViewController1 alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
