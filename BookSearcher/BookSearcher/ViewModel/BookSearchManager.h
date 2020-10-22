//
//  BookSearchManager.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "BookDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookSearchManager : NSObject

@property (strong, nonatomic) NSMutableArray<Book *> *books;
@property (atomic) BOOL isSearching;
@property (atomic) NSInteger page;
@property BOOL hasMoreBooks;

- (void)fetchBookListWithKeyword:(NSString *)keyword handler:(void (^)(NSError* _Nullable))completeHandler;
- (void)fetchBookDetailInfo:(NSString *)isbn handler:(void (^)(BookDetail* _Nullable))completeHandler;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
