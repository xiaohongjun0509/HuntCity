//
//  ReycleCollectionView.h
//  HuntCity
//
//  Created by hongjunxiao on 15/11/25.
//  Copyright © 2015年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReycleBannerView;
@protocol ReycleBannerViewDelegate <NSObject>

- (void)recycleBannerView:(ReycleBannerView *)recycleBannerView didSelectAtIndex:(NSIndexPath *)indexPath;

@end



@interface ReycleBannerView : UIView
/**
 *  @author hongjunxiao, 15-11-29
 *
 *  存放相关的图片的url
 *
 *  @since <#7.3.1#>
 */
@property (nonatomic,copy) NSArray *imageArray;
/**
 *  @author hongjunxiao, 15-11-29
 *
 *  展示的时候滚动到指定的位置。
 *
 *  @since <#7.3.1#>
 */
@property (nonatomic, assign) NSInteger preSelectedIndex;
/**
 *  @author hongjunxiao, 15-11-29
 *
 *  是否开启循环滚动
 *
 *  @since <#7.3.1#>
 */
@property (nonatomic, assign) BOOL needRecycle;
@end
