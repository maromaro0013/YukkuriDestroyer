//
//  GLESdraw.m
//  Created by y-ohta on 2014/10/15.

#import <Foundation/Foundation.h>

#import "matrix2.h"
#import "GLESdrawWithParts.h"

@implementation GLESdrawWithParts

+(id)GLESdrawWithHelper:(GLEShelper*)helper {
	return [[self alloc] initWithHelper:helper];
}
-(id)initWithHelper:(GLEShelper*)helper {
	return [super initWithHelper:helper];
}

-(void)drawParts:(PartsBase*)parts :(TextureData*)texture {
	vector2* pos = [parts getPos];
	vector2* size = [parts getSize];

	if ([parts getTexname] != nil && [[parts getTexname] length] > 0) {
		[self setColors :[parts getR] :[parts getG] :[parts getB] :[parts getA]];
		[texture Bind:[parts getTexname]];
		[super drawRect:pos :size :[parts getUv] :[parts getUvSize] :[parts getTexSize]];
	}
	else {
		[self setColors :[parts getR] :[parts getG] :[parts getB] :[parts getA]];
		[texture UnBind];
		[super drawBlock:pos :size];
	}
}

@end

