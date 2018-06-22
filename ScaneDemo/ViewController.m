//
//  ViewController.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "SPScanVC.h"
#import "Masonry.h"
#import "SPLeftBubbleView.h"
#import "SPBubbleImageView.h"
#import "SPBezierLineChartView.h"
#import "SPRangGanNumView.h"
#import "SPEditScoreView.h"
#import "SPShareView.h"
#import "SPSetRangGanView.h"
#import "SPUserScoreView.h"
#import "SPPkAlertView.h"
#import "SPTriangleView.h"
@interface ViewController ()

@property (nonatomic,strong) SPLeftBubbleView *dubbleView;
@property (nonatomic,strong) SPBubbleImageView *imageView;
@property (nonatomic,strong) SPBezierLineChartView *lineChaertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    btn.frame = CGRectMake(0, 0, 100, 100);
//    btn.center = self.view.center;
//    [btn setTitle:@"扫描二维码" forState:(UIControlStateNormal)];
//    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//    [btn addTarget:self action:@selector(clickScanAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:btn];
    
    self.dubbleView  = [[SPLeftBubbleView alloc] init];
    
    [self.view addSubview:self.dubbleView];
    [self.dubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(40);
        make.width.mas_greaterThanOrEqualTo(0);
        make.right.mas_lessThanOrEqualTo(-20);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    self.imageView = [[SPBubbleImageView alloc] init];
    self.imageView.imageView.image = [UIImage imageNamed:@"image1"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dubbleView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(205, 200));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
    }];
 
//    self.lineChaertView = [[SPBezierLineChartView alloc] init];
//    self.lineChaertView.backgroundColor = [UIColor whiteColor];
//    self.lineChaertView.firstArray = @[@"-3",@"10",@"5",@"9",@"18"];
//      self.lineChaertView.twoArray = @[@"-1",@"3",@"0",@"5",@"10"];
//    self.lineChaertView.threeArray  =@[@"0",@"5",@"-1",@"6",@"11"];
//    self.lineChaertView.fourArray = @[@"4",@"-3",@"0",@"5",@"1"];
//    self.lineChaertView.fiveAray = @[@"1",@"0",@"-2",@"4",@"6"];
//    self.lineChaertView.sixArray = @[@"3",@"-1",@"7",@"0",@"-2"];
//    [self.view addSubview:self.lineChaertView];
//
//    [self.lineChaertView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.imageView.mas_bottom).offset(10);
//        make.height.mas_equalTo(180);
//    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dubbleView.isRight = NO;
        self.imageView.isRight = YES;
        [self.dubbleView setNeedsDisplay];
         [self.imageView setNeedsDisplay];
    });
    
    
    NSArray *array = @[@"-3",@"-2",@"-1",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    NSInteger start = 1 ;
    NSInteger length = 7;
    
    if (start + length > array.count) {
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SPRangGanNumView showView:@"休闲鞋xx " complete:^(NSArrastry *listArray) {
//            NSLog(@"  listArray   %@",listArray);
//        }];
//        [SPSetRangGanView  showViewForUserArray:@[@"",@"",@"",@""]];
//        [SPPkAlertView  showViewForTitle:@"XXXX" dataArray:@[@"1",@"2",@"3",@"4"] complete:^(NSIndexPath *indexPath) {
//
//        }];
    });
//    SPUserScoreView *scoreView = [[SPUserScoreView alloc] init];
//    scoreView.layer.cornerRadius = 5;
//    scoreView.backgroundColor = [UIColor whiteColor];
//    scoreView.layer.masksToBounds = YES;
//    scoreView.layer.borderColor = [UIColor blackColor].CGColor;
//    scoreView.layer.borderWidth = 1;
//    [self.view addSubview:scoreView];
//    [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.right.equalTo(self.view).offset(-12);
//        make.height.mas_greaterThanOrEqualTo(0);
//        make.top.equalTo(self.imageView.mas_bottom).offset(10);
//    }];
//    NSString *a = [@[@"a,b"] firstObject];
//    NSString *b = [[a mutableCopy] copy];
    // Do any additional setup after loading the view, typically from a nib.
    SPTriangleView *triangleView = [[SPTriangleView  alloc] init];
    triangleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:triangleView];
    [triangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 10));
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
        make.centerX.equalTo(self.view).offset(0);
    }];
    NSArray *numArray = @[@"-3",@"-2",@"-1",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"17",@"18",@"19",@"20"];
    [self clickAdd:1 length:7 array:numArray];
      [self clickAdd:8 length:7 array:numArray];
    [self clickMinu:1 length:7 array:numArray];
      [self clickMinu:8 length:7  array:numArray];
}
/**
 *  转换为json
 */
- (NSDictionary *)stringToJson:(id)jsonString{
    NSDictionary *parmDic;
    if (![jsonString isKindOfClass:[NSDictionary class]] && [jsonString isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)jsonString;
        parmDic =  [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        parmDic = jsonString;
    }
    if (![parmDic isKindOfClass:[NSDictionary class]]) {
        parmDic = @{};
    }
    return parmDic;
}

-(NSString *)getStringFormDic:(id)dicResult{
    if (dicResult) {
        if (![dicResult isKindOfClass:[NSNull class]] && ![dicResult isEqual:nil] && ![dicResult isEqual:[NSNull null]]) {
            NSString *result = @"";
            result = [NSString stringWithFormat:@"%@",dicResult];
            if (result && result.length > 0) {
                if ([result isEqualToString:@"(null)"] || [result isEqualToString:@"<null>"]) {
                    return @"";
                }
                else{
                    return result;
                }
            }
            else{
                return @"";
            }
        }
        else{
            return @"";
        }
    }
    else{
        return @"";
    }
}

- (void)clickAdd:(NSInteger)start length:(NSInteger)length array:(NSArray *)array{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (start + length > array.count) {
        start = array.count - length - 1;
        [list addObject:@"<<"];
        [list addObjectsFromArray:[array subarrayWithRange:NSMakeRange(start, length)]];
    }else{
        if (start != 0) {
             [list addObject:@"<<"];
        }
        [list addObjectsFromArray:[array subarrayWithRange:NSMakeRange(start, length)]];
        [list addObject:@">>"];
    }
    NSLog(@"array is %@------%ld",list,start);
}
- (void)clickMinu:(NSInteger)start  length:(NSInteger)length  array:(NSArray *)array{
      NSMutableArray *list = [[NSMutableArray alloc] init];
    if (start - length < 0) {
        start = 0;
        if (length + 1 < array.count) {
            length ++;
        }
        [list addObjectsFromArray: [array subarrayWithRange:NSMakeRange(start, length)]];
        [list addObject:@">>"];
    }else{
        [list addObject:@"<<"];
        [list addObjectsFromArray:[array subarrayWithRange:NSMakeRange(start, length)]];
        [list addObject:@">>"];
    }
    NSLog(@"%@------%ld",list,start);
}
- (void)clickScanAction {
    SPScanVC *scanVC = [[SPScanVC alloc] init];
    scanVC.scanBackBlock = ^(NSString *scanCodeType, NSString *result) {
        NSLog(@"scanCodeType:%@-----result:%@",scanCodeType,result); 
    };
    [self presentViewController:scanVC animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
