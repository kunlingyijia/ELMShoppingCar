//
//  ShoppingCarView.m
//  xxxx
//
//  Created by 席亚坤 on 16/5/6.
//  Copyright © 2016年 席亚坤. All rights reserved.
//

#import "ShoppingCarView.h"

@implementation ShoppingCarView{
    UIImageView *imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    //创建购物车imageView
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 40, 40)];
    //添加图片
    imageView.image = [UIImage imageNamed:@"购物车"];
    [self addSubview:imageView];
    //创建label
    self.shoppingLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 20, 20)];
    _shoppingLabel.backgroundColor = [UIColor redColor];
    _shoppingLabel.font = [UIFont systemFontOfSize:12];
    [_shoppingLabel setTextAlignment:UITextAlignmentCenter];
    //将图层的边框设置为圆脚
    _shoppingLabel.layer.cornerRadius = 10;
    
    _shoppingLabel.layer.masksToBounds = YES;
     _shoppingLabel. alpha = 0 ;
    [self addSubview:_shoppingLabel];
    
}
@end
