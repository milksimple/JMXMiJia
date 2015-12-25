//
//  JXSearchBar.h
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXSearchBarDelegate <NSObject>

@optional
- (void)searchBarButtonDidClickedWithSearchContent:(NSString *)searchContent;

@end

@interface JXSearchBar : UIView

+ (CGFloat)height;

- (void)quitKeyboard;

@property (nonatomic, weak) id<JXSearchBarDelegate> delegate;
@end
