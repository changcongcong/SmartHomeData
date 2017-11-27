//
//  CPageViewControl.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/11.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "CViewControl.h"
#import "UIScrollView+EmptyDataSet.h"

@interface CPageViewControl : CViewControl

<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic,strong) UITableView *tab;
@property(nonatomic,strong) NSMutableArray *lstData;
@property(nonatomic,readwrite) int pageNo;
@property(nonatomic,strong) NSMutableDictionary *dicParamters;
@property(nonatomic,strong) NSArray *dicArray;
@property(nonatomic,copy) NSString *sortName;
@property(nonatomic,copy) NSString *moduleName;
@property(nonatomic,copy) NSString *actionName;
@property(nonatomic,readwrite) HNoDataMode noDataMode;

//1为专家预约列表
@property(nonatomic,copy) NSString *sortClass;
///是否使用分组视图
@property(nonatomic,readwrite) BOOL isGroup;
///是否post数据
@property(nonatomic,readwrite) BOOL isPost;
///是否在画面显示时自动刷新数据
@property(nonatomic,readwrite) BOOL autoReloadDataOnViewWillAppear;

- (void) beforeLoadData;
- (void) afterSuccessLoadData:(id)result;
- (void) afterSuccessLoadMoreData:(id)result;
- (void) afterFailLoadData:(id)result;
- (void) afterFailLoadMoreData:(id)result;
- (void) afterFailReLoadData;
///重新加载数据
- (void) reloadData;


@end
