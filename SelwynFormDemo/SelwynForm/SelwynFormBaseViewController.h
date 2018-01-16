//
//  SelwynFormBaseViewController.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/* submitblock */
typedef void(^FormCompletion)();

@interface SelwynFormBaseViewController : UIViewController

/*baseTableView*/
@property (nonatomic, strong) UITableView *formTableView;

/* datasource */
@property (nonatomic, strong) NSMutableArray *mutableArray;


/* Designated initializer */
- (instancetype)initWithStyle:(UITableViewStyle)style;

#pragma mark -- setCommitButton
- (void)_setCommitItem;

@end
