//
//  GuaranteeAddVC.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeAddVC.h"
#import "CLine.h"
#import "YYText.h"
#import "ZLPhotoActionSheet.h"
#import "YBPickerTool.h"
#import "WETextView.h"
#import "SMutton.h"
#import "ShadowView.h"

@interface GuaranteeAddVC (){
//    UIButton *btnDoorIn;
//    UIButton *btnDoorOut;
    NSMutableArray *arrayButtonOne;
    NSMutableArray *arrayButtonTwo;
    NSMutableArray *arrayButtonThree;
    WETextView *txtView;
    UIImageView *imgSelectOne,*imgSelectTwo,*imgSelectThree,*imgSelectFour;
    NSMutableArray *arrayPic;
    BOOL isDoorType;
    BOOL isRepairType;
    BOOL isRepairLocation;
    BOOL isRepairTime;
    NSMutableArray* arrayDoorType;
    NSMutableArray* arrayRepairType;
    NSMutableArray* arrayRepairLocation;
    NSMutableArray* arrayRepairTime;
    UIView* viewDoorType;
    UIView* viewRepairType;
    UIView* viewRepairLocation;
    NSIndexPath *indexPathSelect;
    UILabel *lblBaoTimeDetail;
    UILabel *lblBaoXiu;
    CLine *lineOne;
    UILabel *lblBaoWeizhi;
    CLine *lineTwo;
    UIView *viewWhileBG;
}

@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;

@end

@implementation GuaranteeAddVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"我的报修";
}

-(void)viewDidLoad{
    [super viewDidLoad];
    isDoorType=NO;
    isRepairType=NO;
    isRepairLocation=NO;
    isRepairTime=NO;
    [arrayDoorType removeAllObjects];
    [arrayRepairType removeAllObjects];
    [arrayRepairLocation removeAllObjects];
    [arrayRepairTime removeAllObjects];
    [self showLoadingHUDWithTitle:@"正在加载数据" SubTitle:nil];
    [self loadDataDoorType];
    [self loadDataRepairType];
    [self loadDataRepairLocation];
    [self loadDataRepairTime];
}

- (void) createView:(UIView*)contentView
{
    //白色背景
    viewWhileBG=[[UIView alloc]init];
    viewWhileBG.layer.cornerRadius=5;
    viewWhileBG.layer.masksToBounds=NO;
    viewWhileBG.backgroundColor=[UIColor whiteColor];
    [contentView addSubview:viewWhileBG];
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.top.equalTo(contentView).offset(10);
    }];
    
    viewWhileBG.layer.shadowColor = [UIColor colorWithHexString:@"f57f27"].CGColor;//阴影颜色
    viewWhileBG.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    viewWhileBG.layer.shadowOpacity = 0.5;//不透明度
    viewWhileBG.layer.shadowRadius = 10.0;//半径
    
    
    viewDoorType=[[UIView alloc]init];
    [viewWhileBG addSubview:viewDoorType];
    [viewDoorType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(100);
        make.top.equalTo(viewWhileBG).offset(30);
        make.right.equalTo(viewWhileBG);
        make.height.mas_equalTo(23);
    }];
    
