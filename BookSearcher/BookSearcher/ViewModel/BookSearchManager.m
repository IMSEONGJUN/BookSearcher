//
//  BookSearchManager.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookSearchManager.h"
#import "Book.h"

@interface BookSearchManager ()

@property NSCache *cache;

@end

@implementation BookSearchManager

NSString *baseURL = @"https://api.itbook.store/1.0/search";
NSInteger perPage = 15;

- (instancetype)init
{
    if (self = [super init]) {
        self.books = [[NSMutableArray alloc] init];
        self.isSearching = NO;
        self.hasMoreBooks = YES;
        self.page = 0;
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)fetchBookListWithKeyword:(NSString *)keyword
                            page:(NSInteger)page
                         handler:(void (^)(NSError* _Nullable))completeHandler
{
//    if (!self.hasMoreBooks) {
//        NSLog(@"No more List!!");
//        return;
//    }
    
    NSString *endPoint = [NSString stringWithFormat:@"%@/%@/?per_page=%ld&page=%ld", baseURL, keyword, perPage, page];
    NSURL *url = [NSURL URLWithString:endPoint];
    
    if ([self.cache objectForKey:endPoint] != nil) {
        [_books addObjectsFromArray:[self.cache objectForKey:endPoint]];
    }
    
    self.isSearching = YES;
    __weak typeof(self) weakSelf = self;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        NSError *err;
        NSDictionary *bookJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize: %@", err);
            completeHandler(err);
            return;
        }
        
        NSArray *booksArray = [NSArray arrayWithArray:bookJSON[@"books"]];
        
        NSMutableArray<Book *> *books = [[NSMutableArray alloc] init];
        for (NSDictionary *bookDict in booksArray) {
            Book *book = [[Book alloc] init];
            book.title = bookDict[@"title"];
            book.subtitle = bookDict[@"subtitle"];
            book.isbn13 = bookDict[@"isbn13"];
            book.price = bookDict[@"price"];
            book.image = bookDict[@"image"];
            book.url = bookDict[@"url"];
            [books addObject:book];
        }
        
//        if (books.count < perPage) {
//            self.hasMoreBooks = NO;
//        }
        
        [self.books addObjectsFromArray:books];
        
        [self.cache setObject:books forKey:endPoint];
        
        self.isSearching = NO;
        
        completeHandler(nil);
    }] resume];
}

@end
