//
//  ViewController.m
//  进程管家
//
//  Created by mx1614 on 2/21/19.
//  Copyright © 2019 ludy. All rights reserved.
//

#import "ViewController.h"
#import "ApplicationModel.h"

@interface ViewController()
@property (weak) IBOutlet NSTableView *tableview;

@property (nonatomic, strong) NSMutableArray<ApplicationModel *> *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview setDoubleAction:@selector(handleTableViewDoubleClick:)];

    [self addCurrentRunningApplicationDatas];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(didLaunchApplication) name:NSWorkspaceDidLaunchApplicationNotification object:nil];
//    int a = 2>1?:4;
//    NSLog(@"a = %d", a);
    // Do any additional setup after loading the view.
}

- (void)didLaunchApplication
{
    [self addCurrentRunningApplicationDatas];
}

- (void)handleTableViewDoubleClick:(NSTableView *)tableView
{
    NSInteger selectedIndex = tableView.selectedRow;
    ApplicationModel *appModel = self.dataArr[selectedIndex];
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.informativeText = @"是否杀死该进程";
    alert.messageText = @"温馨提示";
    alert.alertStyle = NSAlertStyleWarning;
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 1000) {
            kill(appModel.processIdentifier, SIGKILL);
            [self.dataArr removeObject:appModel];
            [self.tableview reloadData];
        }
    }];
    
}

- (NSMutableArray *)dataArr
{
    if(!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)addCurrentRunningApplicationDatas
{
    NSArray<NSRunningApplication *> *runningApps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in runningApps) {
        ApplicationModel *appModel = [[ApplicationModel alloc] initApplicationmodelLocalizedName:app.localizedName bundleURL:app.bundleURL processIdentifier:app.processIdentifier launchDate:app.launchDate andIcon:app.icon];
        
        [self.dataArr addObject:appModel];
    }
    
    [self.tableview reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataArr.count;
}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"%s", __func__);
    NSTableCellView *onecell = [tableView makeViewWithIdentifier:@"one" owner:self];
    NSTableCellView *twocell = [tableView makeViewWithIdentifier:@"two" owner:self];
    NSTableCellView *threecell = [tableView makeViewWithIdentifier:@"three" owner:self];
    ApplicationModel *appModel = self.dataArr[row];
    if ([tableColumn.identifier isEqualToString:@"oneColumn"]) {
        onecell.imageView.image = appModel.icon;
        onecell.textField.stringValue = appModel.localizedName;
        onecell.toolTip = appModel.bundleURL.path;
        NSLog(@"onecolumn");
        return onecell;
    }else if ([tableColumn.identifier isEqualToString:@"twoColumn"])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        NSString *currentDateString = [dateFormatter stringFromDate:appModel.launchDate]?:@"";
        twocell.textField.stringValue = currentDateString;
         NSLog(@"twocolumn");
        return twocell;
    }else{
        threecell.textField.stringValue = [NSString stringWithFormat:@"%d", appModel.processIdentifier];
         NSLog(@"threecolumn");
        return threecell;
    }
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
