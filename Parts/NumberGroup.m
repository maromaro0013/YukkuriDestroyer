//
//  NumberGroup.m
//
//  Created by y-ohta on 2014/10/24.

#import "NumberGroup.h"

@implementation NumberGroup

-(id)init {
	self = [super init];

	m_number = 0;
	m_dig_count = 0;
	m_viewrect = [[vector2 alloc] init];

	m_margin_x = 0.0f;
	m_margin_y = 0.0f;
	
	for (int i = 0; i < cNUMBERGROUP_DIG_MAX; i++) {
		m_number_arr[i] = [[PtNumber alloc] init];
	}
	return self;
}

-(void)setViewRect:(float)w :(float)h {
	[m_viewrect set:w :h];
}

-(void)setBegin:(float)x :(float)y {
	m_begin_x = x;
	m_begin_y = y;
}

-(void)setNumber:(int)number {
	m_number = number;
	m_dig_count = 0;

	if (m_number == 0) {
		m_dig_count = 1;
		[m_number_arr[0] updateViewRect:[m_viewrect x] :[m_viewrect y]];
		[m_number_arr[0] setSize:16.0f :32.0f];
		[m_number_arr[0] setNumber:0];
	}
	else {
		int tmp = m_number;
		while (tmp > 0) {
			[m_number_arr[m_dig_count] updateViewRect:[m_viewrect x] :[m_viewrect y]];
			[m_number_arr[m_dig_count] setSize:16.0f :32.0f];
			[m_number_arr[m_dig_count] setNumber:tmp%10];
			m_dig_count++;
			tmp /= 10;
		}
	}
}

-(void)setMargin:(float)x :(float)y {
	m_margin_x = x;
	m_margin_y = y;
}

-(void)DrawNumbers:(GLESdrawWithParts*)draw :(TextureData*)texture {
	float x = m_begin_x;
	float y = m_begin_y;

	for (int i = m_dig_count - 1; i >= 0; i--) {
		[m_number_arr[i] setPos:x :y];
		[draw drawParts:m_number_arr[i] :texture];
		x += m_margin_x;
		y += m_margin_y;
	}
}

@end
