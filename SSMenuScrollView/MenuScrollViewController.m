
//
//  MenuScrollViewController.m
//  SSMenuScrollView
//
//  Created by feng on 2017/8/23.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "MenuScrollViewController.h"
#import "MenuControlView.h"

#import "CustomerScrollViewModel.h"

@interface MenuScrollViewController ()<MenuControlViewDeleagte>{

    NSInteger _row;
    NSInteger _col;

}
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property(strong , nonatomic)MenuControlView *pageControlV;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation MenuScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    
    self.tabelView.tableFooterView  = self.pageControlV;

    
    for (int i=0; i<6; i++) {
        CustomerScrollViewModel * model = [[CustomerScrollViewModel alloc ] init];
        NSInteger index = arc4random()%10;
        model.name = [NSString stringWithFormat:@"标题%d",i];
        model.icon = [NSString stringWithFormat:@"6090%ld.png",(long)index];
        [_dataArray addObject:model];
    }
    self.pageControlV.dataArray = _dataArray;
    
    // Do any additional setup after loading the view from its nib.
}


- (MenuControlView *)pageControlV
{
    if (!_pageControlV) {
        _pageControlV = [[MenuControlView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100) withmacCol:2 maxRow:1];
    }
    _pageControlV.delegate = self;
    return _pageControlV;
}

#pragma mark - CustomerScrollViewDeleagte


-(void)menuControlViewDeleagte:(MenuControlView *)MenuControlViewDeleagte index:(NSInteger)index{
    NSLog(@"%ld",(long)index);
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

@end
