//
//  PairingViewController.m
//  Game
//
//  Created by Celleus on 2016/05/26.
//  Copyright © 2016年 Game. All rights reserved.
//

#import "PairingViewController.h"

@interface PairingViewController () <MEMELibDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation PairingViewController

- (void)loadView {
    [super loadView];
    self.peripherals = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ペアリング";
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.88 blue:0.8 alpha:1];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切断"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(disConnect:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"検索"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(scan:)];
    
    self.peripheralListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            self.view.frame.size.width,
                                                                            self.view.frame.size.height)
                                                           style:UITableViewStylePlain];
    self.peripheralListTableView.delegate = self;
    self.peripheralListTableView.dataSource = self;
    self.peripheralListTableView.backgroundColor = [UIColor clearColor];
    self.peripheralListTableView.separatorColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    [self.view addSubview:self.peripheralListTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disConnect:(id)sender {
    NSLog(@"disConnect");
    [[MEMELib sharedInstance] disconnectPeripheral];
}

- (IBAction)scan:(id)sender {
    NSLog(@"scan");
    
    [[MEMELib sharedInstance] stopScanningPeripherals];
    
    [self.peripherals removeAllObjects];
    [self.peripheralListTableView reloadData];
    
    [[MEMELib sharedInstance] startScanningPeripherals];
    
    [self performSelector:@selector(stopScan) withObject:nil afterDelay:15.0];
}

- (void)stopScan {
    NSLog(@"stopScan");
    [[MEMELib sharedInstance] stopScanningPeripherals];
}

//**************************************************
// tableview delegate
//**************************************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.peripherals count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CBPeripheral *peripheral = [self.peripherals objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.1 alpha:1];
    cell.textLabel.text = [peripheral.identifier UUIDString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![MEMELib sharedInstance].isConnected) {
        CBPeripheral *peripheral = [self.peripherals objectAtIndex: indexPath.row];
        [[MEMELib sharedInstance] connectPeripheral:peripheral];
        NSLog(@"Start connecting to MEME Device...:%@",[peripheral.identifier UUIDString]);
    }
}

@end
