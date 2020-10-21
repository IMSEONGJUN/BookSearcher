//
//  BookCell.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

- (void)setCellData:(Book *)book;


@end

NS_ASSUME_NONNULL_END