//    //室内，室外按钮
//    btnDoorIn=[[UIButton alloc]init];
//    [btnDoorIn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f57f27"]] forState:UIControlStateSelected];
//    [btnDoorIn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    btnDoorIn.layer.masksToBounds=YES;
//    btnDoorIn.selected=YES;
//    btnDoorIn.layer.cornerRadius=3;
//    [btnDoorIn setTitle:@"室内" forState:UIControlStateNormal];
//    btnDoorIn.layer.borderWidth=1;
//    btnDoorIn.layer.borderColor=[UIColor colorWithHexString:@"f57f27"].CGColor;
//    [btnDoorIn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [btnDoorIn setTitleColor:[UIColor colorWithHexString:@"d5d5d5"] forState:UIControlStateNormal];
//    [btnDoorIn addTarget:self action:@selector(btnDoorInClick) forControlEvents:UIControlEventTouchUpInside];
//    btnDoorIn.titleLabel.font=[UIFont systemFontOfSize:13];
//    [viewWhileBG addSubview:btnDoorIn];
//    [btnDoorIn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(viewWhileBG).offset(100);
//        make.top.equalTo(viewWhileBG).offset(30);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(25);
//    }];
//    
//    btnDoorOut=[[UIButton alloc]init];
//    [btnDoorOut setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f57f27"]] forState:UIControlStateSelected];
//    btnDoorOut.layer.masksToBounds=YES;
//    btnDoorOut.layer.cornerRadius=3;
//    [btnDoorOut setTitle:@"室外" forState:UIControlStateNormal];
//    btnDoorOut.layer.borderWidth=1;
//    btnDoorOut.layer.borderColor=[UIColor colorWithHexString:@"d5d5d5"].CGColor;
//    [btnDoorOut setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [btnDoorOut setTitleColor:[UIColor colorWithHexString:@"d5d5d5"] forState:UIControlStateNormal];
//    [btnDoorOut addTarget:self action:@selector(btnDoorOutCLick) forControlEvents:UIControlEventTouchUpInside];
//    btnDoorOut.titleLabel.font=[UIFont systemFontOfSize:13];
//    [viewWhileBG addSubview:btnDoorOut];
//    [btnDoorOut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(viewWhileBG).offset(160);
//        make.top.equalTo(viewWhileBG).offset(30);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(25);
//    }];
    
    arrayButtonOne=[[NSMutableArray alloc]init];
    arrayButtonTwo=[[NSMutableArray alloc]init];
    arrayButtonThree=[[NSMutableArray alloc]init];

    
    //保修类型
    lblBaoXiu=[[UILabel alloc]init];
    lblBaoXiu.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoXiu.font=[UIFont cFontWithSize:13];
    lblBaoXiu.text=@"报修类型";
    [viewWhileBG addSubview:lblBaoXiu];
    [lblBaoXiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(viewDoorType.mas_bottom).offset(20);
    }];
    
    viewRepairType=[[UIView alloc]init];
    [viewWhileBG addSubview:viewRepairType];
    [viewRepairType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(100);
        make.top.equalTo(lblBaoXiu);
        make.right.equalTo(viewWhileBG);
    }];
    

//    NSArray *tarr = @[@"水电维修",@"线路维修",@"家居维修",@"家电维修",@"其他"];
//    
//    float butX = 100;
//    float butY = 70;
//    for(int i = 0; i < tarr.count; i++){
//        
//        //宽度自适应
//        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//        CGRect frame_W = [tarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
//        
//        if (butX+frame_W.size.width+10>kScreenW-20) {
//            
//            butX = 100;
//            
//            butY += 33;
//        }
//        
//        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+10, 23)];
//        [but setTitle:tarr[i] forState:UIControlStateNormal];
//        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [but setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"3196fd"]] forState:UIControlStateSelected];
//        [but setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
//        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//        but.titleLabel.font = [UIFont systemFontOfSize:13];
//        but.layer.cornerRadius = 2;
//        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        but.layer.borderWidth = 1;
//        but.layer.masksToBounds=YES;
//        [viewWhileBG addSubview:but];
//        but.tag=i;
//        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (i==0) {
//            but.selected=YES;
//            but.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
//        }
//        [arrayButtonOne addObject:but];
//        butX = CGRectGetMaxX(but.frame)+10;
//    }
    
    //竖着的线
    lineOne=[[CLine alloc]init];
    lineOne.lineWidth=1;
    lineOne.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.left.equalTo(viewWhileBG).offset(15);
        make.height.mas_equalTo(1);
        make.top.equalTo(viewRepairType.mas_bottom).offset(20);
    }];
    
    //保修类型
    lblBaoWeizhi=[[UILabel alloc]init];
    lblBaoWeizhi.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoWeizhi.font=[UIFont cFontWithSize:13];
    lblBaoWeizhi.text=@"报修位置";
    [viewWhileBG addSubview:lblBaoWeizhi];
    [lblBaoWeizhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(lineOne.mas_bottom).offset(20);
    }];
    
    viewRepairLocation=[[UIView alloc]init];
    [viewWhileBG addSubview:viewRepairLocation];
    [viewRepairLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(100);
        make.top.equalTo(lblBaoWeizhi);
        make.right.equalTo(viewWhileBG);
        make.height.mas_equalTo(25);
    }];
    
