//
//  KYPlayerForScreenViewController.m
//  CProject
//
//  Created by kaiyi on 2021/2/22.
//

#import "KYPlayerForScreenViewController.h"

#import <MRDLNA/MRDLNA.h>

#import <AVKit/AVKit.h>
#import <MediaPlayer/MPVolumeView.h>

#import "KYPlayerForScreenTableViewCell.h"
#import "KYPlayerForScreenTableViewHeaderView.h"

static NSString *HeaderIdentifier = @"header";
static NSString *FooterIdentifier = @"footer";


@interface KYPlayerForScreenViewController () <UITableViewDelegate,UITableViewDataSource,DLNADelegate>

@property(nonatomic,strong) MRDLNA *dlnaManager;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KYPlayerForScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [self setNavTitle];
    
    _dataArr = [NSMutableArray array];
    
    [self up_tableView];
    
    
    self.dlnaManager = [MRDLNA sharedMRDLNAManager];
    self.dlnaManager.delegate = self;

    
    
}

-(void)setNavTitle
{
    self.title = @"投电视";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    leftButton.frame = CGRectMake(8, 0, 33, 33);
    [leftButton setImage:[UIImage imageNamed:@"player_forScreen_close"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"player_forScreen_close"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(selectLeftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;  //  修改位置
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarButton, nil];
    
    [self navReloadButWithHidden:YES];
}

-(void)navReloadButWithHidden:(BOOL)hidden
{
    if (hidden) {
        self.navigationItem.rightBarButtonItems = @[];
    } else {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setBackgroundColor:[UIColor clearColor]];
        rightButton.frame = CGRectMake(8, 0, 33, 33);
        [rightButton setImage:[UIImage imageNamed:@"player_forScreen_reload"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"player_forScreen_reload"] forState:UIControlStateSelected];
        [rightButton addTarget:self action:@selector(reloadData_dlna) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;  //  修改位置
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarButton, nil];
    }
}

-(void)selectLeftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault; //  黑色
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(void)up_tableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                             style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = Color_groupTableBG;
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(HCTopBarHeight, 0, 0, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }

    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    [_tableView registerClass:[KYPlayerForScreenTableViewCell class] forCellReuseIdentifier: @"KYPlayerForScreenTableViewCell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [KYPlayerForScreenTableViewCell cellHeight];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [KYPlayerForScreenTableViewHeaderView headerHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [KYPlayerForScreenTableViewFooterView footerHeight];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KYPlayerForScreenTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if (headerView == nil) {
        headerView = [[KYPlayerForScreenTableViewHeaderView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    KYPlayerForScreenTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterIdentifier];
    if (footerView == nil) {
        footerView = [[KYPlayerForScreenTableViewFooterView alloc] initWithReuseIdentifier:FooterIdentifier];
    }
    return footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYPlayerForScreenTableViewCell *cell = (KYPlayerForScreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"KYPlayerForScreenTableViewCell" forIndexPath:indexPath];
    
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"我点击了  %ld   %ld",(long)indexPath.section,(long)indexPath.row);
    

    if (indexPath.row >= self.dataArr.count) {
        return;
    }
    
    
    KYPlayerForScreenModel *model = _dataArr[indexPath.row];
    if ([model.type isEqualToString:@"TV"]) {
        
        CLUPnPDevice *device = model.device;
//        self.dlnaManager.device = device;
//        self.dlnaManager.playUrl = @"https://volstatic.chinaedu.net/volcano2/resource/we/attachment/speak/20210129/m3u8/70c05173-ea34-45e7-8999-7c4b26b9990e/70c05173-ea34-45e7-8999-7c4b26b9990e.m3u8";
//
//        self.dlnaManager = [MRDLNA sharedMRDLNAManager];
//        [self.dlnaManager startDLNA];
        if (_getSelectForScreenBlock) {
            _getSelectForScreenBlock( device, [NSString stringWithFormat:@"%@", device.friendlyName]);
            
            [self selectLeftAction];
        }
        
    } else if ([model.type isEqualToString:@"AirPlay"]) {
        
        if (_getSelectForScreenAirPlayBlock) {
            _getSelectForScreenAirPlayBlock();
        }
        
        [self selectLeftAction];
    }
    
}

#pragma mark - AirPlay
- (void)showAirPlay
{
    //AVRoutePickerView 和 MPVolumeView 投屏   https://blog.csdn.net/sun_cui_hua/article/details/103984632
    if (@available(iOS 11.0, *)) {
        
        AVRoutePickerView *routePickerView = [[AVRoutePickerView alloc]initWithFrame:CGRectZero];
//        routePickerView.delegate = self;
        [self.view addSubview:routePickerView];
        routePickerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        for (UIView *view in routePickerView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                [button removeFromSuperview];
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    } else {
        
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        volumeView.showsVolumeSlider = NO;
        volumeView.showsRouteButton = NO;
        [self.view addSubview:volumeView];
        
        for (UIButton *button in volumeView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        NSLog(@"投屏状态 = %d", volumeView.wirelessRouteActive);
        
//        //添加通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pmVolumeViewWirelessRouteActiveDidChangeNoti:) name:MPVolumeViewWirelessRouteActiveDidChangeNotification object:nil];
    }
    
    
    //    _player.airPlayVideoActive
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData_dlna];
}

//搜索设备
-(void)reloadData_dlna
{
    [self.dlnaManager startSearch];
    [self navReloadButWithHidden:YES];
}

- (void)searchDLNAResult:(NSArray *)devicesArray{
    NSLog(@"发现设备");
    
    NSMutableArray *testArr = [NSMutableArray array];
    for (int i = 0; i < [devicesArray count]; i++) {
        CLUPnPDevice *device = devicesArray[i];
        
        BOOL selected = ([_titleUUID isEqualToString:[NSString stringWithFormat:@"%@", device.friendlyName]]);
        
        [testArr addObject:@{
            @"title":[NSString stringWithFormat:@"%@", device.friendlyName],
            @"selected":@(selected),
            @"type":@"TV",
            @"device":device
        }];
    }
    
    [testArr addObject:@{
        @"title":@"AirPlay",
        @"selected":@([_titleUUID isEqualToString:@"AirPlay"]),
        @"type":@"AirPlay"
    }];
    
    [testArr addObject:@{
        @"title":@"正在搜索设备 ...",
        @"type":@"Loading"
    }];
    
    [_dataArr removeAllObjects];
    for (NSDictionary *dic in testArr) {
        KYPlayerForScreenModel *model = [KYPlayerForScreenModel new];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArr addObject:model];
    }
    
    [_tableView reloadData];
}


#pragma mark - DLNADelegate
/**
 搜索结束 kaiyi
 */
- (void)theEndSearch {
    [self navReloadButWithHidden:NO];
    
    for (KYPlayerForScreenModel *model in _dataArr) {
        if ([model.type isEqualToString:@"Loading"]) {
            [_dataArr removeObject:model];
        }
    }
    [_tableView reloadData];
}

- (void)dlnaStartPlay {
    NSLog(@"投屏成功 开始播放");
}

@end
