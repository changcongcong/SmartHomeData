//
//  Tabbar.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/8.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "Tabbar.h"
#import "CommunityVC.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "CViewControl.h"
#import "HNavigationBar.h"

@interface Tabbar ()

@end

@implementation Tabbar

- (id) init
{
    if (self=[super init]){
        
        //首页
        HomeVC* homeVC = [[HomeVC alloc] init];
        UINavigationController* nav1 = [[UINavigationController alloc] initWithNavigationBarClass:[HNavigationBar class] toolbarClass:nil];
        [nav1 setViewControllers:@[ homeVC ]];
        nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[[UIImage imageNamed:@"nav_icon1_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"nav_icon1_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav1.tabBarItem.title=@"首页";
        
        //订单
        CommunityVC* activityIndexVC = [[CommunityVC alloc] init];
        UINavigationController* nav2 = [[UINavigationController alloc] initWithNavigationBarClass:[HNavigationBar class] toolbarClass:nil];
        [nav2 setViewControllers:@[ activityIndexVC ]];
        nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[[UIImage imageNamed:@"nav_icon2_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"nav_icon2_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav2.tabBarItem.title=@"社区";
        
        //发现
        MineVC* driveIndexVC = [[MineVC alloc] init];
        UINavigationController* nav3 = [[UINavigationController alloc] initWithNavigationBarClass:[HNavigationBar class] toolbarClass:nil];
        [nav3 setViewControllers:@[ driveIndexVC ]];
        nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[[UIImage imageNamed:@"nav_icon3_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"nav_icon3_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav3.tabBarItem.title=@"我的";
        
        NSMutableDictionary *attrs1 = [NSMutableDictionary dictionary];
        attrs1[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"666666"];
        attrs1[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        
        NSMutableDictionary *attrs2 = [NSMutableDictionary dictionary];
        attrs2[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"f89537"];
        attrs2[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        
        [[UITabBarItem appearance] setTitleTextAttributes:attrs1 forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:attrs2 forState:UIControlStateSelected];
        
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 0, kScreenW+10, 50)];
        backView.image = [UIImage imageNamed:@"icon_hsj_dibu07.png"];//[UIColor colorWithHexString:@"e0e0e0"];
        [self.tabBar insertSubview:backView atIndex:0];
        
        self.viewControllers = @[ nav1, nav2, nav3];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
            UIImageView *ima = (UIImageView *)view;
            //            ima.backgroundColor = [UIColor redColor];
            ima.hidden = YES;
        }
    }
}

//6.0之后系统调用该方法
- (BOOL)shouldAutorotate
{
    //返回顶层视图的设置（顶层控制器需要覆盖shouldAutorotate方法）
    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
    CViewControl *topVC=(CViewControl *)nav.topViewController;
    return topVC.shouldAutorotate;
}

//6.0之后系统调用该方法
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //返回顶层视图支持的旋转方向
    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
    CViewControl *topVC=(CViewControl*)nav.topViewController;
    return topVC.supportedInterfaceOrientations;
}

@end
