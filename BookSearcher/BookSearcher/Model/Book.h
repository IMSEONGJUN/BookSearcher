//
//  Book.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *isbn13;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle isbn:(NSString *)isbn price:(NSString *)price image:(NSString *)imageURL url:(NSString *)bookURL;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
