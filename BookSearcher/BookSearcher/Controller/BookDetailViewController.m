//
//  BookDetailViewController.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

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
    
}

@end
