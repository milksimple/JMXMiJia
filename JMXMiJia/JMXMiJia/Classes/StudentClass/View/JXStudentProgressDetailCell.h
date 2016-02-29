//
//  JXStudentProgressDetailCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXStudentProgressDetailCellClickedCorverButtonAction)();

#import <UIKit/UIKit.h>
@class JXStudentProgress;

@interface JXStudentProgressDetailCell : UITableViewCell
#warning 暂时放在这
/** 课堂详细情况 */
@property (weak, nonatomic) IBOutlet UILabel *classDetailLabel;

@property (nonatomic, strong) JXStudentProgress *progress;

+ (NSString *)reuseIdentifier;

+ (instancetype)cell;

+ (CGFloat)rowHeight;

@property (nonatomic, copy) JXStudentProgressDetailCellClickedCorverButtonAction corverButtonClickedAction;
@end
