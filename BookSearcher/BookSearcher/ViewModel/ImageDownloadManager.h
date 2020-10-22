//
//  ImageDownloadManager.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloadManager : NSObject

+ (instancetype)sharedInstance;
- (void)downloadBookImageWithString:(NSString *)urlString handler:(void (^)(UIImage *))completeHandler;

@end

NS_ASSUME_NONNULL_END
