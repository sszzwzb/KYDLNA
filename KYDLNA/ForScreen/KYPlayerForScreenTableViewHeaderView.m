//
//  KYPlayerForScreenTableViewHeaderView.m
//  CProject
//
//  Created by kaiyi on 2021/2/23.
//

#import "KYPlayerForScreenTableViewHeaderView.h"

@implementation KYPlayerForScreenTableViewHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self up_headerView];
    }
    return self;
}

-(void)up_headerView
{
    
    self.contentView.backgroundColor = Color_groupTableBG;
    
    UILabel *lab = [[UILabel alloc]init];
    [self.contentView addSubview:lab];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = Color999;
    lab.font = CPFont(kScale(13));
    lab.text = @"选择要投射的电视";
    
    lab.sd_layout
    .leftSpaceToView(self.contentView, kScale(20.5))
    .topSpaceToView(self.contentView, kScale(19.5))
    .heightIs(kScale(13))
    .widthIs(280);
    
}

+(CGFloat)headerHeight
{
    return kScale(44);
}

@end




@implementation KYPlayerForScreenTableViewFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self up_footerView];
    }
    return self;
}

-(void)up_footerView
{
    self.backgroundColor = Color_groupTableBG;
    self.contentView.backgroundColor = Color_groupTableBG;
    
    UIImageView *imgV = [[UIImageView alloc]init];
    [self.contentView addSubview:imgV];
    
    imgV.image = [UIImage imageNamed:@"player_forScreenFooter"];
    
    imgV.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kScale(12), 0, 0, 0));
    
}

+(CGFloat)footerHeight
{
    return kScale(959 + 12);
}

@end
