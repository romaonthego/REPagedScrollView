//
// REPagedScrollView.h
// REPagedScrollView
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface REPagedScrollView : UIView <UIScrollViewDelegate>

@property (strong, readonly, nonatomic) UIScrollView *scrollView;
@property (strong, readonly, nonatomic) UIPageControl *pageControl;
@property (assign, readonly, nonatomic) NSUInteger numberOfPages;
@property (strong, readonly, nonatomic) NSArray *pages;
@property (weak, readwrite, nonatomic) id<UIScrollViewDelegate> delegate;

typedef NS_ENUM(NSInteger, ScrollOrientation) {
    ScrollOrientationHorizontalBottom,
    ScrollOrientationHorizontalTop,
    ScrollOrientationVerticalLeft,
    ScrollOrientationVerticalRight,
};

@property (readwrite, nonatomic) ScrollOrientation orientation;
@property (nonatomic) float pageControlWeight;

- (void)addPageControl;
- (void)addPage:(UIView *)pageView;
- (void)scrollToPageWithIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
