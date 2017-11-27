//
//  CPageViewControl.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/11.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "CPageViewControl.h"
#import "ResultModel.h"
#import "ListResultModel.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshBackNormalFooter.h"

@interface CPageViewControl ()

@end

@implementation CPageViewControl
@synthesize lstData,pageNo;

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.actionName){
            [self hideLoadM];
            [self loadData];
    }
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tab=[self tab];
}

- (UITableView*) tab
{
    if (!_tab){
        if (self.isGroup){
            _tab=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        }else{
            _tab=[UITableView new];
        }
        [self.view addSubview:_tab];
        [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.and.bottom.equalTo(self.view);
        }];
        _tab.dataSource=self;
        _tab.delegate=self;
        _tab.tableFooterView=[UIView new];
        _tab.scrollsToTop=YES;
        _tab.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tab.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    }
    return _tab;
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lstData.count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
#pragma mark - DZNEmptyDataSetSource Methods

//- (UIImage*) buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    return [UIImage imageNamed:@"icon_Default_Refresh"];
//}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    switch (self.noDataMode) {
        case HNoDataModeDefault://无数据
        {
            return  [UIImage imageNamed:@"bg_noData"];
        }
        case HNoDataModeNoCartData://购物车空
        {
            return [UIImage imageNamed:@"bg_noCart"];
        }
        case HNoDataModeNoOrderData://无订单
        {
            return [UIImage imageNamed:@"bg_noOrder"];
        }
        case HNoDataModeNoSearchResult://搜索无结果
        {
            return [UIImage imageNamed:@"bg_noSearch"];
        }
        default:
            return [UIImage imageNamed:@"bg_noData"];
    }
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

#pragma mark - DZNEmptyDataSetSource Methods

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    [self showLoadingHUDWithTitle:nil SubTitle:nil];
//    [self loadData];
//}
#pragma mark 加载数据
/**
 *  加载数据
 */
- (void) loadData
{
    
    //    lstData=[[NSMutableArray alloc] initWithCapacity:0];
    pageNo=1;
    [self.tab.mj_footer resetNoMoreData];
    [self beforeLoadData];
    HHttpRequest *request=[HHttpRequest new];
    NSMutableArray *dic=[[NSMutableArray alloc] initWithArray:self.dicArray];
    [dic addObject:[NSString stringWithFormat:@"%d",pageNo]];
    [dic addObject:[NSString stringWithFormat:@"%@",kPageSize]];
    [request httpPostListRequestWithActionName:self.actionName
                                     andJsonString:self.moduleName
                                   andPramater:dic
                          andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {//无数据或者数据错误
                              
                              self.tab.emptyDataSetDelegate=self;
                              self.tab.emptyDataSetSource=self;
                              lstData=[[NSMutableArray alloc] initWithCapacity:0];
                              [self.tab reloadData];
                              [self hideLoadM];
                              [self afterFailLoadData:responseObject];
                              [self.tab.mj_header endRefreshing];
                              ResultModel *result=[ResultModel objectWithKeyValues:responseObject];
                              [self showErrorHUDWithTitle:result.msg SubTitle:nil Complete:nil];
                          }
                     andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {//请求成功
                         self.tab.emptyDataSetDelegate=self;
                         self.tab.emptyDataSetSource=self;
                         [self hideLoadM];
                         //          ListResultModel *result=[ListResultModel objectWithKeyValues:responseObject];
                             lstData=[[responseObject objectForKey:@"results"] mutableCopy];
                         
                         [self.tab reloadData];
                         [self afterSuccessLoadData:responseObject];
                         [self.tab.mj_header endRefreshing];
                     }
                      andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {//请求失败
                          [self.tab.mj_header endRefreshing];
                          [self.tab reloadData];
                          [self hideLoadM];
                      }];
    }
- (void) beforeLoadData
{
    
}
- (void) afterSuccessLoadData:(id)result
{
    
}
- (void) afterSuccessLoadMoreData:(id)result
{
    
}
- (void) afterFailLoadData:(id)result{
    
}
- (void) afterFailLoadMoreData:(id)result{
    
}
- (void) afterFailReLoadData
{
    
}
/**
 *  加载更多数据
 */
- (void) loadMoreData
{
    HHttpRequest *request=[HHttpRequest new];
    pageNo+=1;
    NSMutableArray *dic=[[NSMutableArray alloc] initWithArray:self.dicArray];
    [dic addObject:[NSString stringWithFormat:@"%d",pageNo]];
    [dic addObject:[NSString stringWithFormat:@"%@",kPageSize]];
    [request httpPostListRequestWithActionName:self.actionName
                                 andJsonString:self.moduleName
                                   andPramater:dic
                           andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {//无数据或者数据错误
                               [self.tab.mj_footer endRefreshingWithNoMoreData];
                                                   }
                      andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {//请求成功
                          [self.tab.mj_footer endRefreshing];
                          //          ListResultModel *result=[ListResultModel objectWithKeyValues:responseObject];
                          
                          
                              [lstData addObjectsFromArray:[[responseObject objectForKey:@"results"] mutableCopy]];
                              if ([(NSArray *)[responseObject objectForKey:@"results"] count]<1) {
                                  [self.tab.mj_footer endRefreshingWithNoMoreData];
                              }
                          
                          [self.tab reloadData];
                          [self afterSuccessLoadMoreData:responseObject];
                      }
                       andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {//请求失败
                           [self.tab.mj_footer endRefreshing];
                       }];
    }

- (void) reloadData
{
    if (lstData==nil){
        lstData=[[NSMutableArray alloc] initWithCapacity:0];
        [self.tab reloadData];
    }
    
    HHttpRequest *request=[HHttpRequest new];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:self.dicParamters];
    [dic setObject:@([kPageSize intValue]*pageNo) forKey:@"num"];
    [dic setObject:@"1" forKey:@"page"];
    
    if (self.isPost) {
        [request  httpPostRequestWithActionName:self.actionName
                                    andPramater:dic
                           andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {//无数据或者数据错误
                               self.tab.emptyDataSetDelegate=self;
                               self.tab.emptyDataSetSource=self;
                               lstData=[[NSMutableArray alloc] initWithCapacity:0];
                               [self.tab reloadData];
                               [self afterFailReLoadData];
                               ResultModel *result=[ResultModel objectWithKeyValues:responseObject];
                               [self showErrorHUDWithTitle:result.msg SubTitle:nil Complete:nil];
                           }
                      andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {//请求成功
                          //                 ListResultModel *result=[ListResultModel objectWithKeyValues:responseObject];
                          if ([self.sortClass isEqualToString:@"1"]) {
                              lstData=[responseObject mutableCopy];
                          }else{
                              lstData=[[responseObject objectForKey:@"message"] mutableCopy];
                          }
                          
                          [self afterSuccessLoadData:responseObject];
                          [self.tab reloadData];
                          [self hideLoadM];
                      }
                       andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {//请求失败
                       }];
    }
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
