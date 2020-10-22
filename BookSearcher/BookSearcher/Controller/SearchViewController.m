//
//  SearchViewController.m
//  BookSearcher
//
//  Created by SEONGJUN on 2020/10/21.
//

#import "SearchViewController.h"
#import "BookCell.h"
#import "Book.h"
#import "BookSearchManager.h"
#import "BookDetailViewController.h"
#import "ImageDownloadManager.h"
#import "NotificationNames.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *bookListTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) BookSearchManager *searchManager;

@end

@implementation SearchViewController

NSString *reuseID = @"BookCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchManager = [[BookSearchManager alloc] init];
    [_bookListTableView setDataSource:self];
    [_bookListTableView setDelegate:self];
    [_searchBar setDelegate:self];
    [self configureNotificationReaction];
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchManager.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    Book *book = self.searchManager.books[indexPath.row];
    [cell setCellData:book];
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    BookCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *isbn = cell.isbnLabel.text;
    
    BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
    bookDetailVC.bookImageView.image = cell.bookImageView.image;
    bookDetailVC.title = cell.titleLable.text;
    
    
    [self.searchManager fetchBookDetailInfoWithISBN:isbn handler:^(BookDetail * _Nullable detail) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [bookDetailVC setDetailInfomation:detail];
        });
    }];
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([_searchBar.text isEqualToString:@""]) {
        return;
    }
    
    CGFloat contentHeight = self.bookListTableView.contentSize.height;
    CGFloat viewFrameHeight = self.view.frame.size.height;
    CGFloat contentOffsetY = self.bookListTableView.contentOffset.y;
    
    if ( contentOffsetY > contentHeight - viewFrameHeight ) {
        if (self.searchManager.isSearching) {
            return;
        }
        [self fetchBookInfoWithKeyword:self.searchBar.text];
    }
}


#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchManager.books removeAllObjects];
    self.searchManager.page = 0;
    self.searchManager.hasMoreBooks = YES;
    [self fetchBookInfoWithKeyword:self.searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


#pragma mark - API Service
- (void)fetchBookInfoWithKeyword:(NSString *)keyword
{
    if (self.searchManager.isSearching) {
        return;
    }
    
    [_spinner startAnimating];
    [_searchManager fetchBookListWithKeyword:keyword handler:^(NSError *err) {
        
        if (err != nil) {
            NSLog(@"%@",err);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bookListTableView reloadData];
            [self.spinner stopAnimating];
        });
    }];
}


#pragma mark - Set Noti Reaction

- (void)configureNotificationReaction
{
    [NSNotificationCenter.defaultCenter addObserverForName: [NotificationNames noResults] object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull noti) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No result"
                                                                       message:@"There are no such books"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end
