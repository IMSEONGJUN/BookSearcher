//
//  BookCell.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookCell.h"
#import "ImageDownloadManager.h"

@interface BookCell ()

@property (nonatomic) ImageDownloadManager *manager;

@end

@implementation BookCell

- (void)setCellData:(Book *)book
{
    self.manager = [[ImageDownloadManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [_manager downloadBookImageWithString:book.image handler:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            self.bookImageView.image = image;
        });
    }];
    
    self.titleLable.text = book.title;
    self.subtitleLabel.text = book.subtitle;
    self.isbnLabel.text = book.isbn13;
    self.priceLabel.text = book.price;
    self.urlLabel.text = book.url;
}

@end
