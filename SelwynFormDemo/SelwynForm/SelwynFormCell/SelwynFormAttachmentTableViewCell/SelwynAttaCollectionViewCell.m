//
//  SelwynAttaCollectionViewCell.m
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelwynAttaCollectionViewCell.h"

#define DeleteWidth 22.0f

@interface SelwynAttaCollectionViewCell()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation SelwynAttaCollectionViewCell

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUI];
    }
    return self;
}

- (void)_setUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, DeleteWidth/2, self.frame.size.width - DeleteWidth/2, self.frame.size.height - DeleteWidth/2)];
    _mainImageView.clipsToBounds = YES;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:_mainImageView];
    
    _deleteImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - DeleteWidth, 0, DeleteWidth, DeleteWidth)];
    _deleteImageView.image = [UIImage imageNamed:@"Delete Reveal"];
    
    [self.contentView addSubview:_deleteImageView];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteButton.frame = CGRectMake(self.frame.size.width - 25, 0, 25, 25);
    [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_deleteButton];
}

/** 图片删除点击事件 */
- (void)deleteAction{
    
    /** 图片删除回调 */
    if (_deleteHandle) {
        _deleteHandle();
    }
}

/** 重写editingEnable set 方法 */
- (void)setEditingEnable:(BOOL)editingEnable
{
    _editingEnable = editingEnable;
    
    _deleteImageView.hidden = !_editingEnable;
    _deleteButton.hidden = !_editingEnable;
}

/** 重写editingEnable set 方法 显示图片 可在此配置SDWebImage 加载图片 以及设置图片缺省图*/
- (void)setImage:(id)image
{
    _image = image;
    
    if ([_image isKindOfClass:[UIImage class]]) {
        
        self.mainImageView.image = _image;
        
    }else if ([_image isKindOfClass:[NSURL class]]){
        
        //[self.mainImageView sd_setImageWithURL:_image placeholderImage:[UIImage imageNamed:Home_Placeholder_Icon]];
        
    }else if ([_image isKindOfClass:[NSString class]]){
        
        //[self.mainImageView sd_setImageWithURL:[NSURL URLWithString:[[PublicTools returnNullStringWithString:_image] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:Home_Placeholder_Icon]];
        
    }else
    {
        //self.mainImageView.image = [UIImage imageNamed:Home_Placeholder_Icon];
    }
}


@end
