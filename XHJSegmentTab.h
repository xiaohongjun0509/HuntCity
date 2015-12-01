//
//  XHJSegmentTab.h
//  HuntCity
//
//  Created by hongjunxiao on 15/11/25.
//  Copyright © 2015年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHJSegmentTab : UIView
/**
 *  @author hongjunxiao, 15-11-25
 *
 *  指定要显示的Tab的标题
 *
 *  @since <#7.3.1#>
 */
@property (nonatomic, copy) NSArray *titles;

/**
 *  @author hongjunxiao, 15-11-25
 *
 *  the bgColor of every Button
 *
 *  @since <#7.3.1#>
 */
@property (nonatomic, strong) UIColor *bgColor;

//是否显示下面的那个跟随线。
@property (nonatomic, assign) BOOL showButtomLine;

//线的颜色
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic,copy) void (^segmentDidClick)(NSInteger);

@end
