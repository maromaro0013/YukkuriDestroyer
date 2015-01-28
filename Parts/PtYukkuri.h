//
//  PtYukkuri.h
//
//  Created by y-ohta on 2014/10/16.

#import "PartsBase.h"

enum {
	eYUKKURITYPE_01 = 0,
	eYUKKURITYPE_02,
};

enum {
	eYUKKURIFACE_NORMAL = 0,
	eYUKKURIFACE_DESTROY,
};

enum {
	eYUKKURIMODE_MOVE = 0,
	eYUKKURIMODE_TOUCHED,
	eYUKKURIMODE_FOT,
};

#define cYUKKURI_SIGNAL_INTERVAL			(2)

@interface PtYukkuri: PartsBase {
@private
	BOOL m_isstart;

	int m_yukkuritype;
	int m_yukkuriface;
	int m_yukkutimode;

	vector2* m_speed;
	BOOL m_touch;

	int m_signal_interval;
}

-(id)init;
-(void)Run;

-(void)setYukkuriType:(int)type;
-(void)setYukkuriFace:(int)face;
-(void)setUvFromYukkuri;

-(void)setYukkuriMode:(int)mode;
-(int)getYukkuriMode;

-(void)setSpeed:(float)x :(float)y;

-(void)runSwitch;

-(BOOL)chkDispArea;

-(void)setTouch:(BOOL)touch;
-(BOOL)getTouch;

@end

