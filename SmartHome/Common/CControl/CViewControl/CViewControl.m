//
//  CViewControl.m
//  SmartHome
//
//  Created by waterpant on 2017/11/6.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "CViewControl.h"
#import "NSString+Check.h"
#import "HNavigationBar.h"
#import "MBProgressHUD+WEExpand.h"

@interface CViewControl ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIImageView *imgLoading;
@property(nonatomic,strong) UIImageView *imgCustom;

@end

@implementation CViewControl

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_Cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem_Click)];
    //    self.navigationItem.rightBarButtonItem=rightBarItem;
    
    //设置导航栏返回按钮样式
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_NavBar_Left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItem_Click)];
    self.navigationItem.leftBarButtonItem=leftBarItem;
    
    [(HNavigationBar*)self.navigationController.navigationBar setNavigationBarWithColor:[UIColor colorWithHexString:@"f57f27"]];
        //设定导航栏为非隐藏
        [(HNavigationBar*)self.navigationController.navigationBar setHidden:NO];
    //设定导航栏为非透明
    [(HNavigationBar*)self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f57f27"]]];
    
    [self.tabBarController.tabBar setTranslucent:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self.tabBarController.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];//防止使用拍照控件后导致状态栏隐藏
    //设置导航栏标题字体和颜色
    NSDictionary * dictTitle=@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes=dictTitle;
    //设置导航栏左右按钮字体和颜色
    NSDictionary * dicLeftRight=@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                                  NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:dicLeftRight forState:UIControlStateNormal];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //背景图
    self.view.backgroundColor=[UIColor colorWithHexString:@"fff4e9"];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
        
    }else{
        return YES;
    }
}

- (void) leftBarItem_Click
{
    //    NSMutableArray *vcs=[[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f4f4f4"]];
}


- (UIImageView*) imgLoading
{
    if (!_imgLoading){
        _imgLoading=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 65)];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=11; i++) {
            NSString *imgName=@"";
            if (i>9){
                imgName=[NSString stringWithFormat:@"%lu",(unsigned long)i];
            }else{
                imgName=[NSString stringWithFormat:@"0%lu",(unsigned long)i];
            }
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%@", imgName]];
            [refreshingImages addObject:image];
        }
        
        _imgLoading.animationImages=refreshingImages;
        _imgLoading.animationDuration=1.1;
        _imgLoading.animationRepeatCount=3000;
    }
    [_imgLoading stopAnimating];
    [_imgLoading startAnimating];
    return _imgLoading;
}
- (void) showLoadingHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle;
{
    [MBProgressHUD showMessage:title view:self.view];
}

- (UIImageView*) imgCustom
{
    if (!_imgCustom){
        _imgCustom=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    }
    return _imgCustom;
}

- (void) showOkHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle
{
    [self showOkHUDNotAutoHideWithTitle:title SubTitle:subTitle];
//    [self.hudCustom hide:YES afterDelay:1];
}

- (void) showOkHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle Complete:(void(^)())complete
{
//    [self showOkHUDWithTitle:title SubTitle:subTitle];
//    [self.hudCustom showAnimated:YES whileExecutingBlock:^{
//        sleep(1);
//    } completionBlock:^{
//        if (complete) {
//            complete();
//        }
//    }];
}

- (void) showErrorHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle Complete:(void(^)())complete{
     [MBProgressHUD showError:title  toView:self.view];
}

- (BOOL) showCheckErrorHUDWithTitle:(NSString*)title SubTitle:(NSString*)subTitle checkTxtField:(UITextField *)txt {
    NSString *strTxtCheck=txt.text;
    strTxtCheck = strTxtCheck?strTxtCheck:@"";
    if ([strTxtCheck checkIsEmpty]) {
        
        [self showErrorHUDWithTitle:title SubTitle:subTitle Complete:^{
            [txt becomeFirstResponder];
        }];
        return YES;
    }else{
        return NO;
    }
}

- (void) showOkHUDNotAutoHideWithTitle:(NSString*)title SubTitle:(NSString*)subTitle
{
//    self.hudCustom.labelText = title;
//    self.hudCustom.detailsLabelText = subTitle;
//    self.imgCustom.image=[UIImage imageNamed:@"icon_ok"];
//    [self.hudCustom show:YES];
}
- (void) showErrorHUDNotAutoHideWithTitle:(NSString*)title SubTitle:(NSString*)subTitle
{
      [MBProgressHUD showError:title  toView:self.view];
}
- (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

-(BOOL) dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}

-(void)hideLoadM{
    [MBProgressHUD hideHUD];
    [MBProgressHUD hideHUDForView:self.view];
}


@end
