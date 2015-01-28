//
//  PtYkkuri.m
//
//  Created by y-ohta on 2014/10/21.

#import <Foundation/Foundation.h>
#import "PtYukkuri.h"

@implementation PtYukkuri
-(id)init {
	self = [super init];
	m_isstart = FALSE;

	m_yukkuritype = eYUKKURITYPE_01;
	m_yukkuriface = eYUKKURIFACE_NORMAL;
	m_yukkutimode = eYUKKURIMODE_MOVE;

	m_speed = [vector2 vector2WithXY:0.0f :0.0f];
	m_touch = FALSE;

	m_signal_interval = 0;

	return self;
}
-(void)Run {
	if (!m_isstart) {
		return;
	}

	switch (m_yukkutimode) {
		case eYUKKURIMODE_MOVE:
			[self Move:[m_speed x] :[m_speed y]];
			break;

		case eYUKKURIMODE_TOUCHED:
			if (m_signal_interval++ >= cYUKKURI_SIGNAL_INTERVAL) {
				m_signal_interval = 0;
				if ([self getA] >= 1.0f) {
					[self setA:0.2f];
				}
				else {
					[self setA:1.0f];
				}
			}
			break;

		case eYUKKURIMODE_FOT:
			break;

		default:
			break;
	}
}

-(void)setYukkuriType:(int)type {
	m_yukkuritype = type;
	[self setUvFromYukkuri];
}
-(void)setYukkuriFace:(int)face {
	m_yukkuriface = face;
	[self setUvFromYukkuri];
}
-(void)setUvFromYukkuri {
	float u = 0.0f;
	float v = 0.0f;

	switch (m_yukkuritype) {
		case eYUKKURITYPE_01:
			u = 0.0f;
			break;

		case eYUKKURITYPE_02:
			u = 160.0f;
			break;
	}

	switch (m_yukkuriface) {
		case eYUKKURIFACE_NORMAL:
			v = 0.0f;
			break;

		case eYUKKURIFACE_DESTROY:
			v = 128.0f;
			break;
	}

	[self setUv:u :v];
	[self setUvSize:160.0f :128.0f];
	[self setTexSize:512.0f :512.0f];
}

-(void)setYukkuriMode:(int)mode {
	m_yukkutimode = mode;
}
-(int)getYukkuriMode {
	return m_yukkutimode;
}

-(void)setSpeed:(float)x :(float)y {
	[m_speed set:x :y];
}

-(void)runSwitch {
	m_isstart = !m_isstart;
}

-(BOOL)chkDispArea {
	float x = [m_pos x];
	float y = [m_pos y];
	float sizex = [m_size x];
	float sizey = [m_size y];
	float paddx = 200.0f*m_mag_w;
	float paddy = 20.0f*m_mag_h;
	vector2* view = [self getViewRect];

	if (x > ([view x] + paddx) || x < -(sizex + paddx)) {
		return FALSE;
	}
	if (y > ([view y] + paddy) || y < -(sizey + paddy)) {
		return FALSE;
	}

	return TRUE;
};

-(void)setTouch:(BOOL)touch {
	m_touch = touch;
}

-(BOOL)getTouch {
	return m_touch;
}

@end
