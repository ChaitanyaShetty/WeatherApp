//
//  SearchViewController.h
//  Weather App
//
//  Created by chaitanya on 16/10/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewControllerDelegate <NSObject>

- (void) searchedText:(NSString*)text;

@end

@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *contentList;
    NSString *urlString;
    
    
}

@property (weak, nonatomic) id<SearchViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *results;

@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
