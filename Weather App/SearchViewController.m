//
//  SearchViewController.m
//  Weather App
//
//  Created by chaitanya on 16/10/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "SearchViewController.h"
#import "TableViewCell.h"

@interface SearchViewController ()
{
    NSURLSessionDataTask *dataTask;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.results = [[NSMutableArray alloc]init];
    contentList = [[NSMutableArray alloc]init];
    
    urlString = [[NSString alloc]init];
}

- (void) callAPI:(NSString*)location {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    urlString  = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&location=12.9716,-77.5946&radius=500&key=AIzaSyDXgFSzWaFvzXq_65CkhRsxL0-o1-XH89E", location];
    
    [dataTask suspend];
    dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            
            
            self.results = [json valueForKey:@"predictions"];
            //            NSArray *listArray = [_results valueForKey:@"description"];
            
            NSLog(@"All the data %@", _results);
            
            [contentList removeAllObjects];
            if (_results != nil) {
                for (NSDictionary *search  in _results) {
                    
                    NSRange r = [[search valueForKey:@"description"] rangeOfString:location];
                    if (r.location !=NSNotFound) {
                        [contentList addObject:search];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.myTableView reloadData];
                    
                });
                 }
        }
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [contentList removeAllObjects];
    }
    else {
        [self callAPI:searchText];
    }
    
    [self.myTableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    
    NSDictionary* obj = [contentList objectAtIndex:indexPath.row];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:20.0]];
    
    
    cell.textLabel.textColor = [UIColor redColor];
    
    cell.textLabel.text = [obj valueForKey:@"description"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* obj = [contentList objectAtIndex:indexPath.row];
    [_delegate searchedText:[obj valueForKey:@"description"]];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
