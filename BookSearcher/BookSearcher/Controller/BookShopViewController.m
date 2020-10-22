//
//  BookShopViewController.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/22.
//

#import "BookShopViewController.h"
#import <WebKit/WebKit.h>

@interface BookShopViewController ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIToolbar *toolbar;
@property (nonatomic) UIBarButtonItem *back;
@property (nonatomic) UIBarButtonItem *forward;
@property (nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation BookShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(didTapCloseButton)];
    [self.navigationItem setLeftBarButtonItem:closeButton];
    
    [self configureWebView];
    [self configureToolBar];
    [self configureActivityIndicator];
    
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    [self goToWebPageWithURLString:self.url];
}


#pragma mark - Initial UI Setup

- (void)configureWebView
{
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [_webView setBackgroundColor:[UIColor whiteColor]];
    
    [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[_webView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[_webView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor] setActive:YES];
    [[_webView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor] setActive:YES];
    [[_webView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-50] setActive:YES];
}

- (void)configureToolBar
{
    self.toolbar = [[UIToolbar alloc] init];
    [_toolbar setBackgroundColor:[UIColor whiteColor]];
    
    self.back = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.left"] style:UIBarButtonItemStylePlain target:nil action:@selector(didTapToolBarButton:)];
    [_back setTag:0];
    [_back setEnabled:NO];
    
    self.forward = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.right"] style:UIBarButtonItemStylePlain target:nil action:@selector(didTapToolBarButton:)];
    [_forward setTag:1];
    [_forward setEnabled:NO];
    
    [_toolbar setItems:[NSArray arrayWithObjects: self.back,
                        UIBarButtonItem.flexibleSpaceItem,
                        self.forward, nil]];
    
    [self.view addSubview:_toolbar];
    [_toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[_toolbar.topAnchor constraintEqualToAnchor:self.webView.bottomAnchor] setActive:YES];
    [[_toolbar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor] setActive:YES];
    [[_toolbar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor] setActive:YES];
    [[_toolbar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:YES];
    
}

- (void)configureActivityIndicator
{
    self.indicator = [[UIActivityIndicatorView alloc] init];
    [_indicator setHidesWhenStopped:YES];
    [_indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleLarge];
    [_indicator setTintColor:[UIColor blueColor]];
    
    [self.view addSubview:self.indicator];
    [[_indicator.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor] setActive:YES];
    [[_indicator.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor] setActive:YES];
}


#pragma mark - Action Handler
- (void)didTapToolBarButton:(UIBarButtonItem *)sender
{
    switch (sender.tag) {
        case 0:
            [_webView goBack];
            break;
        case 1:
            [_webView goForward];
            break;
        default:
            break;
    }
}

- (void)didTapCloseButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - WKWebView

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [_back setEnabled:self.webView.canGoBack];
    [_forward setEnabled:self.webView.canGoForward];
    [_indicator stopAnimating];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [_webView reload];
}

- (void)goToWebPageWithURLString:(NSString *)urlString
{
    [_indicator startAnimating];
    NSURL *url = [NSURL URLWithString: urlString];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
