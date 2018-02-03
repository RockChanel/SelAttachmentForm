//
//  SelwynFormItem.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelwynFormItem;

/** 表单cell类型 */
typedef NS_ENUM(NSInteger, SelwynFormCellType) {
    
    SelwynFormCellTypeNone = 0,     //default
    SelwynFormCellTypeInput = 1,    //单行或多行输入
    SelwynFormCellTypeTextViewInput = 2,    //包含textView输入
    SelwynFormCellTypeSelect = 3,   //选择
    SelwynFormCellTypeAttachment = 4,   //附件
};

/** 表单条目选择回调 */
typedef void(^FormItemSelectHandle)(SelwynFormItem *item);

@interface SelwynFormItem : NSObject

/** item 缺省高度 缺省44*/
@property (nonatomic, assign) CGFloat defaultCellHeight;
/** 表单cell类型 */
@property (nonatomic, assign) SelwynFormCellType formCellType;
/** 标题 */
@property (nonatomic, copy) NSString *formTitle;
/** 富文本标题 可配置标题颜色等*/
@property (nonatomic, strong) NSAttributedString *formAttributedTitle;
/** 详情 */
@property (nonatomic, copy) NSString *formDetail;
/** 错误提示 */
@property (nonatomic, copy) NSString *formError;
/** 占位提示 */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

/** 是否是必填（必选） */
@property (nonatomic, assign) BOOL required;
/** 是否可编辑 */
@property (nonatomic, assign) BOOL editable;
/** 是否是详情页面 */
@property (nonatomic, assign) BOOL isDetail;
/** 附件图片 */
@property (nonatomic, strong) NSArray *images;
/** 附件最大图片选择数量 缺省4张*/
@property (nonatomic, assign) NSInteger maxImageCount;
/** 键盘类型 */
@property (nonatomic, assign) UIKeyboardType keyboardType;
/** 表单条目选择回调 */
@property (nonatomic, copy) FormItemSelectHandle selectHandle;
/** 表单输入字数限制 缺省为0（无限制）*/
@property (nonatomic, assign) NSInteger maxInputLength;
/** 对齐方式 */
@property (nonatomic, assign) NSTextAlignment textAlignment;




@end