//    NSArray *tarrLocation = @[@"卧室",@"厨房",@"客厅",@"阳台",@"卫生间",@"其他"];
//    
//    float butXLocation = 100;
//    float butYLocation = 160;
//    for(int i = 0; i < tarrLocation.count; i++){
//        
//        //宽度自适应
//        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//        CGRect frame_W = [tarrLocation[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
//        
//        if (butXLocation+frame_W.size.width+10>kScreenW-50) {
//            
//            butXLocation = 100;
//            
//            butYLocation += 33;
//        }
//        
//        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butXLocation, butYLocation, frame_W.size.width+10, 23)];
//        [but setTitle:tarrLocation[i] forState:UIControlStateNormal];
//        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [but setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"3196fd"]] forState:UIControlStateSelected];
//        [but setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
//        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//        but.titleLabel.font = [UIFont systemFontOfSize:13];
//        but.layer.cornerRadius = 2;
//        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        but.layer.borderWidth = 1;
//        [viewWhileBG addSubview:but];
//        but.tag=i;
//        [but addTarget:self action:@selector(butClickTwo:) forControlEvents:UIControlEventTouchUpInside];
//        if (i==0) {
//            but.selected=YES;
//            but.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
//        }
//        but.layer.masksToBounds=YES;
//        [arrayButtonTwo addObject:but];
//        butXLocation = CGRectGetMaxX(but.frame)+10;
//    }

    //竖着的线
    lineTwo=[[CLine alloc]init];
    lineTwo.lineWidth=1;
    lineTwo.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.left.equalTo(viewWhileBG).offset(15);
        make.height.mas_equalTo(1);
        make.top.equalTo(viewRepairLocation.mas_bottom).offset(20);
    }];
    
    //预约时间
    UILabel *lblBaoTime=[[UILabel alloc]init];
    lblBaoTime.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoTime.font=[UIFont cFontWithSize:13];
    lblBaoTime.text=@"预约时间";
    [viewWhileBG addSubview:lblBaoTime];
    [lblBaoTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(lineTwo.mas_bottom).offset(20);
    }];
    
    //期望上门维护时间
    lblBaoTimeDetail=[[UILabel alloc]init];
    lblBaoTimeDetail.textColor=[UIColor colorWithHexString:@"999999"];
    lblBaoTimeDetail.font=[UIFont cFontWithSize:13];
    lblBaoTimeDetail.text=@"期望上门维修时间";
    [viewWhileBG addSubview:lblBaoTimeDetail];
    [lblBaoTimeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblBaoTime);
        make.left.equalTo(viewWhileBG).offset(110);
        make.height.mas_equalTo(50);
        make.right.equalTo(viewWhileBG);
    }];
    
    lblBaoTimeDetail.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapTimeDetail=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTimeDetailClick)];
    [lblBaoTimeDetail addGestureRecognizer:tapTimeDetail];
    
    UIImageView *imgRight=[[UIImageView alloc]init];
    imgRight.image=[UIImage imageNamed:@"icon_time_right.png"];
    [viewWhileBG addSubview:imgRight];
    [imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblBaoTimeDetail);
        make.right.equalTo(viewWhileBG).offset(-20);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(13);
    }];
    
    //竖着的线
    CLine *lineThree=[[CLine alloc]init];
    lineThree.lineWidth=1;
    lineThree.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineThree];
    [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.left.equalTo(viewWhileBG).offset(15);
        make.height.mas_equalTo(1);
        make.top.equalTo(lblBaoTime.mas_bottom).offset(20);
    }];

    txtView=[[WETextView alloc]init];
    txtView.placeholderText=@"如报修描述与事实不符，我们将照常收取上门费";
    txtView.placeholderFont=[UIFont cFontWithSize:14];
    txtView.placeholderTextColor=[UIColor colorWithHexString:@"cccccc"];
    txtView.font=[UIFont cFontWithSize:14];
    txtView.textColor=[UIColor colorWithHexString:@"333333"];
    [viewWhileBG addSubview:txtView];
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(20);
        make.top.equalTo(lineThree).offset(20);
        make.centerX.equalTo(viewWhileBG);
        make.height.mas_equalTo(80);
    }];

    CLine *lineFour=[[CLine alloc]init];
    lineFour.lineWidth=1;
    lineFour.lineStyle=UILineStyleHorizon;
    [viewWhileBG addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWhileBG);
        make.left.equalTo(viewWhileBG).offset(15);
        make.height.mas_equalTo(1);
        make.top.equalTo(txtView.mas_bottom).offset(10);
    }];
    
    imgSelectOne=[[UIImageView alloc]init];
    imgSelectOne.image=[UIImage imageNamed:@"creat_pic"];
    [viewWhileBG addSubview:imgSelectOne];
    [imgSelectOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(10);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lineFour.mas_bottom).offset(20);
    }];
    
    imgSelectOne.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapSelect=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelectClick)];
    [imgSelectOne addGestureRecognizer:tapSelect];
    
    imgSelectTwo=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectTwo];
    [imgSelectTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(75);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lineFour.mas_bottom).offset(20);
    }];
    
    imgSelectThree=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectThree];
    [imgSelectThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(140);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lineFour.mas_bottom).offset(20);
    }];
    
    imgSelectFour=[[UIImageView alloc]init];
    [viewWhileBG addSubview:imgSelectFour];
    [imgSelectFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWhileBG).offset(205);
        make.width.height.mas_equalTo(55);
        make.top.equalTo(lineFour.mas_bottom).offset(20);
    }];
    
    [viewWhileBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imgSelectOne).offset(45);
    }];
    
    UIButton *btnImprove=[[UIButton alloc]init];
    [btnImprove setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnImprove setTitle:@"提交" forState:UIControlStateNormal];
    [btnImprove addTarget:self action:@selector(btnImproveClick) forControlEvents:UIControlEventTouchUpInside];
    [btnImprove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnImprove.titleLabel.font=[UIFont cFontWithSize:15];
    [contentView addSubview:btnImprove];
    [btnImprove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(viewWhileBG.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    arrayPic=[[NSMutableArray alloc]init];
    arrayDoorType=[[NSMutableArray alloc]init];
    arrayRepairType=[[NSMutableArray alloc]init];
    arrayRepairLocation=[[NSMutableArray alloc]init];
    arrayRepairTime=[[NSMutableArray alloc]init];
}

-(void)btnDoorInClick{
//    if (!btnDoorIn.selected) {
//        btnDoorIn.selected=YES;
//        btnDoorOut.selected=NO;
//    }
}

-(void)btnDoorOutCLick{
//    if (!btnDoorOut.selected) {
//        btnDoorIn.selected=NO;
//        btnDoorOut.selected=YES;
//        btnDoorOut.layer.borderColor=[UIColor whiteColor].CGColor;
//        btnDoorIn.layer.borderColor=[UIColor colorWithHexString:@"d5d5d5"].CGColor;
//    }
}

-(void)butClickThree:(UIButton *)btnClick{
    for (UIButton *btn in arrayButtonThree) {
        btn.selected=NO;
        btn.layer.borderColor= [UIColor lightGrayColor].CGColor;
    }
    btnClick.selected=YES;
    btnClick.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
}

-(void)butClickTwo:(UIButton *)btnClick{
    for (UIButton *btn in arrayButtonTwo) {
        btn.selected=NO;
        btn.layer.borderColor= [UIColor lightGrayColor].CGColor;
    }
    btnClick.selected=YES;
    btnClick.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
}

-(void)tapTimeDetailClick{
    if (arrayRepairTime.count<1) {
        [self showErrorHUDWithTitle:@"请检查网络" SubTitle:nil Complete:nil];
        return ;
    }
    NSMutableArray *arrayRepairNowTime=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dicPar in arrayRepairTime) {
        [arrayRepairNowTime addObject:dicPar[@"displayValue"]];
    }
    
    [YBPickerTool show:@[[self getWeekDay], arrayRepairNowTime] didSelectBlock:^(NSIndexPath *indexPath) {
        lblBaoTimeDetail.tag=2;
        if (!indexPath) {
            lblBaoTimeDetail.text=[NSString stringWithFormat:@"明天 %@",arrayRepairNowTime[0]];
            return ;
        }
        lblBaoTimeDetail.text=[NSString stringWithFormat:@"%@ %@",[self getWeekDay][indexPath.row],arrayRepairNowTime[indexPath.section]];
        indexPathSelect=indexPath;
    }];
}

-(void)tapSelectClick{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 3;
    
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        //        strongify(weakSelf);
        //        strongSelf.arrDataSources = selectPhotos;
        //        strongSelf.lastSelectMoldels = selectPhotoModels;
        //        [strongSelf.collectionView reloadData];
        if (selectPhotos.count>0) {
            [self uploadPhontData:selectPhotos];
        }
        for (NSInteger iNumber=0; iNumber<selectPhotos.count; iNumber++) {
            UIImage *image=selectPhotos[iNumber];
            if (iNumber==0) {
                imgSelectOne.image=image;
            }
            
            if (iNumber==1) {
                imgSelectTwo.image=image;
            }
            
            if (iNumber==2) {
                imgSelectThree.image=image;
            }
            
            if (iNumber==3) {
                imgSelectFour.image=image;
            }
        }
        
    }];
}

