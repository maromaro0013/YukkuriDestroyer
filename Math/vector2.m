//
//  vector2.m
//
//  Created by y-ohta on 2014/10/15.

#import <Foundation/Foundation.h>
#import "vector2.h"

@implementation vector2

-(id)init {
	self = [super init];
	
	m_x = m_y = 0.0f;
	return self;
}


+(id)vector2WithXY:(float)x :(float)y {
	vector2* ret = [self alloc];
	ret = [ret init];
	[ret set:x:y];

	return ret;
}

-(void)set:(float) x :(float)y {
	m_x = x;
	m_y = y;
}

-(void)add:(vector2*)v {
	m_x += [v x];
	m_y += [v y];
}
-(void)addX:(float)x {
	m_x += x;
}
-(void)addY:(float)y {
	m_y += y;
}

-(void)sub:(vector2*)v {
	m_x -= [v x];
	m_y -= [v y];
}

-(void)mul:(vector2*)v {
	m_x *= [v x];
	m_y *= [v y];
}

-(void)smul:(float)f {
	m_x *= f;
	m_y *= f;
}

-(void)div:(vector2*)v {
	m_x /= [v x];
	m_y /= [v y];
}

-(void)sdiv:(float)f {
	m_x /= f;
	m_y /= f;
}

-(float)x {
	return m_x;
}

-(float)y {
	return m_y;
}

@end
