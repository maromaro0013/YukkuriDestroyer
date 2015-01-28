//
//  PartsBase.m
//
//  Created by y-ohta on 2014/10/15.

#import <Foundation/Foundation.h>
#import "PartsBase.h"
#import "display_default.h"

@implementation PartsBase

-(id)init {
	self = [super init];
	
	m_pos = [vector2 alloc];
	m_size = [vector2 alloc];
	m_uv = [vector2 alloc];
	m_uvsize = [vector2 alloc];
	m_texsize = [vector2 alloc];
	m_viewrect = [vector2 alloc];

	for (int i = 0; i < 4; i++) {
		m_rgba[i] = 1.0f;
	}
	m_fade_speed = 0.1f;

	m_mag_w = 1.0f;
	m_mag_h = 1.0f;
	
	m_objname = @"";
	m_texname = @"";

	return self;
}
-(id)initWithViewRect:(float)w :(float) h {
	PartsBase* ret = [self init];
	[ret updateViewRect:w :h];

	return ret;
}

-(void)setPos:(float)x :(float)y {
	[m_pos set:x*m_mag_w:y*m_mag_h];
}
-(vector2*)getPos {
	return m_pos;
}
-(void)Move:(float)x :(float)y {
	[m_pos addX:x*m_mag_w];
	[m_pos addY:y*m_mag_h];
}

-(void)setSize:(float)w :(float)h {
	[m_size set:w*m_mag_w :h*m_mag_h];
}
-(void)addSize:(float)w :(float)h {
	[m_size addX:w*m_mag_w];
	[m_size addY:h*m_mag_h];
}
-(void)mulSize:(float)mag_w :(float)mag_h {
	[m_size set:[m_size x]*mag_w :[m_size y]*mag_h];
}
-(vector2*)getSize {
	return m_size;
}

-(void)setUv:(float)u :(float)v {
	[m_uv set:u :v];
}
-(vector2*)getUv {
	return m_uv;
}

-(void)setUvSize:(float)w :(float)h {
	[m_uvsize set:w :h];
}
-(vector2*)getUvSize {
	return m_uvsize;
}

-(void)setTexSize:(float)w :(float)h {
	[m_texsize set:w :h];
}
-(vector2*)getTexSize {
	return m_texsize;
}

-(BOOL)Fadein {
	if ((m_rgba[3] += m_fade_speed) >= 1.0f) {
		m_rgba[3] = 1.0f;
		return TRUE;
	}
	return FALSE;
}
-(BOOL)FadeOut {
	if ((m_rgba[3] -= m_fade_speed) < 0.0f) {
		m_rgba[3] = 0.0f;
		return TRUE;
	}
	return FALSE;
}

-(float)getR {
	return m_rgba[0];
}
-(float)getG {
	return m_rgba[1];
}
-(float)getB {
	return m_rgba[2];
}
-(float)getA {
	return m_rgba[3];
}
-(void)setA:(float)a {
	m_rgba[3] = a;
}

-(void)setTexname:(NSString*)str {
	m_texname = [NSString stringWithString:str];
}
-(NSString*)getTexname{
	return m_texname;
}

-(void)updateViewRect:(float)w :(float)h {
	[m_viewrect set:w*2.0f :h*2.0f];

	m_mag_w = w / cDISPLAY_DEFAULT_WIDTH;
	m_mag_h = h / cDISPLAY_DEFAULT_HEIGHT;
}
-(vector2*)getViewRect {
	return m_viewrect;
}

-(BOOL)isTouch:(float)x :(float)y {
	float touch_x = x*2;
	float touch_y = y*2;
	float max_x = [m_pos x] + [m_size x];
	float max_y = [m_pos y] + [m_size y];

	if (([m_pos x] <= touch_x) && (touch_x <= max_x)) {
		if (([m_pos y] <= touch_y) && (touch_y <= max_y)) {
			return TRUE;
		}
	}
	return FALSE;
}

-(void)Run {
}

@end
