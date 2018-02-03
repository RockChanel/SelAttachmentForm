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

/** header 标题 */
@property (nonatomic, copy) NSString *headerTitle;
/** footer 标题 */
@property (nonatomic, copy) NSString *footerTitle;
/** header 高度 */
@property (nonatomic, assign) CGFloat headerHeight;
/** footer 高度 */
@property (nonatomic, assign) CGFloat footerHeight;
/** header 标题颜色 缺省黑色 */
@property (nonatomic, strong) UIColor *headerTitleColor;
/** footer 标题颜色 缺省黑色 */
@property (nonatomic, strong) UIColor *footerTitleColor;
/** header 颜色 缺省透明 */
@property (nonatomic, strong) UIColor *headerColor;
/** footer 颜色 缺省透明 */
@property (nonatomic, strong) UIColor *footerColor;
/** section 下单元格 */
@property (nonatomic, strong) NSArray *cellItems;

@end
