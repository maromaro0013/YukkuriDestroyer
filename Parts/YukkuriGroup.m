//
//  YukkuriBuilder.m
//
//  Created by y-ohta on 2014/10/23.

#import <Foundation/Foundation.h>
#import "PtYukkuri.h"
#import "YukkuriGroup.h"

@implementation YukkuriGroup

-(id)init {
	self = [super init];
	m_count = 0;
	m_viewrect = [vector2 alloc];

	m_born_interval = 0;
	
	return self;
}

-(int)getAmount {
	return m_count;
//	return [m_YukkuriArr count];
}

-(BOOL)buildWithType:(int)type :(float)x :(float)y {
	if ([self getAmount] >= cYUKKURI_BUILD_MAX) {
		return FALSE;
	}

	m_YukkuriArr[m_count] = [[PtYukkuri alloc] init];
	PtYukkuri* yukkuri = m_YukkuriArr[m_count];
	[yukkuri updateViewRect:[m_viewrect x] :[m_viewrect y]];
	[yukkuri setYukkuriType:type];
	[yukkuri setTexname:@"yukkuri_4"];
	[yukkuri setPos:x :y];
	[yukkuri setSize:160.0f :128.0f];
	[yukkuri runSwitch];

	[yukkuri setSpeed:-8.0f :0.0f];
	m_count++;

	return TRUE;
}
-(PtYukkuri*)getYukkuri:(int)idx {
	if (m_count <= idx) {
		return nil;
	}

	return m_YukkuriArr[idx];
}
-(void)RemoveYukkuri:(int)idx {
	if (m_count <= idx) {
		return;
	}
//	[m_YukkuriArr[idx] release];

	for (int i = idx; i < m_count - 1; i++) {
		m_YukkuriArr[i] = m_YukkuriArr[i + 1];
	}
	m_count--;
}

-(void)setViewRect:(float)w :(float)h {
	[m_viewrect set:w :h];
}

-(void)touchesBegan:(float)x :(float)y {
	for (int i = 0; i < [self getAmount]; i++) {
		if ([m_YukkuriArr[i] isTouch:x :y]) {
			if ([m_YukkuriArr[i] getYukkuriMode] == eYUKKURIMODE_MOVE) {
				[m_YukkuriArr[i] setYukkuriMode:eYUKKURIMODE_TOUCHED];
				[m_YukkuriArr[i] setYukkuriFace:eYUKKURIFACE_DESTROY];
//				[m_YukkuriArr[i] runSwitch];
				[m_YukkuriArr[i] setTouch:TRUE];
			}
		}
	}
}
-(void)touchesEnded:(float)x :(float)y {
	for (int i = 0; i < [self getAmount]; i++) {
		if ([m_YukkuriArr[i] getTouch] == TRUE) {
			[m_YukkuriArr[i] runSwitch];
			[m_YukkuriArr[i] setTouch:FALSE];
			[self RemoveYukkuri:i];
			i--;
		}
	}
}

-(void)Run {
	// born yukkuri
	if (m_born_interval++ >= cYUKKURI_BORN_INTERVAL) {
		m_born_interval = 0;
		float y = random() % (cYUKKURI_BORN_Y_MAX - cYUKKURI_BORN_Y_MIN);
		y += cYUKKURI_BORN_Y_MIN;
		[self buildWithType :eYUKKURITYPE_01 :700.0f :y];
	}

	// run yukkuri(s)
	for (int i = 0; i < m_count; i++) {
		[m_YukkuriArr[i] Run];
		// remove yukkuri
		if ([m_YukkuriArr[i] chkDispArea] == FALSE) {
			[self RemoveYukkuri :i];
			i--;
		}
	}
}

-(void)DrawYukkuri:(GLESdrawWithParts*)draw :(TextureData*)texture {
	for (int i = 0; i >= m_count; i++) {
		[draw drawParts:m_YukkuriArr[i] :texture];
	}
}

@end