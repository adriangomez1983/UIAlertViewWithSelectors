//
//  ViewController.m
//  AlertViewWithSelectorsExample
//
//  Created by Néstor Adrián Gómez Elfi on 5/26/13.
//  Copyright (c) 2013 Néstor Adrián Gómez Elfi. All rights reserved.
//

#import "ViewController.h"
#import "MultiTargetUIAlertView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    MultiTargetUIAlertView *_alertView;
    UITableView *_tableView;
    NSMutableDictionary *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _alertView = [[MultiTargetUIAlertView alloc] initWithTitle:@"Selector your task" message:@"What wuold you like to do?" delegate:nil cancelButtonTitle:@"Nothing" otherButtonTitles:@"Paint the background in red", nil];
    
    NSInteger index = [_alertView addButtonWithTitle:@"Put a label"];
    
    [_alertView addTarget:self andSelector:@selector(cancelMethod) forButtonIndex:[_alertView cancelButtonIndex]];
    [_alertView addTarget:self andSelector:@selector(paintInRed) forButtonIndex:1];
    [_alertView addTarget:self andSelector:@selector(placeALabel) forButtonIndex:index];
    
    [_alertView show];
    

	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelMethod
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Goodbye" message:@"Thanks for trying me!" delegate:nil cancelButtonTitle:@"Bye" otherButtonTitles:nil];
    [alert show];
}

-(void)paintInRed
{
    self.view.backgroundColor = [UIColor redColor];
}

-(void)placeALabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2) - 75, ([UIScreen mainScreen].bounds.size.height/2)-20, 150, 40)];
    label.text = @"New label";
    [self.view addSubview:label];
}

@end
