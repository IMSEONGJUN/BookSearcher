//
//  BookDetailViewController.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "BookDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailViewController : UIViewController

@property (nonatomic) UIImageView *bookImageView;

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;
@property (nonatomic) UILabel *priceLabel;
@property (nonatomic) UILabel *urlLabel;
@property (nonatomic) UILabel *authorsLabel;
@property (nonatomic) UILabel *publisherLabel;
@property (nonatomic) UILabel *isbn10Label;
@property (nonatomic) UILabel *isbn13Label;
@property (nonatomic) UILabel *pagesLabel;
@property (nonatomic) UILabel *yearLabel;
@property (nonatomic) UILabel *ratingLabel;
@property (nonatomic) UILabel *descLabel;
@property (nonatomic) UILabel *languageLabel;

- (void)setDetailInfomation:(BookDetail *)detail;

@end

NS_ASSUME_NONNULL_END
