//
//  GuaranteeVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/13.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeVC.h"
#import "GuaranteeAddVC.h"
#import "GuaranteeCell.h"
#import "GuaranteeDetailVC.h"
#import "GuaranteeModel.h"
#import "NSString+Check.h"

@interface GuaranteeVC ()

@end

@implementation GuaranteeVC

-(void)viewWillAppear:(BOOL)animated{
    self.actionName=@"/photo/data/procedure";
    self.moduleName=@"p";
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    NSString *accToken=loginRe.id;
    
    self.dicArray=@[@"R2016001",accToken,loginRe.housingId];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self.tabBarController.tabBar setTranslucent:YES];
    self.navigationItem.title=@"我的报修";
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏返回按钮样式
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_creat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItem_Click)];
    self.navigationItem.rightBarButtonItem=leftBarItem;
    self.tab.separatorColor=[UIColor clearColor];
    self.view.backgroundColor=self.tab.backgroundColor=[UIColor colorWithHexString:@"fff4e9"];
}

-(void)rightBarItem_Click{
    GuaranteeAddVC *add=[[GuaranteeAddVC alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}


#pragma mark - 列表视图代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lstData.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"MyFansCell";
    GuaranteeCell *cell=(GuaranteeCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell){
        cell=[[GuaranteeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=self.view.backgroundColor;
    }
    
    GuaranteeModel *model=[GuaranteeModel yy_modelWithJSON:self.lstData[indexPath.row]];
    model.desc=[self.lstData[indexPath.row] objectForKey:@"description"];
    cell.model=model;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuaranteeDetailVC *detail=[[GuaranteeDetailVC alloc]init];
    GuaranteeModel *model=[GuaranteeModel yy_modelWithJSON:self.lstData[indexPath.row]];
    detail.repairId=model.id;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"icon_aduate_weixiu"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"暂无报告修内容";
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, str.length)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, str.length)];
    return attrStr;//@"暂无保修内容";
}

@end
