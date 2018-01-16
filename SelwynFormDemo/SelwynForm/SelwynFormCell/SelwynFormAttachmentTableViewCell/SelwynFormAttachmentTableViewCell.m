//
//  SelwynFormAttachmentTableViewCell.m
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelwynFormAttachmentTableViewCell.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "SelwynAttaCollectionViewCell.h"
#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define IMAGE_MAX_SIZE_5k 5120*2880
#define AttaWidth 81
#define RowCount 4
#define cell_id @"atta_collection_cell_id"

@interface SelwynFormAttachmentTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,MWPhotoBrowserDelegate>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *images;

@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation SelwynFormAttachmentTableViewCell

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc]init];
    }
    
    return _images;
}

- (void)setFormItem:(SelwynFormItem *)formItem
{
    _formItem = formItem;
    
    self.addButton.hidden = !formItem.editable;
    self.images = [NSMutableArray arrayWithArray:formItem.images];
    self.titleLab.attributedText = formItem.formAttributedTitle;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 9;
        layout.minimumLineSpacing = 15;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.hidden = YES;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[SelwynAttaCollectionViewCell
                                        class] forCellWithReuseIdentifier:cell_id];
        
        [self.contentView addSubview:_collectionView];
    }
    
    return _collectionView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(EdgeMarin, 11, TitleWidth, TitleHeight)];
        _titleLab.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.titleLab];
    }
    
    return _titleLab;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"ProjectInitial_Attachment"];
        [self.contentView addSubview:_iconImageView];
    }
    
    return _iconImageView;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(self.frame.size.width - 38, 12, 23, 20);
    self.addButton.frame = CGRectMake(0, 0, self.frame.size.width, _formItem.defaultCellHeight);
    
    if (_formItem.images.count > 0) {
        
        self.collectionView.hidden = NO;
        self.collectionView.frame = CGRectMake(0, _formItem.defaultCellHeight, self.frame.size.width, self.frame.size.height - _formItem.defaultCellHeight);
        [self.collectionView reloadData];
        
    }else
    {
        self.collectionView.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelwynAttaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    cell.editingEnable = _formItem.editable;
    cell.image = _formItem.images[indexPath.item];
    cell.deleteHandle = ^{
        
        [self.images removeObjectAtIndex:indexPath.item];
        
        [self refreshData];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(AttaWidth, AttaWidth);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4, 10, 15, 9);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.photos removeAllObjects];
    
    for (int i = 0; i < self.images.count; i++) {
        
        id object = self.images[i];
        
        MWPhoto *photo;
        
        if ([object isKindOfClass:[UIImage class]]) {
            
            CGFloat imageSize = ((UIImage*)object).size.width * ((UIImage*)object).size.height;
            if (imageSize > IMAGE_MAX_SIZE_5k) {
                photo = [MWPhoto photoWithImage:[self scaleImage:object toScale:(IMAGE_MAX_SIZE_5k)/imageSize]];
            } else {
                photo = [MWPhoto photoWithImage:object];
            }
        }
        else if ([object isKindOfClass:[NSURL class]])
        {
            photo = [MWPhoto photoWithURL:object];
        }
        else if ([object isKindOfClass:[NSString class]])
        {
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:[object stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        
        if (photo) {
            [self.photos addObject:photo];
        }
    }
    
    [self.photoBrowser setCurrentPhotoIndex:indexPath.item];
    
    [[self superViewController:self] presentViewController:self.photoNavigationController animated:YES completion:nil];
}

- (void)addAction{
    
    if (self.images.count >= _formItem.maxImageCount) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"最多选择%ld张附件",(long)_formItem.maxImageCount] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alertView show];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
    
    actionSheet.tag = 555;
    [actionSheet showInView:self.superview];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 555) {
        
        switch (buttonIndex) {
            case 0:
            {
                [self takePhoto];
            }
                break;
            case 1:
            {
                [self localPhoto];
            }
                break;
            default:
                break;
        }
    }
}

- (void)takePhoto{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [[self superViewController:self] presentViewController:picker animated:YES completion:nil];
        
        [self AuthorzationCamera];
        
    }else
    {
        NSLog(@"无法打开照相机,请检查后重试");
    }
    
}

- (void)localPhoto{
    
    TZImagePickerController  *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:(_formItem.maxImageCount - self.images.count) delegate:self];
    
    imagePickerVC.allowPickingVideo = NO;
    
    [[self superViewController:self] presentViewController:imagePickerVC animated:YES completion:nil];
    
    [self AuthorizationPhotoAlbum];
}


- (void)refreshData{
    
    [self.collectionView reloadData];
    
    if (self.cellHandle) {
        self.cellHandle(self.images);
    }
    
    [self.expandableTableView beginUpdates];
    [self.expandableTableView endUpdates];
}

- (NSMutableArray *)photos{
    
    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
    }
    
    return _photos;
}

- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}

#pragma mark -- 计算cellHeight
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item
{
    NSInteger rows = item.images.count%RowCount > 0 ? item.images.count/RowCount+1:item.images.count/RowCount;
    
    return item.images.count > 0 ? item.defaultCellHeight + 15*(rows+1) + rows*AttaWidth:44;
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    for (int i = 0; i < photos.count; i++) {
        UIImage *selectImage = photos[i];
        
        [self.images addObject:selectImage];
    }
    
    [self refreshData];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *selectImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.images addObject:selectImage];
    
    [self refreshData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 获取当前View所在的ViewController
- (UIViewController *)superViewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    return nil;
}

#pragma mark 缩小图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//授权相机
- (void)AuthorzationCamera
{
    
    //1 判断是否有访问权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusAuthorized) {
        
        
    } else if (status == AVAuthorizationStatusDenied) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请在\n设置-筑库\n中开启照相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        
        [alertView show];
        
        return;
        
        AVAuthorizationStatus status1 = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status1 == AVAuthorizationStatusAuthorized) {
            
        }
    }
    else if (status == AVAuthorizationStatusNotDetermined)
    {
        
        if ([AVCaptureDevice instancesRespondToSelector:@selector(initWithFetchRequest:managedObjectContext:sectionNameKeyPath:cacheName:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    
                    if (granted) {
                        
                    } else
                    {
                        
                        NSLog(@"请在\n设置-筑库\n中开启照相机");
                        return ;
                    }
                }];
            });
        }
    }
}

/**
 *  授权相册
 */
- (void)AuthorizationPhotoAlbum
{
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == ALAuthorizationStatusAuthorized) {
        
        
    } else if (author == ALAuthorizationStatusDenied) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请在\n设置-筑库\n中开启照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        
        [alertView show];
        
        return;
        
    }
    else if (author == ALAuthorizationStatusNotDetermined)
    {
        
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation UITableView (SelwynFormAttachmentTableViewCell)

- (SelwynFormAttachmentTableViewCell *)formAttachmentCellWithId:(NSString *)cellId
{
    SelwynFormAttachmentTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SelwynFormAttachmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}
@end
