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
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat contentHeight = self.bookListTableView.contentSize.height;
    CGFloat viewFrameHeight = self.view.frame.size.height;
    CGFloat contentOffsetY = self.bookListTableView.contentOffset.y;
    NSLog(@"scrolling END");
    if ( contentOffsetY > contentHeight - viewFrameHeight ) {
        if (self.searchManager.isSearching) {
            return;
        }
        [self fetchBookInfoWithKeyword:self.searchBar.text];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchManager.page = 0;
    self.searchManager.hasMoreBooks = YES;
    [self fetchBookInfoWithKeyword:self.searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


- (IBAction)handleTapGesture:(id)sender
{
    [_searchBar resignFirstResponder];
}

- (void)fetchBookInfoWithKeyword:(NSString *)keyword
{
    if (self.searchManager.isSearching) {
        return;
    }
    
    [_spinner startAnimating];
    [_searchManager fetchBookListWithKeyword:keyword page: self.searchManager.page + 1  handler:^(NSError *err) {
        
        if (err != nil) {
            NSLog(@"%@",err);
            return;
        }
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            [self.bookListTableView reloadData];
            [self.spinner stopAnimating];
        });
    }];
}

@end
