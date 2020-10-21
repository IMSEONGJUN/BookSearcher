//
//  BookDetailViewController.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailViewController : UIViewController

@property (nonatomic) UIImageView *bookImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;
@property (nonatomic) UILabel *isbnLabel;
@property (nonatomic) UILabel *priceLabel;
@property (nonatomic) UILabel *urlLabel;

@end

NS_ASSUME_NONNULL_END
