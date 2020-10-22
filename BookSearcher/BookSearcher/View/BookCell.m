//
//  BookCell.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookCell.h"
#import "ImageDownloadManager.h"
#import "Book.h"

@interface BookCell ()
@end

@implementation BookCell

- (void)setCellData:(Book *)book
{
    [ImageDownloadManager.sharedInstance downloadBookImageWithString:book.image handler:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
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
