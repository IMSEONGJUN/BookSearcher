//
//  BookDetailViewController.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookDetailViewController.h"
#import "BookDetail.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bookImageView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.subtitleLabel = [[UILabel alloc] init];
        self.authorsLabel = [[UILabel alloc] init];
        self.publisherLabel = [[UILabel alloc] init];
        self.languageLabel = [[UILabel alloc] init];
        self.isbn10Label = [[UILabel alloc] init];
        self.isbn13Label = [[UILabel alloc] init];
        self.pagesLabel = [[UILabel alloc] init];
        self.yearLabel = [[UILabel alloc] init];
        self.ratingLabel = [[UILabel alloc] init];
        self.descLabel = [[UILabel alloc] init];
        self.priceLabel = [[UILabel alloc] init];
        self.urlLabel = [[UILabel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureImageView];
    [self configureStackView];
}

- (void)configureImageView
{
    CGFloat imageViewTop = 50;
    CGFloat imageViewSize = 150;
    
    [self.view addSubview:self.bookImageView];
    self.bookImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_bookImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[_bookImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:imageViewTop] setActive:YES];
    [[_bookImageView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor] setActive:YES];
    [[_bookImageView.widthAnchor constraintEqualToConstant:imageViewSize] setActive:YES];
    [[_bookImageView.heightAnchor constraintEqualToConstant:imageViewSize] setActive:YES];
}

-(void)configureStackView
{
    CGFloat margin = 20;
    
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
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.subtitleLabel.font = [UIFont systemFontOfSize:15];
    self.subtitleLabel.textColor = [UIColor darkGrayColor];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:18];
    self.urlLabel.textColor = [UIColor blueColor];
    
    UIStackView *detailStack = [[UIStackView alloc] initWithArrangedSubviews:labels];
    [detailStack setAxis:UILayoutConstraintAxisVertical];
    detailStack.spacing = 8;
    
    for (UILabel *label in labels) {
        label.numberOfLines = 0;
    }
    
    [self.view addSubview:detailStack];
    [detailStack setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[detailStack.topAnchor constraintEqualToAnchor: self.bookImageView.bottomAnchor constant:margin] setActive:YES];
    [[detailStack.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:margin] setActive:YES];
    [[detailStack.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-margin] setActive:YES];
}

- (void)setDetailInfomation:(BookDetail *)detail
{
    self.titleLabel.text = [NSString stringWithFormat:@"Title : %@", detail.title];
    self.subtitleLabel.text = [NSString stringWithFormat:@"Subtitle : %@", detail.subtitle];
    self.authorsLabel.text = [NSString stringWithFormat:@"Authors : %@", detail.authors];
    self.publisherLabel.text = [NSString stringWithFormat:@"Publisher : %@", detail.publisher];
    self.languageLabel.text = [NSString stringWithFormat:@"Language : %@", detail.language];
    self.isbn10Label.text = [NSString stringWithFormat:@"ISBN10 : %@", detail.isbn10];
    self.isbn13Label.text = [NSString stringWithFormat:@"ISBN13 : %@", detail.isbn13];
    self.pagesLabel.text = [NSString stringWithFormat:@"Pages : %@", detail.pages];
    self.yearLabel.text = [NSString stringWithFormat:@"Year : %@", detail.year];
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating : %@", detail.rating];
    self.descLabel.text = [NSString stringWithFormat:@"Desc : %@", detail.desc];
    self.priceLabel.text = [NSString stringWithFormat:@"Price : %@", detail.price];
    self.urlLabel.text = [NSString stringWithFormat:@"URL : %@", detail.url];
}

@end
