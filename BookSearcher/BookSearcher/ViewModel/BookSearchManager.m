//
//  BookSearchManager.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookSearchManager.h"
#import "Book.h"
#import "BookDetail.h"

@interface BookSearchManager ()

@property NSCache *cache;

@end

@implementation BookSearchManager

NSString *baseURL = @"https://api.itbook.store/1.0";
//                    https://api.itbook.store/1.0/books/9781430236627
- (instancetype)init
{
    if (self = [super init]) {
        self.books = [[NSMutableArray alloc] init];
        self.isSearching = NO;
        self.page = 0;
        self.hasMoreBooks = YES;
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)fetchBookListWithKeyword:(NSString *)keyword
                         handler:(void (^)(NSError* _Nullable))completeHandler
{
    if (self.hasMoreBooks == NO) {
        NSLog(@"No more List!!");
        completeHandler(nil);
        return;
    }
    self.page += 1;
    NSString *endPoint = [NSString stringWithFormat:@"/search/%@/%@/%ld", baseURL, keyword, self.page];
    NSLog(@"===> loading page: %ld", self.page);
    
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
        NSLog(@"=====> fetched count: %ld", booksArray.count);
        if (booksArray.count < 10) {
            self.hasMoreBooks = NO;
        }
        
        
        NSMutableArray<Book *> *books = [[NSMutableArray alloc] init];
        for (NSDictionary *bookDict in booksArray) {
            Book *book = [[Book alloc] initWithTitle:bookDict[@"title"]
                                            subtitle:bookDict[@"subtitle"]
                                                isbn:bookDict[@"isbn13"]
                                               price:bookDict[@"price"]
                                               image:bookDict[@"image"]
                                                 url:bookDict[@"url"]];
            [books addObject:book];
        }
        
        [self.books addObjectsFromArray:books];
        
        [self.cache setObject:books forKey:endPoint];
        
        self.isSearching = NO;
        
        completeHandler(nil);
    }] resume];
}

- (void)fetchBookDetailInfo:(NSString *)isbn handler:(void (^)(BookDetail* _Nullable))completeHandler
{
    NSString *endPoint = [NSString stringWithFormat:@"/books/%@/", isbn];
    NSURL *url = [NSURL URLWithString:endPoint];
    
    if ([self.cache objectForKey:endPoint] != nil) {
        completeHandler([self.cache objectForKey:endPoint]);
        return;
    }
    
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
            completeHandler(nil);
            return;
        }
        
        BookDetail *detail = [[BookDetail alloc] init];
        detail.title = bookJSON[@"title"];
        detail.subtitle = bookJSON[@"subtitle"];
        detail.authors = bookJSON[@"authors"];
        detail.publisher = bookJSON[@"publisher"];
        detail.language = bookJSON[@"language"];
        detail.isbn10 = bookJSON[@"isbn10"];
        detail.isbn13 = bookJSON[@"isbn13"];
        detail.pages = bookJSON[@"pages"];
        detail.year = bookJSON[@"year"];
        detail.rating = bookJSON[@"rating"];
        detail.desc = bookJSON[@"desc"];
        detail.price = bookJSON[@"price"];
        detail.image = bookJSON[@"image"];
        detail.url = bookJSON[@"url"];
        
        [self.cache setObject:detail forKey:endPoint];
        
        completeHandler(detail);
        
    }] resume];
}

@end
 
