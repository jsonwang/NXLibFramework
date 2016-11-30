//
//  UIViewController+addiction.h
//  YOYO
//
//  Created by 王 成 on 8/1/14.
//  Copyright (c) 2014 yoyo-corp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NXAddiction)
{
}

- (UILabel *)nx_setNavigationItmeTitleView:(NSString *)title;

- (void)nx_setExtraCellLineHidden:(UITableView *)tableView;

+ (UIViewController *)nx_currentViewController;
@end
