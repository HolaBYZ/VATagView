//
//  VATagViewCollectionViewCell.m
//  NTSignMaster
//
//  Created by 栗子哇 on 2018/10/10.
//  Copyright © 2018 NineTonTech. All rights reserved.
//

#import "VATagViewCollectionViewCell.h"
#import "CreateOrderModel.h"
#import "CreateOrderCombosModel.h"
#import "CreateOrderAdditionalModel.h"
#import "CreateOrderRemarkModel.h"


@implementation VATagViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.tagLabel = [[UILabel alloc]init];
    self.tagLabel.font = NTFont(12);
    self.tagLabel.textColor = NT_HEX(#353C46);
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel nt_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self).offset(0);
    }];
    self.userInteractionEnabled = YES;
    self.contentView.userInteractionEnabled = YES;

}
- (void)setIsInSearch:(BOOL)isInSearch{
    if (isInSearch) {
        self.contentView.layer.backgroundColor = NT_HEX(#F2F2F2).CGColor;
        self.contentView.layer.cornerRadius = self.contentView.frame.size.height / 2.;
        self.contentView.layer.masksToBounds = YES;
    }else{
        self.contentView.layer.backgroundColor = NT_HEX(#F5F5F5).CGColor;
        self.contentView.layer.cornerRadius = 4;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.masksToBounds = YES;
    }
}

- (void)setContent:(NSString *)content{
    _content = content;
    [_tagLabel setText:content];
}

- (void)setOrederModel:(CreateOrderModel *)orederModel{
    _orederModel = orederModel;
    [_tagLabel setText:orederModel.title];
    if (orederModel.isSelected) {
        _tagLabel.textColor = NT_HEX(#3E7BE6);
        self.contentView.layer.borderColor = NT_HEX(#3E7BE6).CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F9FF).CGColor;
    }else{
        self.tagLabel.textColor = NT_HEX(#353C46);
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F5F5).CGColor;
    }
}

- (void)setCombosModel:(CreateOrderCombosModel *)combosModel{
    _combosModel = combosModel;
    [self.tagLabel setText:combosModel.title];
    if (combosModel.isSelected.integerValue == 1) {
        self.tagLabel.textColor = NT_HEX(#3E7BE6);
        self.contentView.layer.borderColor = NT_HEX(#3E7BE6).CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F9FF).CGColor;
    }else{
        self.tagLabel.textColor = NT_HEX(#353C46);
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F5F5).CGColor;
    }
}

- (void)setAdditionalModel:(CreateOrderAdditionalModel *)additionalModel{
    _additionalModel = additionalModel;
    [_tagLabel setText:additionalModel.title];
    if (additionalModel.isSelected.integerValue == 1) {
        _tagLabel.textColor = NT_HEX(#3E7BE6);
        self.contentView.layer.borderColor = NT_HEX(#3E7BE6).CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F9FF).CGColor;
    }else{
        self.tagLabel.textColor = NT_HEX(#353C46);
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F5F5).CGColor;
    }
}

- (void)setRemarkModel:(CreateOrderRemarkModel *)remarkModel{
    _remarkModel = remarkModel;
    [_tagLabel setText:remarkModel.title];
    if (remarkModel.isSelected) {
        self.tagLabel.textColor = NT_HEX(#3E7BE6);
        self.contentView.layer.borderColor = NT_HEX(#3E7BE6).CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F9FF).CGColor;
    }else{
        self.tagLabel.textColor = NT_HEX(#353C46);
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.backgroundColor = NT_HEX(#F5F5F5).CGColor;
    }
}

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxWidth - 20, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width + 20, cellHeight);
}

@end
