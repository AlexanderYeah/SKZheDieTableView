//
//  ShowTb_VC.m
//  ZDTableView
//
//  Created by Alexander on 2018/7/3.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ShowTb_VC.h"

@interface ShowTb_VC ()
// 存放菜单的数组
@property (nonatomic , retain) NSMutableArray * itemArray ;

@property (nonatomic , retain) NSMutableArray * openItemArray ;
@end

@implementation ShowTb_VC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.itemArray = [[NSMutableArray alloc] init] ;
	self.openItemArray = [[NSMutableArray alloc] init] ;
	
	[self loadLocalPlist];
}

- (void)loadLocalPlist
{
	
	if ([self.itemArray count]) {
		[self.itemArray removeAllObjects] ;
	}
	
	NSString * path= [[NSBundle mainBundle] pathForResource:@"Spot" ofType:@"plist"] ;
	NSDictionary * dic = [[NSDictionary alloc] initWithContentsOfFile:path];
	NSArray * nameArray = [dic allKeys];
	
		//一级菜单
	for (int i = 0 ; i < [nameArray count]; i++) {
		NSMutableDictionary * menuDic_1 = [NSMutableDictionary dictionary] ;
		[menuDic_1 setObject:@"0" forKey:@"level"] ;
		[menuDic_1 setObject:[nameArray objectAtIndex:i] forKey:@"name"] ;
		[self.itemArray addObject:menuDic_1] ;
		
		if (![self.openItemArray count]) {
			//如果没有打开项
			continue ;
		}
		//判断打开的菜单
		for (int j = 0 ; j < [self.openItemArray count]; j++) {
			if ([[[self.openItemArray objectAtIndex:j] objectForKey:@"name"] isEqualToString:[nameArray objectAtIndex:i]]) {
				
				//二级菜单
				NSDictionary *twoDic = [dic objectForKey:[nameArray objectAtIndex:i]] ;
				NSArray * twoArray = [twoDic allKeys]  ;
				for (int k = 0 ; k < [twoArray count] ; k++) {
					NSMutableDictionary * menuDic_2 = [NSMutableDictionary dictionary] ;
					[menuDic_2 setObject:@"2" forKey:@"level"] ;
					[menuDic_2 setObject:[twoArray objectAtIndex:k] forKey:@"name"] ;
					
					[self.itemArray addObject:menuDic_2] ;
				}
			}
		}
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.itemArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
    if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
    NSDictionary *dic = [self.itemArray objectAtIndex:[indexPath row]] ;
	
	if(![[dic objectForKey:@"level"] intValue])
	{
		//如果为0则为主菜单
		cell.selectionStyle = UITableViewCellSelectionStyleNone ;
	}// Configure the cell.
	else {
		cell.selectionStyle = UITableViewCellSelectionStyleBlue ;
	}
	cell.textLabel.text = [dic objectForKey:@"name"];
    
    // Configure the cell...
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *dic = [self.itemArray objectAtIndex:[indexPath row]] ;
	
	if(![[dic objectForKey:@"level"] intValue])
	{
		//如果为0则为主菜单
		for (int i = 0 ; i < [self.openItemArray count]; i++) {
			if ([[[self.openItemArray objectAtIndex:i] objectForKey:@"name"] isEqualToString:[dic objectForKey:@"name"]]) {
				[self.openItemArray removeObjectAtIndex:i] ;
				[self loadLocalPlist] ;
				[self.tableView reloadData] ;
				
				return ;
			}
		}
		
		//
		[self.openItemArray addObject:dic] ;
		[self loadLocalPlist] ;
		[self.tableView reloadData] ;
	}
	else {
		//如果是菜单项处理相关操作
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
