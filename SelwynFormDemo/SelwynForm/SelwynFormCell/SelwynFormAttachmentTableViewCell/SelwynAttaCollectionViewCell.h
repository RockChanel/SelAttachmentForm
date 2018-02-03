//
//  SelwynAttaCollectionViewCell.h
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 图片删除回调 */
typedef void(^AttachmentDeleteHandle)();

@interface SelwynAttaCollectionViewCell : UICollectionViewCell

/** 是否可编辑 */
@property (nonatomic, assign) BOOL editingEnable;
/** 图片源 */
@property (nonatomic, strong) id image;
/** 图片删除回调 */
@property (nonatomic, copy) AttachmentDeleteHandle deleteHandle;

@end
