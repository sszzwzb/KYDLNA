//
//  ViewController.m
//  KYDLNA
//
//  Created by kaiyi on 2021/3/15.
//

#import "ViewController.h"

#import "KYPlayerForScreenViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIButton *but = ({
        UIButton *but = [UIButton buttonWithType:(UIButtonTypeSystem)];
        but.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100);
        [self.view addSubview:but];
        but.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [but setTitle:@"微信分享" forState:(UIControlStateNormal)];
        but.tag = 200;
        [but addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        but;
    });
    
    
}

-(void)butAction:(UIButton *)button
{
    if (button.tag == 200) {
        
        KYPlayerForScreenViewController *vc = [[KYPlayerForScreenViewController alloc]init];
    //    vc.titleUUID = titleUUID;
        [self.navigationController pushViewController:vc animated:YES];
        
        vc.getSelectForScreenBlock = ^(CLUPnPDevice * _Nonnull device, NSString * _Nonnull deviceTitle) {
            //显示投屏页面
    //        [self showForScreenVForDevice:device];
        };
        
        vc.getSelectForScreenAirPlayBlock = ^{
            //AirPlay
    //        [self showAirPlay];
        };
    }
    
}


@end
