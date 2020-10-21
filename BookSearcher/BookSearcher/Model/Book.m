//
//  Book.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle isbn:(NSString *)isbn price:(NSString *)price image:(NSString *)imageURL url:(NSString *)bookURL
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.isbn13 = isbn;
        self.price = price;
        self.image = imageURL;
        self.url = bookURL;
    }
    return self;
}

@end
