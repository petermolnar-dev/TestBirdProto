//
//  ViewController.m
//  Touche
//
//  Created by Peter Molnar on 29/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *xPosLabel;
@property (weak, nonatomic) IBOutlet UILabel *yPosLabel;

@property (weak, nonatomic, nullable) UIView *clickedView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    self.xPosLabel.text = @"";
    self.yPosLabel.text = @"";
    UIView *newClickedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    newClickedView.backgroundColor = [UIColor whiteColor];
    self.clickedView = newClickedView;
    [self.view addSubview:self.clickedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *firstTouch = [[touches allObjects] firstObject];
    
    NSLog(@"Tpuch started at: x: %f, y:%f", [firstTouch locationInView:self.view].x, [firstTouch locationInView:self.view].y );
    self.xPosLabel.text = [NSString stringWithFormat:@"X pos: %f",[firstTouch locationInView:self.view].x];
    self.yPosLabel.text = [NSString stringWithFormat:@"Y pos: %f",[firstTouch locationInView:self.view].y];
    UIView *newClickedView = [[UIView alloc] initWithFrame:CGRectMake([firstTouch locationInView:self.view].x, [firstTouch locationInView:self.view].y, 10, 10)];
    newClickedView.backgroundColor = [UIColor blackColor];
    [self.clickedView removeFromSuperview];
    [self.view addSubview:newClickedView];
    
    [self.view setNeedsDisplay];
}


@end
