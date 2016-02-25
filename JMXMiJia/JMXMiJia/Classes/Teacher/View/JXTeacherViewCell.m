//
//  JXTeacherViewCell.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#define JXNameFont [UIFont systemFontOfSize:17] // 姓名字体
#define JXSchoolFont [UIFont systemFontOfSize:12] // 学校字体
#define JXSignFont [UIFont systemFontOfSize:13] // 标签字体(等级，工作年限，教授类别)
#define JXFeeFont [UIFont systemFontOfSize:20] // 费用字体
#define JXDistanceFont JXSchoolFont

#import "JXTeacherViewCell.h"
#import <Masonry.h>
#import "JXTeacher.h"
#import <UIImageView+WebCache.h>
//#import <UIButton+WebCache.h>
#import <SDWebImageManager.h>

#import "JXSchool.h"

@interface JXTeacherViewCell() <SDWebImageManagerDelegate>
/** 头像 */
@property (weak, nonatomic) UIImageView *iconView;
/** 勋章 */
@property (nonatomic, weak) UIImageView *medalView;
/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 驾校 */
@property (nonatomic, weak) UILabel *schoolLabel;
/** 星级 */
@property (nonatomic, weak) UIImageView *starView;
/** 距离 */
@property (nonatomic, weak) UIButton *distanceView;
/** 教师等级 */
@property (nonatomic, weak) UILabel *rankLabel;
/** 工作年限 */
@property (nonatomic, weak) UILabel *workYearLabel;
/** 教授类别 */
@property (nonatomic, weak) UILabel *teachTypeLabel;
/** 学费 */
@property (nonatomic, weak) UILabel *feeLabel;

@property (nonatomic, strong) SDWebImageManager *manager;
@end

@implementation JXTeacherViewCell
// 控件之间的间距
static NSInteger const margin = 5;
// 标签的长度
static CGFloat const JXSignLabelW = 30;

- (SDWebImageManager *)manager {
    if (_manager == nil) {
        _manager = [SDWebImageManager sharedManager];
        _manager.delegate = self;
    }
    return _manager;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor redColor];
//    iconView.clipsToBounds = YES;
    iconView.contentMode = UIViewContentModeCenter;
    
    /*
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGFloat imageWidth = 60;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWidth, imageWidth)];
    maskLayer.path = bezierPath.CGPath;
    iconButton.layer.mask = maskLayer;
    */
     
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    /** 勋章 */
    UIImageView *medalView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:medalView];
