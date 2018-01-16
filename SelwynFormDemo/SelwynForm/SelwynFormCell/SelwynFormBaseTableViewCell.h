//
//  SelwynFormBaseTableViewCell.h
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/25.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelwynExpandableTextView;

@interface SelwynFormBaseTableViewCell : UITableViewCell

/* expandable textview */
@property (nonatomic, strong) SelwynExpandableTextView *textView;

/* titlelabel */
@property (nonatomic, strong) UILabel *titleLabel;

/* super tableview of cell */
@property (nonatomic, weak) UITableView *expandableTableView;


@end