-(void)uploadPhontData:(NSArray *)arrayPhoto{
    //1.设置请求参数
    [self showLoadingHUDWithTitle:@"正在上传图片信息" SubTitle:nil];
    [arrayPic removeAllObjects];
    NSDictionary *dict = @{@"files":arrayPhoto};
    //2.开始请求
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPosImageRequestWithActionName:@"photo/fileUploadDownLoad/fileImages" andPramater:dict andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        [self hideLoadM];
        [self showErrorHUDWithTitle:@"服务异常，请联系客服人员" SubTitle:nil Complete:nil];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        [self hideLoadM];
        LoginModel *model=[LoginModel yy_modelWithJSON:responseObject];
        if (![model.code isEqualToString:@"1"]) {
            [self showErrorHUDWithTitle:responseObject[@"errorMsg"] SubTitle:nil Complete:nil];
            return ;
        }
        arrayPic=[responseObject[@"results"] mutableCopy];
    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        [self hideLoadM];
    }];
}

-(void)loadDataRepairTime{
    [arrayRepairTime removeAllObjects];
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostNormalWithActionName:@"/dictionarys/dataDictionaryValueList.do?code=130"  andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairTime=YES;
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairTime=YES;
        arrayRepairTime=[responseObject mutableCopy];
    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        isRepairTime=YES;
    }];
}

