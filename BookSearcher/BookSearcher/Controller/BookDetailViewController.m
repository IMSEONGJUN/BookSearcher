//
//  BookDetailViewController.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@property (nonatomic) NSString *isbn;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configureUI
{
    [self configureImageView];
    [self configureStackView];
}

- (void)configureImageView
{
    [self.view addSubview:_bookImageView];
    self.bookImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bookImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:
       [NSArray arrayWithObjects:
          [_bookImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50],
          [_bookImageView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
          [_bookImageView.widthAnchor constraintEqualToConstant:300],
          [_bookImageView.heightAnchor constraintEqualToConstant:300],
          nil
       ]
    ];
}

-(void)configureStackView
{
    NSArray *labels = [NSArray arrayWithObjects:
                       self.titleLabel,
                       self.subtitleLabel,
                       self.authorsLabel,
                       self.publisherLabel,
                       self.languageLabel,
                       self.isbn10Label,
                       self.isbn13Label,
                       self.pagesLabel,
                       self.yearLabel,
                       self.ratingLabel,
                       self.descLabel,
                       self.priceLabel,
                       self.urlLabel,
                       nil];
    
    UIStackView *detailStack = [[UIStackView alloc] initWithArrangedSubviews:labels];
    detailStack.spacing = 8;
    for (UILabel *label in labels) {
        label.numberOfLines = 0;
    }
    
    [self.view addSubview:detailStack];
    [detailStack setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[detailStack.topAnchor constraintEqualToAnchor: self.bookImageView.bottomAnchor constant:20] setActive:YES];
    [[detailStack.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:20] setActive:YES];
    [[detailStack.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-20] setActive:YES];
    [[detailStack.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor constant:-20] setActive:YES];
}

@end
