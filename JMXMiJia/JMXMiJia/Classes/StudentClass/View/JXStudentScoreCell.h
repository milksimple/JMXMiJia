//
//  JXStudentScoreCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXStudentScoreCell : UITableViewCell

+ (instancetype)cell;
#warning 暂时放在这
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

- (CGFloat)rowHeight;
@end
