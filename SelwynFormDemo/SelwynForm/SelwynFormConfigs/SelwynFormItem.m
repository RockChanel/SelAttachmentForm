//
//  SelwynFormItem.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"

@implementation SelwynFormItem

/** 初始化条目 */
- (instancetype)init
{
    self = [super init];
    if (self) {
    
        _formDetail = @"";
        //单元格缺省高度
        _defaultCellHeight = 44;
        //附件缺省最大数量
        _maxImageCount = 4;
    }
    
    return self;
}

/** 重写formCellType Set方法 设置placeholder */
- (void)setFormCellType:(SelwynFormCellType)formCellType
{
    _formCellType = formCellType;
    switch (formCellType) {
        case SelwynFormCellTypeNone:
        {
            self.placeholder = @"";
        }
            break;
        case SelwynFormCellTypeInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        case SelwynFormCellTypeSelect:
        {
            self.placeholder = @"请选择";
        }
            break;
        case SelwynFormCellTypeTextViewInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        default:
            break;
    }
}

/** 重写isDetail Set方法 若详情页面则不展示placeholder */
- (void)setIsDetail:(BOOL)isDetail{
    _isDetail = isDetail;
    if (_isDetail) {
        self.placeholder = @"";
    }
}

/** 重写placeholder Set方法 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:Font(TitleFont),NSForegroundColorAttributeName:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]}];
    
    _attributedPlaceholder = attributedPlaceholder;
}

/** 重写required Set方法 若YES则标题前加*标识符 */
- (void)setRequired:(BOOL)required
{
    _required = required;
    
    NSString *title = self.formTitle;
    
    if (required) {
        title = [NSString stringWithFormat:@"*%@",title];
    }
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:Font(TitleFont), NSForegroundColorAttributeName:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]}];
    
    if (required) {
        [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    }
    
    _formAttributedTitle = attributedTitle;
}

@end
