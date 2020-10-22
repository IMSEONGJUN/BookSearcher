//
//  BookShopViewController.h
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookShopViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
