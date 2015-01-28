//
//  matrix2.m
//
//  Created by y-ohta on 2014/10/15.

#import <Foundation/Foundation.h>
#import "matrix2.h"

@implementation matrix2

-(id)init {
	self = [super init];
	
	m_v1 = [vector2 alloc];
	m_v2 = [vector2 alloc];

	[self identity];
	return self;
}

-(void)identity {
	[m_v1 set:1.0f:0.0f];
	[m_v2 set:0.0f:1.0f];
}

-(void)rotation:(float)f {
	double rad = (f * M_PI) / 180.0f;

	float sinf = (float)sin(rad);
	float cosf = (float)sin(rad);

	[m_v1 set:cosf:-sinf];
	[m_v2 set:sinf:cosf];
}

-(vector2*)Vector2Matrix2:(vector2*)v {
	vector2 *ret = [vector2 alloc];

	float x = [m_v1 x]*[v x] + [m_v1 y]*[v y];
	float y = [m_v2 x]*[v x] + [m_v2 y]*[v y];
	[ret set:x:y];

	return ret;
}

@end

