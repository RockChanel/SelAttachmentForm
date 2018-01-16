//
//  SelwynAttaCollectionViewCell.h
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AttachmentDeleteHandle)();

@interface SelwynAttaCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL editingEnable;
@property (nonatomic, strong) id image;
@property (nonatomic, copy) AttachmentDeleteHandle deleteHandle;

@end
