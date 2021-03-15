//
//  KYPlayerForScreenViewController.h
//  CProject
//
//  Created by kaiyi on 2021/2/22.
//

#import <UIKit/UIKit.h>

#import <MRDLNA/MRDLNA.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYPlayerForScreenViewController : UIViewController

/**
 投屏信息
 */
typedef void (^getSelectForScreenBlock) (CLUPnPDevice *device, NSString *deviceTitle);
@property (nonatomic,strong) getSelectForScreenBlock getSelectForScreenBlock;

typedef void (^getSelectForScreenAirPlayBlock) (void);
@property (nonatomic,strong) getSelectForScreenAirPlayBlock getSelectForScreenAirPlayBlock;

@property (nonatomic,strong) NSString *titleUUID;

@end

NS_ASSUME_NONNULL_END
