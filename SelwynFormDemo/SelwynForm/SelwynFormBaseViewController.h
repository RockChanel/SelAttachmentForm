//
//  SelwynFormBaseViewController.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 提交操作回调 */
typedef void(^FormCompletion)();

@interface SelwynFormBaseViewController : UIViewController

/** baseTableView */
@property (nonatomic, strong) UITableView *formTableView;
/** tableView数据源 */
@property (nonatomic, strong) NSMutableArray *mutableArray;

/**
 初始化方法
 @param style 表单样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/** 添加提交按钮 */
- (void)_setCommitItem;

@end
