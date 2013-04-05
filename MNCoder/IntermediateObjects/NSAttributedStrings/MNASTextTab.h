//
//  MNASTextTab.h
//  MNCoder
//
//  Created by Jeremy Foo on 1/16/12.
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

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <CoreText/CoreText.h>
#else
#import <Cocoa/Cocoa.h>
#endif

@interface MNASTextTab : NSObject <NSCoding> {
@private
    NSUInteger _alignment;
    CGFloat _location;
    NSDictionary *_options;
}

@property (readonly) NSUInteger alignment;
@property (readonly) CGFloat location;
@property (readonly) NSDictionary *options;

#if TARGET_OS_IPHONE
+(id)textTabWithTabStop:(CTTextTabRef)tab;
-(id)initWithTabStop:(CTTextTabRef)tab;
-(CTTextTabRef)platformRepresentation;
#else
+(id)textTabWithTabStop:(NSTextTab *)tab;
-(id)initWithTabStop:(NSTextTab *)tab;
-(NSTextTab *)platformRepresentation;
#endif

@end
