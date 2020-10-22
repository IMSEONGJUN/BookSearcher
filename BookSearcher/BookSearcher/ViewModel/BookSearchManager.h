//
//  BookSearchManager.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book,
       BookDetail;

@interface BookSearchManager : NSObject

@property (strong, nonatomic) NSMutableArray<Book *> *books;
@property (nonatomic) BOOL isSearching;
@property (nonatomic) NSInteger page;
@property (nonatomic) BOOL hasMoreBooks;

- (void)fetchBookListWithKeyword:(NSString *)keyword handler:(void (^)(NSError* _Nullable))completeHandler;
- (void)fetchBookDetailInfoWithISBN:(NSString *)isbn handler:(void (^)(BookDetail* _Nullable))completeHandler;

@end

NS_ASSUME_NONNULL_END
