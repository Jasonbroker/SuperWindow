//
//  DebugViewController.m
//  SuperWindow
//
//  Created by Jason on 01/06/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import "DebugViewController.h"

static NSString *const cellId = @"cellId";

typedef NS_ENUM(NSInteger, DebugCellStyle) {
    DebugCellStyleNormal,
    DebugCellStyleCompact
};

@interface DebugCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation DebugCollectionViewFlowLayout

@end

@interface DebugCell : UICollectionViewCell

@end

@implementation DebugCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
        self.layer.shadowOpacity = 0.1f;
        self.layer.shadowRadius = 5.f;

        
        
        
    }
    return self;
}

@end

@interface DebugViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)DebugCollectionViewFlowLayout *layout;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, assign)DebugCellStyle presentStyle;

@end

@implementation DebugViewController {
    CGFloat _cellWidth;
    CGFloat _padding;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.presentStyle = DebugCellStyleNormal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.layout = [[DebugCollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectOffset(CGRectInset(self.view.frame, 0, 32), 0, 32) collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[DebugCell class] forCellWithReuseIdentifier:cellId];
    
    //cell width and height
    
}

#pragma mark ---- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DebugCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

#pragma mark ---- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


// 长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        return YES;
    }
    return NO;
}

//
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if([NSStringFromSelector(action) isEqualToString:@"copy:"])
    {
        //        NSLog(@"-------------执行拷贝-------------");
        [_collectionView performBatchUpdates:^{
            // [self.dataArray removeObjectAtIndex:indexPath.row];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:nil];
    }
    else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
    {
        NSLog(@"-------------执行粘贴-------------");
    }
}

#pragma mark -setter getter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"重置APP", @"清除浏览器缓存", @"清除UserDefault", @"清除所有缓存",@"清除浏览器缓存",@"文件浏览器",@"自定义功能"];
    }
    return _dataArray;
}

- (void)setPresentStyle:(DebugCellStyle)presentStyle {
    if (presentStyle != _presentStyle) {
        _presentStyle = presentStyle;
        switch (presentStyle) {
            case DebugCellStyleNormal:
                CGFloat width = CGRectGetWidth(self.view.frame);
                if (width) {
                    
                }
                _cellWidth = CGRectGetWidth(self.view.frame);
                break;
            case DebugCellStyleCompact:
                
                break;
            default:
                break;
        }
        
    }
}

@end
