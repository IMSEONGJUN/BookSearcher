//
//  ImageDownloadManager.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "ImageDownloadManager.h"

@interface ImageDownloadManager ()

@property NSCache *cache;

@end

@implementation ImageDownloadManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)downloadBookImageWithString:(NSString *)urlString handler:(void (^)(UIImage * _Nullable))completeHandler
{
    UIImage *cachedImage = [self.cache objectForKey:urlString];
    if (cachedImage != nil) {
        completeHandler(cachedImage);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Invalid URL: %@",error);
            completeHandler(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        [self.cache setObject:image forKey:urlString];
        completeHandler(image);
        
    }] resume];
}

@end
