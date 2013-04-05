//
//  MNColor.m
//  MNCoder
//
//  Created by Jeremy Foo on 1/7/12.
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

#import "MNCShadow.h"

@implementation MNCShadow
@synthesize red = _red, green = _green, blue = _blue, alpha = _alpha;
@synthesize blurRadius = _blurRadius, x = _x, y = _y;

#pragma mark - NSCoding Protocol

-(id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		_red = [aDecoder decodeFloatForKey:@"red"];
		_green = [aDecoder decodeFloatForKey:@"green"];
		_blue = [aDecoder decodeFloatForKey:@"blue"];
		_alpha = [aDecoder decodeFloatForKey:@"alpha"];
		_x = [aDecoder decodeFloatForKey:@"x"];
		_y = [aDecoder decodeFloatForKey:@"y"];
		_blurRadius = [aDecoder decodeFloatForKey:@"blurRadius"];
	}
	
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeFloat:self.red forKey:@"red"];
	[aCoder encodeFloat:self.green forKey:@"green"];
	[aCoder encodeFloat:self.blue forKey:@"blue"];
	[aCoder encodeFloat:self.alpha forKey:@"alpha"];
    [aCoder encodeFloat:self.x forKey:@"x"];
	[aCoder encodeFloat:self.y forKey:@"y"];
	[aCoder encodeFloat:self.blurRadius forKey:@"blurRadius"];

}

#pragma mark - Platform specific representation

#if TARGET_OS_IPHONE

-(id)initWithShadow:(NSShadow *)shadow {
	if ((self = [super init])) {
        UIColor *color = [shadow shadowColor];

        _blurRadius = [shadow shadowBlurRadius];
        CGSize s = [shadow shadowOffset];
        _x = s.width;
        _y = s.height;
        
		// Need to deal with CTForegroundColor = " (kCGColorSpaceDeviceGray)";
		if ([color getRed:&_red green:&_green blue:&_blue alpha:&_alpha] == NO) {
			CGFloat white;
			if ([color getWhite:&white alpha:&_alpha]) {
				_blue = _green = _red = white;
				// NSLog(@"Grayscale converted to Color");
			}	// end if getWhite
		};
	}	// end if self
	return self;
}

-(NSShadow *)shadow {
    // ios does not allow you create shadow !
    // NSShadow *s = [[NSShadow alloc] init];
	return nil;
}

#else

-(id)initWithShadow:(NSShadow *)shadow {
	if ((self = [super init])) {
        NSColor *color = [shadow shadowColor];
		NSColor *calibratedColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
        _red = [calibratedColor redComponent];
        _green = [calibratedColor greenComponent];
        _blue = [calibratedColor blueComponent];
        _alpha = [calibratedColor alphaComponent];
        _blurRadius = [shadow shadowBlurRadius];
        NSSize s = [shadow shadowOffset];
        _x = s.width;
        _y = s.height;

	}
	return self;
}

-(NSColor *)shadow {
	NSColor *shadowColor = [NSColor colorWithCalibratedRed:self.red green:self.green blue:self.blue alpha:self.alpha];
   
    NSShadow* theShadow = [[NSShadow alloc] init];
    /* offset the shadow by the indicated direction and distance */
    [theShadow setShadowOffset:NSMakeSize(self.x, self.y)];
    /* set other shadow parameters */
    [theShadow setShadowBlurRadius:self.blurRadius];
    [theShadow setShadowColor:shadowColor];
    return theShadow;
}
#endif

-(NSString *)description {
    return [NSString stringWithFormat:@"MNShadow: Blur %f, Offset: %fx%f Color: red(%f) green(%f) blue(%f) alpha(%f)", self.blurRadius, self.x, self.y, self.red, self.green, self.blue, self.alpha];
}

#pragma mark - MNCIntermediateObject Protocol

-(id)initWithSubsituteObject:(void *)object {
	return [self initWithShadow:object];
}

+(BOOL)isSubstituteForObject:(void *)object {
#if TARGET_OS_IPHONE 
	return [(id)object isKindOfClass:[NSShadow class]];
#else
	return [(id)object isKindOfClass:[NSShadow class]];
#endif
}

-(id)platformRepresentation {
	return [self shadow];
}

@end
