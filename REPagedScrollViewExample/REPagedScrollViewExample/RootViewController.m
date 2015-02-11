//
//  RootViewController.m
//  REPagedScrollViewExample
//
//  Created by Roman Efimov on 5/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "REPagedScrollView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	REPagedScrollView *scrollView = [[REPagedScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.orientation = ScrollOrientationHorizontal;
    [scrollView addPageControl];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    test.backgroundColor = [UIColor lightGrayColor];
    [scrollView addPage:test];
    
    test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    test.backgroundColor = [UIColor blueColor];
    [scrollView addPage:test];
    
    test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    test.backgroundColor = [UIColor greenColor];
    [scrollView addPage:test];
    
    test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    test.backgroundColor = [UIColor redColor];
    [scrollView addPage:test];
    
    test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    test.backgroundColor = [UIColor yellowColor];
    [scrollView addPage:test];

}

@end
