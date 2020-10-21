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
    NSString *endPoint = [NSString stringWithFormat:@"%@/%@/%ld", baseURL, keyword, self.page];
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

@end
