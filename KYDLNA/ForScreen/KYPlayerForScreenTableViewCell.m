//
//  KYPlayerForScreenTableViewCell.m
//  CProject
//
//  Created by kaiyi on 2021/2/22.
//

#import "KYPlayerForScreenTableViewCell.h"

@interface KYPlayerForScreenTableViewCell ()

@property (nonatomic,strong) UIImageView *imgR;
@property (nonatomic,strong) UIImageView *imgL;

@property (nonatomic,strong) UILabel *lab;

@property (nonatomic,strong) UIActivityIndicatorView *ActivityIndicator;
@property (nonatomic,strong) UILabel *labLoading;

@end

@implementation KYPlayerForScreenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self up_cell];
    }
    return self;
}

-(void)up_cell
{
    self.contentView.backgroundColor = Color_groupTable_white;
    
    _imgL = [[UIImageView alloc]init];
    [self.contentView addSubview:_imgL];
    _imgL.backgroundColor = [UIColor clearColor];
    
    _imgL.sd_layout
    .leftSpaceToView(self.contentView, kScale(20))
    .topSpaceToView(self.contentView, kScale(14))
    .widthIs(kScale(20))
    .heightEqualToWidth();
    
    
    _lab = [[UILabel alloc]init];
    [self.contentView addSubview:_lab];
    _lab.textColor = Color333;
    _lab.font = CPFont(kScale(14));
    
    _lab.sd_layout
    .leftSpaceToView(_imgL, kScale(8.5))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .autoWidthRatio(0);
    
    [_lab setSingleLineAutoResizeWithMaxWidth:kScale(305-17)];
    
    
    _imgR = [[UIImageView alloc]init];
    [self.contentView addSubview:_imgR];
    _imgR.backgroundColor = [UIColor clearColor];
    
    _imgR.sd_layout
    .leftSpaceToView(_lab, kScale(5.5))
    .topSpaceToView(self.contentView, kScale(17))
    .widthIs(kScale(14))
    .heightEqualToWidth();
    
    
    
    //等待登陆菊花初始化：
    _ActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //设置菊花的中心点，貌似不能设置菊花的大小，系统自带的有三种样式
    _ActivityIndicator.center = CGPointMake(kScale(129), [KYPlayerForScreenTableViewCell cellHeight]/2);
    //添加菊花
    [self.contentView addSubview:_ActivityIndicator];
//    //在某个地方设置其 ，开始旋转动画
//    [_ActivityIndicator startAnimating];
//    _ActivityIndicator.color = [UIColor redColor];
    
    
    //菊花停止旋转
    [_ActivityIndicator stopAnimating];
    //菊花隐藏
    [_ActivityIndicator setHidesWhenStopped:YES];
    
    
    _labLoading = [[UILabel alloc]init];
    [self.contentView addSubview:_labLoading];
    _labLoading.textColor = Color333;
    _labLoading.font = CPFont(14);
    
    _labLoading.sd_layout
    .leftSpaceToView(self.contentView, kScale(150.5))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(200);
    
}

- (void)setModel:(KYPlayerForScreenModel *)model
{
    _model = model;
    if (model) {
        
        if ([model.type isEqualToString:@"Loading"]) {
            _labLoading.text = [NSString stringWithFormat:@"%@", model.title];
            [_ActivityIndicator startAnimating];
            [_ActivityIndicator setHidesWhenStopped:NO];
            
            _lab.hidden = YES;
            _imgL.hidden = YES;
            _imgR.hidden = YES;
        } else {
            _labLoading.text = @"";
            [_ActivityIndicator stopAnimating];
            [_ActivityIndicator setHidesWhenStopped:YES];
            
            _lab.hidden = NO;
            _imgL.hidden = NO;
            _imgR.hidden = NO;
            
            _lab.text = [NSString stringWithFormat:@"%@", model.title];
            
            UIImage *imgLN;
            UIImage *imgLS;
            if ([model.type isEqualToString:@"TV"]) {
                imgLN = [UIImage imageNamed:@"player_forScreen_cellTN"];
                imgLS = [UIImage imageNamed:@"player_forScreen_cellTS"];
            } else {
                imgLN = [UIImage imageNamed:@"player_forScreen_cellAN"];
                imgLS = [UIImage imageNamed:@"player_forScreen_cellAS"];
            }
            
            if (model.selected) {
                _lab.textColor = Color_orange;
                _imgL.image = imgLS;
                _imgR.image = [UIImage imageNamed:@"player_forScreen_cellS"];
            } else {
                _lab.textColor = Color333;
                _imgL.image = imgLN;
                _imgR.image = [UIImage new];
            }
        }
    }
    
}

+(CGFloat)cellHeight
{
    return kScale(48);
}

@end


@implementation KYPlayerForScreenModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
