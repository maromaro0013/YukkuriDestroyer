//
//  PtNumber.m
//
//  Created by y-ohta on 2014/10/24.

#import "PtNumber.h"

@implementation PtNumber

-(id)init {
	self = [super init];

	return self;
}

-(void)setNumber:(int)number {
	m_number = number % 10;

	float u = number*16.0f;
	float v = 0.0f;

	[self setUv:u :v];
	[self setUvSize:16.0f :32.0f];
	[self setTexSize:256.0f :256.0f];
	[self setTexname:@"number_4"];
}

@end
