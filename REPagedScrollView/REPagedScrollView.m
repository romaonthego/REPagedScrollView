//
// REPagedScrollView.m
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

#import "REPagedScrollView.h"

@interface REPagedScrollView()

@property (strong, readonly, nonatomic) NSMutableArray *pageViews;

@end

@implementation REPagedScrollView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _pageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addPageControl{
    _pageControlWeight = _pageControlWeight ?: 36;
    if(_orientation == ScrollOrientationVerticalLeft){
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, _pageControlWeight, self.frame.size.height)];
        _pageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else if(_orientation == ScrollOrientationVerticalRight){
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - _pageControlWeight, 0, _pageControlWeight, self.frame.size.height)];
        _pageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else if(_orientation == ScrollOrientationHorizontalTop){
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _pageControlWeight)];
    }else {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _pageControlWeight, self.frame.size.width, _pageControlWeight)];
    }
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_pageControl addTarget:self action:@selector(pageControlPageDidChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

- (void)addPage:(UIView *)page
{
    CGRect rect;
    if(_orientation == ScrollOrientationVerticalLeft || _orientation == ScrollOrientationVerticalRight){
        rect = CGRectMake(0, self.numberOfPages * _scrollView.frame.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }else{
        rect = CGRectMake(self.numberOfPages * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }
    UIView *pageContainerView = [[UIView alloc] initWithFrame:rect];
    [pageContainerView addSubview:page];
    [_scrollView addSubview:pageContainerView];
    [_pageViews addObject:pageContainerView];
    
    if(_orientation == ScrollOrientationVerticalLeft || _orientation == ScrollOrientationVerticalRight){
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height * self.numberOfPages);
    }else{
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * self.numberOfPages, _scrollView.frame.size.height);
    }
    _pageControl.numberOfPages = self.numberOfPages;
}

- (void)scrollToPageWithIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    CGRect frame = _scrollView.frame;
    if(_orientation == ScrollOrientationVerticalLeft || _orientation == ScrollOrientationVerticalRight){
        frame.origin.x = 0;
        frame.origin.y = frame.size.height * pageIndex;
    }else{
        frame.origin.x = frame.size.width * pageIndex;
        frame.origin.y = 0;
    }
    [_scrollView scrollRectToVisible:frame animated:animated];
}

- (NSArray *)pages
{
    return _pageViews;
}

- (NSUInteger)numberOfPages
{
    return _pageViews.count;
}

#pragma mark -
#pragma mark Events

- (void)pageControlPageDidChange:(UIPageControl *)pageControl
{
    [self scrollToPageWithIndex:pageControl.currentPage animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate functions

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page;
    if(_orientation == ScrollOrientationVerticalLeft || _orientation == ScrollOrientationVerticalRight){
        CGFloat pageHeight = scrollView.frame.size.height;
        page = floor((scrollView.contentOffset.y - pageHeight / 2.0) / pageHeight) + 1;
    }else{
        CGFloat pageWidth = scrollView.frame.size.width;
        page = floor((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1;
    }
	_pageControl.currentPage = page;
    
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [_delegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidZoom:)])
        [_delegate scrollViewDidZoom:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [_delegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
        [_delegate scrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [_delegate scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [_delegate scrollViewDidEndScrollingAnimation:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
        return [_delegate viewForZoomingInScrollView:scrollView];
    
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
        [_delegate scrollViewWillBeginZooming:scrollView withView:view];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
        [_delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
        return [_delegate scrollViewShouldScrollToTop:scrollView];
    
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
        [_delegate scrollViewDidScrollToTop:scrollView];
}

@end
