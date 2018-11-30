//
//  AFNetManager.m
//  Cybespoke
//
//  Created by pengpeng on 15/10/8.
//  Copyright © 2015年 pengpeng. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "PhotoDBManger.h"
#import "PhotoViewController.h"

@interface PhotoTableViewController ()
{
    NSMutableArray *photos;
    PhotoDBManger *dbManager;
    NSInteger currentRow;
    BOOL selected;
}

@end

@implementation PhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photos = [[NSMutableArray alloc]init];
    
    [self.navigationItem setTitle:@"拍照量体"];
    
    //设置导航栏的背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:33.0/255.0
                                                                             green:30.0/255.0
                                                                              blue:56.0/255.0
                                                                             alpha:1]];
    //设置导航栏上面的文本信息字体以及颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    dbManager  = [PhotoDBManger manager];
    [photos removeAllObjects];
    [photos addObjectsFromArray:[dbManager readData]];
    [self.tableView reloadData];
    currentRow = 0;
    selected   = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"PhotoTableViewCell"];
        cell   = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    }
    // Configure the cell...
    User *user = [photos objectAtIndex:[indexPath row]];
    
    [cell.LblUserName setText:user.userName];
    NSString *heightWeight = [NSString stringWithFormat:@"身高：%ld cm 体重：%0.1f kg", (long)user.height, user.weight];
    [cell.LblHeightWeight setText:heightWeight];
    [cell.ImgFront setImage:[UIImage imageWithContentsOfFile:user.frontPath]];
    [cell.ImgSide setImage :[UIImage imageWithContentsOfFile:user.sidePath]];
    [cell.ImgBackground setImage:[UIImage imageWithContentsOfFile:user.backgroundPath]];
    //修改了显示提交的label样式
    if (user.state) {
        [cell.LblState setText:@"已提交"];
        cell.LblState.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        [cell.LblState setText:@"未提交"];
        cell.LblState.backgroundColor = [UIColor redColor];
    }
    [cell.LblState setTextColor:[UIColor whiteColor]];
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 208;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [photos removeObjectAtIndex:[indexPath row]];
        [dbManager writeData:photos];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentRow = indexPath.row;
    selected   = YES;
    
    [self performSegueWithIdentifier:@"List2Detail" sender:self];
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"List2Detail"] && selected) {
        PhotoViewController *destVC = [segue destinationViewController];
        [destVC setUser:[photos objectAtIndex:currentRow]];
    }
}

- (IBAction)btnNewPhoto:(id)sender {
    [self performSegueWithIdentifier:@"List2Detail" sender:self];
}
@end
