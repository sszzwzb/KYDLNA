//
//  KYPlayerForScreenTableViewCell.h
//  CProject
//
//  Created by kaiyi on 2021/2/22.
//

#import <UIKit/UIKit.h>

#import <MRDLNA/MRDLNA.h>


@interface KYPlayerForScreenModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,assign) BOOL selected;

@property (nonatomic,strong) CLUPnPDevice *device;

@end


NS_ASSUME_NONNULL_BEGIN

@interface KYPlayerForScreenTableViewCell : UITableViewCell

@property (nonatomic,strong) KYPlayerForScreenModel *model;

+(CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