-(NSArray *)getWeekDay{
    NSMutableArray *arrayWeek=[[NSMutableArray alloc]initWithCapacity:7];
    [arrayWeek addObject:@"明天"];
    [arrayWeek addObject:[self GetTomorrowDay:2]];
    [arrayWeek addObject:[self GetTomorrowDay:3]];
    [arrayWeek addObject:[self GetTomorrowDay:4]];
    [arrayWeek addObject:[self GetTomorrowDay:5]];
    [arrayWeek addObject:[self GetTomorrowDay:6]];
    [arrayWeek addObject:[self GetTomorrowDay:7]];
    return arrayWeek ;
    
}

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSInteger)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:([components day]+aDate)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM/dd"];
    NSString *dataBefor=[dateday stringFromDate:beginningOfWeek];
    
    NSArray *weekdays = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    [theComponents setDay:([components day]+aDate)];
    NSLog(@"%ld",(long)theComponents.weekday);
    NSString *dataAfter=[weekdays objectAtIndex:(theComponents.weekday+aDate-1)%7];
    return [NSString stringWithFormat:@"%@ %@",dataBefor,dataAfter];
}

-(void)loadDataDoorType{
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostNormalWithActionName:@"/dictionarys/dataDictionaryValueList.do?code=150"  andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
         isDoorType=YES;
        [self updateLoad];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
         isDoorType=YES;
        arrayDoorType =[responseObject mutableCopy];
        [self updateLoad];
    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
         isDoorType=YES;
        [self updateLoad];
    }];
}

