//
//  SelwynFormSectionItem.h
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SelwynFormSectionItem;

@interface SelwynFormSectionItem : NSObject

/* sectionHeaderTitle */
@property (nonatomic, copy) NSString *headerTitle;

/* sectionFooterTitle */
@property (nonatomic, copy) NSString *footerTitle;

/* sectionHeaderHeight */
@property (nonatomic, assign) CGFloat headerHeight;

/* sectionFooterHeight */
@property (nonatomic, assign) CGFloat footerHeight;

/* headerTitleColor default is black */
@property (nonatomic, strong) UIColor *headerTitleColor;

/* footerTitleColor default is black */
@property (nonatomic, strong) UIColor *footerTitleColor;

/* sectionHeaderColor  default is clear */
@property (nonatomic, strong) UIColor *headerColor;

/* sectionFooterColor default is clear */
@property (nonatomic, strong) UIColor *footerColor;

/* sectionCellItems */
@property (nonatomic, strong) NSArray *cellItems;

@end
