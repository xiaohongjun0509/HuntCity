//
//  XHJSegmentTab.m
//  HuntCity
//
//  Created by hongjunxiao on 15/11/25.
//  Copyright © 2015年 XHJ. All rights reserved.
//

#import "XHJSegmentTab.h"

#define OFFSET 1000

@interface XHJSegmentTab ()

@property (nonatomic, strong) UIView *buttomLine;

@end


@implementation XHJSegmentTab

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _selectedIndex = 0;
        _buttomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _buttomLine.backgroundColor = [UIColor redColor];
       
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    if (titles.count <= 0) {
        return;
    }
    _titles = [titles copy];
    [self reloadView];
}


- (void)reloadView{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat buttonHeight;
    if (self.showButtomLine) {
        buttonHeight = self.frame.size.height - 2;
    }else{
        buttonHeight = self.frame.size.height;
    }
    
    CGFloat totalWidth = self.frame.size.width;
    NSInteger count = self.titles.count;
    CGFloat buttonWidth = totalWidth / count;    
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor: i == self.selectedIndex ? [UIColor redColor]:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = OFFSET + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth - 1, buttonHeight);
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 5, 1, self.frame.size.height - 2 * 5)];
        iv.backgroundColor = [UIColor redColor];
        iv.hidden = i == count - 1 ? YES : NO;
        [self addSubview:button];
        [self addSubview:iv];
        
    }
    

    if (!self.buttomLine.superview) {
         [self addSubview:self.buttomLine];
    }
    self.buttomLine.frame = CGRectMake(self.selectedIndex * buttonWidth, self.frame.size.height - 2, buttonWidth, 2);
    [self bringSubviewToFront:self.buttomLine];
}

- (void)buttonClick:(UIButton *)button{
    self.selectedIndex = button.tag - OFFSET;
    [self reloadView];
    NSLog(@"------- %ld",self.selectedIndex);
    if(self.segmentDidClick){
        self.segmentDidClick(self.selectedIndex);
    }
}
@end