//获取保修类型
-(void)loadDataRepairType{
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostNormalWithActionName:@"/dictionarys/dataDictionaryValueList.do?code=70"  andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairType=YES;
        [self updateLoad];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairType=YES;
        arrayRepairType =[responseObject mutableCopy];
        [self updateLoad];

    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        isRepairType=YES;
        [self updateLoad];
    }];
}

-(void)loadDataRepairLocation{
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostNormalWithActionName:@"/dictionarys/dataDictionaryValueList.do?code=80"  andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairLocation=YES;
        [self updateLoad];
    } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
        isRepairLocation=YES;
        arrayRepairLocation=[responseObject mutableCopy];
        [self updateLoad];

    } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
        isRepairLocation=YES;
        [self updateLoad];
    }];

}

-(void)updateLoad{
    if (!(isRepairType&&isDoorType&&isRepairLocation)) {
        return;
    }
    [self hideLoadM];

    float butX = 0;
    float butY = 0;
    UIButton *btnOneLast=[[UIButton alloc]init];
    for(int i = 0; i < arrayDoorType.count; i++){

        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [[arrayDoorType[i] objectForKey:@"displayValue"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];

        if (butX+frame_W.size.width+10>kScreenW-20) {

            butX = 100;

            butY += 33;
        }

        SMutton *but = [[SMutton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+10, 23)];
        [but setTitle:[arrayDoorType[i] objectForKey:@"displayValue"] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f57f27"]] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 2;
        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
        but.layer.borderWidth = 1;
        but.layer.masksToBounds=YES;
        [viewDoorType addSubview:but];
        but.tagString=[NSString stringWithFormat:@"%@",[arrayDoorType[i] objectForKey:@"id"]];
        [but addTarget:self action:@selector(butOneClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            but.selected=YES;
            but.layer.borderColor= [UIColor colorWithHexString:@"f57f27"].CGColor;
        }
        btnOneLast=but;
        [arrayButtonOne addObject:but];
        butX = CGRectGetMaxX(but.frame)+10;
    }
    [viewDoorType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(butY+23);
    }];
    
    
//        NSArray *tarr = @[@"水电维修",@"线路维修",@"家居维修",@"家电维修",@"其他"];
    
        float butXType = 0;
        float butYType = 0;
        for(int i = 0; i < arrayRepairType.count; i++){
    
            //宽度自适应
            NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
            CGRect frame_W = [[arrayRepairType[i] objectForKey:@"displayValue"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
            if (butXType+frame_W.size.width+10>kScreenW-140) {
    
                butXType = 0;
    
                butYType += 33;
            }
    
            SMutton *but = [[SMutton alloc]initWithFrame:CGRectMake(butXType, butYType, frame_W.size.width+10, 23)];
            [but setTitle:[arrayRepairType[i] objectForKey:@"displayValue"] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [but setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"3196fd"]] forState:UIControlStateSelected];
            [but setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            but.titleLabel.font = [UIFont systemFontOfSize:13];
            but.layer.cornerRadius = 2;
            but.layer.borderColor = [UIColor lightGrayColor].CGColor;
            but.layer.borderWidth = 1;
            but.layer.masksToBounds=YES;
            [viewRepairType addSubview:but];
            but.tagString=[NSString stringWithFormat:@"%@",[arrayRepairType[i] objectForKey:@"id"]];
            [but addTarget:self action:@selector(butClickTwo:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                but.selected=YES;
                but.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
            }
            [arrayButtonTwo addObject:but];
            butXType = CGRectGetMaxX(but.frame)+10;
        }
    [viewRepairType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(butYType+23);
    }];
    
//    NSArray *tarrLocation = @[@"卧室",@"厨房",@"客厅",@"阳台",@"卫生间",@"其他"];

    float butXLocation = 0;
    float butYLocation = 0;
    for(int i = 0; i < arrayRepairLocation.count; i++){

        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [[arrayRepairLocation[i] objectForKey:@"displayValue"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];

        if (butXLocation+frame_W.size.width+10>kScreenW-140) {

            butXLocation = 0;

            butYLocation += 33;
        }

        SMutton *but = [[SMutton alloc]initWithFrame:CGRectMake(butXLocation, butYLocation, frame_W.size.width+10, 23)];
        [but setTitle:[arrayRepairLocation[i] objectForKey:@"displayValue"] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"3196fd"]] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 2;
        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
        but.layer.borderWidth = 1;
        [viewRepairLocation addSubview:but];
        but.tagString=[NSString stringWithFormat:@"%@",[arrayRepairLocation[i] objectForKey:@"id"]];
        [but addTarget:self action:@selector(butClickThree:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            but.selected=YES;
            but.layer.borderColor= [UIColor colorWithHexString:@"3196fd"].CGColor;
        }
        but.layer.masksToBounds=YES;
        [arrayButtonThree addObject:but];
        butXLocation = CGRectGetMaxX(but.frame)+10;
    }
    [viewRepairLocation mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(butYLocation+23);
    }];
    
    [SMTool addShadowToView:viewWhileBG withOpacity:0.2 shadowRadius:3 andCornerRadius:1];
}

-(void)butOneClick:(SMutton *)btnOne{
    for (SMutton *btnSelect in arrayButtonOne) {
        btnSelect.selected=NO;
        btnSelect.layer.borderColor= [UIColor colorWithHexString:@"d5d5d5"].CGColor;
    }
    btnOne.selected=YES;
    btnOne.layer.borderColor= [UIColor whiteColor].CGColor;
 
    //室内点击事件
    if ([btnOne.tagString isEqualToString:@"1501"]) {
        lblBaoXiu.hidden=NO;
        viewRepairType.hidden=NO;
        lineOne.hidden=NO;
        lblBaoWeizhi.hidden=NO;
        viewRepairLocation.hidden=NO;
        [lineTwo mas_updateConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(viewRepairLocation.mas_bottom).offset(20);
        }];
    }
    
    //室外点击事件
    if ([btnOne.tagString isEqualToString:@"1502"]) {
        lblBaoXiu.hidden=YES;
        viewRepairType.hidden=YES;
        lineOne.hidden=YES;
        lblBaoWeizhi.hidden=YES;
        viewRepairLocation.hidden=YES;
        [lineTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewRepairLocation.mas_bottom).offset(-160);
        }];
    }
}

-(void)btnImproveClick{
    if ([self showCheckErrorHUDWithTitle:@"请填写保修描述" SubTitle:nil checkTxtField:txtView]) {
        return ;
    }
    
    if (lblBaoTimeDetail.tag!=2) {
        [self showErrorHUDWithTitle:@"请选择上门维修时间" SubTitle:nil Complete:nil];
        return ;
    }
    
    //1.设置请求参数
    [self showLoadingHUDWithTitle:@"正在上传保修信息" SubTitle:nil];
    NSString *strrepairtype=@"";
    
    for (SMutton *btnSelect in arrayButtonOne) {
        if (btnSelect.selected) {
            strrepairtype=btnSelect.tagString;
        }
    }
    
    NSString *strrepairproject=@"";
    for (SMutton *btnSelect in arrayButtonTwo) {
        if (btnSelect.selected) {
            strrepairproject=btnSelect.tagString;
        }
    }
    
    NSString *strrepairposition=@"";
    for (SMutton *btnSelect in arrayButtonThree) {
        if (btnSelect.selected) {
            strrepairposition=btnSelect.tagString;
        }
    }
    NSString *strTime=@"";
    if (!indexPathSelect) {
        NSDictionary *dicSelect=arrayRepairTime[0];
        strTime=dicSelect[@"id"];
    }else{
        NSDictionary *dicSelect=arrayRepairTime[indexPathSelect.section];
        strTime=dicSelect[@"id"];
    }
    
    //上传图片
    NSMutableArray *arraySmallPic=[[NSMutableArray alloc]init];
    for (NSDictionary *dicPic in arrayPic) {
        NSDictionary *dicNew=@{@"small_photo":dicPic[@"smallImagePath"],
                               @"photo":dicPic[@"imagePath"],
                               @"photo_type":@"4",
                               @"imgname":dicPic[@"imageName"]};
        [arraySmallPic addObject:dicNew];
    }
    
    LoginResultModel *loginRe=[Global sharedInstance].model.results[0];
    NSDictionary *dict = @{@"formId":@"18",
                           @"register":@{@"repair_type":strrepairtype,
                                         @"repair_position":strrepairposition,
                                         @"repair_project":strrepairproject,
                                         @"time_slot":strTime,
                                         @"status":@"100",
                                         @"APPAcountNumber_id":loginRe.id,
                                         @"housing_id":loginRe.housingId,
                                         @"valid":@"1",
                                         @"description":txtView.text,
                                         @"datetime":[self getTimeDate],//@"2017-11-15",
                                         },
                           @"detail":@[
                                   @{@"formId":@"7",
                                     @"parentId":@"guarantee_id",
                                     @"array":arraySmallPic
                                     }]};
    //2.开始请求
    HHttpRequest *request = [[HHttpRequest alloc] init];
    [request httpPostNoLoginRequestWithActionName:@"photo/form/saveFormDataJson"
                                    andJsonString:@"json"
                                      andPramater:dict
                             andDidDataErrorBlock:^(NSURLSessionTask *operation, id responseObject) {
                                 [self hideLoadM];
                                 [self showErrorHUDWithTitle:@"服务异常，请联系客服人员" SubTitle:nil Complete:nil];
                             } andDidRequestSuccessBlock:^(NSURLSessionTask *operation, id responseObject) {
                                 [self hideLoadM];
                                 [self.navigationController popViewControllerAnimated:YES];
                                 //        modelDetail=[ExpertAppointmentModel objectWithKeyValues:responseObject];
                                 //        [self upDataView:modelDetail];
                                 NSLog(@"%@",responseObject);
                                 //        LoginModel *model=[LoginModel yy_modelWithJSON:responseObject];
                                 //        [Global sharedInstance].model=model;
                                 //        [self dismissViewControllerAnimated:YES completion:nil];
                             } andDidRequestFailedBlock:^(NSURLSessionTask *operation, NSError *error) {
                                 [self hideLoadM];
                             }];
    
}

-(NSString *)getTimeDate{
    if (!indexPathSelect) {
        return [self getTimeDateWithNumber:1];
    }else{
        return [self getTimeDateWithNumber:indexPathSelect.section];
    }
}

-(NSString *)getTimeDateWithNumber:(NSInteger )iNumber{
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:iNumber];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;

}

@end