#warning 测试数据
    medalView.image = [UIImage imageNamed:@"grade"];
    self.medalView = medalView;
    
    /** 姓名 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = JXNameFont;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 驾校 */
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.font = JXSchoolFont;
    [self.contentView addSubview:schoolLabel];
    self.schoolLabel = schoolLabel;
    
    /** 距离 */
    UIButton *distanceView = [[UIButton alloc] init];
    [distanceView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    distanceView.titleLabel.font = JXDistanceFont;
    distanceView.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
    distanceView.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    distanceView.enabled = NO;
    [distanceView setImage:[UIImage imageNamed:@"distance_gray"] forState:UIControlStateNormal];
    [self.contentView addSubview:distanceView];
    self.distanceView = distanceView;
    
    /** 星级 */
    UIImageView *starView = [[UIImageView alloc] init];
    starView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:starView];
    self.starView = starView;
    
    /** 教师等级 */
    UILabel *rankLabel = [[UILabel alloc] init];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.backgroundColor = JXColor(60, 187, 231);
    rankLabel.font = JXSignFont;
    [self.contentView addSubview:rankLabel];
    self.rankLabel = rankLabel;
    
    /** 工作年限 */
    UILabel *workYearLabel = [[UILabel alloc] init];
    workYearLabel.textAlignment = NSTextAlignmentCenter;
    workYearLabel.textColor = [UIColor whiteColor];
    workYearLabel.backgroundColor = JXColor(60, 187, 231);
    workYearLabel.font = JXSignFont;
    [self.contentView addSubview:workYearLabel];
    self.workYearLabel = workYearLabel;
    
    /** 教授类别 */
    UILabel *teachTypeLabel = [[UILabel alloc] init];
    teachTypeLabel.textAlignment = NSTextAlignmentCenter;
    teachTypeLabel.textColor = [UIColor whiteColor];
    teachTypeLabel.backgroundColor = JXColor(60, 187, 231);
    teachTypeLabel.font = JXSignFont;
    [self.contentView addSubview:teachTypeLabel];
    self.teachTypeLabel= teachTypeLabel;
    
    /** 学费 */
    UILabel *feeLabel = [[UILabel alloc] init];
    feeLabel.font = JXFeeFont;
    feeLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:feeLabel];
    self.feeLabel = feeLabel;
    
    /** 分割线 */
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = JXColor(229, 229, 229);
    [self.contentView addSubview:separatorView];
    
    MASAttachKeys(self.contentView, iconView, medalView, nameLabel, schoolLabel, distanceView, rankLabel, workYearLabel, teachTypeLabel, feeLabel);
    
    [iconView makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(margin);
        make.width.height.equalTo(@50);
        make.centerY.equalTo(self.contentView.centerY);
    }];
    
    [medalView makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(13);
        make.height.offset(18.33);
        make.bottom.right.equalTo(iconView);
    }];
    
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.right).offset(2*margin);
        make.bottom.equalTo(iconView.centerY);
        make.right.equalTo(schoolLabel.left).offset(-margin);
    }];
    
    [schoolLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.right).offset(margin);
        make.bottom.equalTo(nameLabel);
    }];
    
    [starView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(schoolLabel.right).offset(margin);
        make.top.bottom.equalTo(schoolLabel);
        make.width.equalTo(@56);
    }];
    
    [rankLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.bottom).offset(margin);
        make.left.equalTo(nameLabel);
        make.right.equalTo(workYearLabel.left).offset(-margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [workYearLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rankLabel);
        make.left.equalTo(rankLabel.right).offset(margin);
        make.right.equalTo(teachTypeLabel.left).offset(-margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [teachTypeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(workYearLabel);
        make.left.equalTo(workYearLabel.right).offset(margin);
        make.width.offset(JXSignLabelW);
    }];
    
    [distanceView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(schoolLabel);
        make.right.offset(-margin);
        make.width.offset(60);
        make.height.offset(20);
    }];
    
    [feeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(distanceView);
        make.top.equalTo(teachTypeLabel);
    }];
    
    [separatorView makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.equalTo(nameLabel);
        make.right.equalTo(feeLabel);
        make.bottom.offset(0);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.iconView.layer.cornerRadius = (self.frame.size.height - 2*margin)*0.5;
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
    NSString *iconUrl = [NSString stringWithFormat:@"http://10.255.1.25/dschoolAndroid/%@", teacher.photo];
    JXLog(@"iconUrl = %@", iconUrl);
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"login_name_high"]];

    __weak typeof(self) weakSelf = self;
    [self.manager downloadImageWithURL:[NSURL URLWithString:iconUrl] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        JXLog(@"$$image.size = %@", NSStringFromCGSize(image.size));
        
        // 先缩小
        UIImage *scaleImage = [self compressImage:image toTargetWidth:50];
        
        // 再裁剪
        UIImage *newImage = [self circleImageWithImage:scaleImage];
        JXLog(@"$$newImage.size = %@", NSStringFromCGSize(newImage.size));
        weakSelf.iconView.image = newImage;
    }];
#warning 测试数据
//    self.iconButton.image = arc4random_uniform(2) ? [UIImage imageNamed:@"icon_example"] : [UIImage imageNamed:@"icon_example2"];
    self.nameLabel.text = teacher.name;
    self.schoolLabel.text = teacher.school;
    self.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%zd", teacher.star]];
    [self.distanceView setTitle:@"3.6km" forState:UIControlStateNormal];
    self.rankLabel.text = [NSString stringWithFormat:@"%@", teacher.qual];
    self.workYearLabel.text = [NSString stringWithFormat:@"%zd年", teacher.year];
    self.teachTypeLabel.text = teacher.models;
    self.feeLabel.text = [NSString stringWithFormat:@"￥%zd", (int)teacher.price];
}

- (UIImage *)circleImageWithImage:(UIImage *)originImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(originImage.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, originImage.size.width, originImage.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, originImage.size.width, originImage.size.width));
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [originImage drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

/*!
 *  @author 黄仪标, 15-12-01 16:12:01
 *
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark - SDWebImageManagerDelegate
- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL {
    return YES;
}

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
    JXLog(@"***transformDownloadedImage***");
//    // 1. 创建上下文，尺寸和图片大小相同
//    CGSize size = CGSizeMake(image.size.width, image.size.width);
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    
//    // 2. 取得当前(刚创建的)上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // 3. 画圆
//    CGContextAddEllipseInRect(ctx, (CGRect){0, 0, size});
//    
//    // 4. 按当前路径形状裁剪
//    CGContextClip(ctx);
//    
//    //5. 画图
//    [image drawInRect:(CGRect){0, 0, image.size}];
//    
//    // 6. 获得上下文的图片
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 7. 关闭上下文
//    UIGraphicsEndImageContext();
    
    UIImage *newImage = [self circleImageWithImage:image];
    JXLog(@"newimage.size = %@", NSStringFromCGSize(newImage.size));
    return newImage;
}

@end
