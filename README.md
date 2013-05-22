# REPagedScrollView

Paged UIScrollView with an embedded UIPageControl.

<img src="https://github.com/romaonthego/REPagedScrollView/raw/master/Screenshot.png" alt="REPagedScrollView Screenshot" width="320" height="480" />

## Requirements
* Xcode 4.5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

## Demo

Build and run the `REPagedScrollViewExample` project in Xcode to see `REPagedScrollView` in action.

## Installation

### CocoaPods

The recommended approach for installating `REPagedScrollView` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.15.2** using Git >= **1.8.0** installed via Homebrew.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add REPagedScrollView:

``` bash
platform :ios, '5.0'
pod 'REPagedScrollView', '~> 1.0'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

Please note that if your installation fails, it may be because you are installing with a version of Git lower than CocoaPods is expecting. Please ensure that you are running Git >= **1.8.0** by executing `git --version`. You can get a full picture of the installation details by executing `pod install --verbose`.

### Manual Install

All you need to do is drop `REPagedScrollView` files into your project, and add `#include "REPagedScrollView.h"` to the top of classes that will use it.

## Example Usage

``` objective-c
REPagedScrollView *scrollView = [[REPagedScrollView alloc] initWithFrame:self.view.bounds];
[self.view addSubview:scrollView];

UIView *page1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
page1.backgroundColor = [UIColor lightGrayColor];
[scrollView addPage:page1];

UIView *page2 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
page2.backgroundColor = [UIColor blueColor];
[scrollView addPage:page2];
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

REPagedScrollView is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.