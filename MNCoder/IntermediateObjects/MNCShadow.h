//
//  MNCDropshadow.h
//  MNCoder
//
//  Created by Mark Fleming based on MNCColor.h
//  Copyright (c) 2012 Jeremy Foo
//  
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#endif

#import "MNCIntermediateObjectProtocol.h"

@interface MNCShadow : NSObject <MNCIntermediateObjectProtocol> {
@private
    // NSShadow in ios V6.0 or Mac OS X 10.3
    CGFloat _blurRadius;
    // shadowColor
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _alpha;
    // There are two positional parameters for a shadow: an x-offset and a y-offset. These values are expressed using a single size data type (CGSize on iOS, NSSize on OS X) 
    // _shadowOffset;
    CGFloat _x;
    CGFloat _y;
}

@property (readonly) CGFloat red;
@property (readonly) CGFloat green;
@property (readonly) CGFloat blue;
@property (readonly) CGFloat alpha;
@property (readonly) CGFloat x;
@property (readonly) CGFloat y;
@property (readonly) CGFloat blurRadius;

#if TARGET_OS_IPHONE
-(id)initWithShadow:(NSShadow *)ds;
-(NSShadow *) shadow;
#else 
-(id)initWithShadow:(NSShadow *)ds;
-(NSShadow *)shadow;
#endif

@end
