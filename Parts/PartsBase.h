//
//  PartsBase.h
//
//  Created by y-ohta on 2014/10/16.

#import "matrix2.h"

@interface PartsBase : NSObject {
@protected
	vector2* m_pos;
	vector2* m_size;
	vector2* m_uv;
	vector2* m_uvsize;
	vector2* m_texsize;
	vector2* m_viewrect;

	float m_rgba[4];
	float m_fade_speed;

	NSString* m_objname;
	NSString* m_texname;

	float m_mag_w;
	float m_mag_h;
}

-(id)init;
-(id)initWithViewRect:(float)w :(float) h;

-(void)setPos:(float)x :(float)y;
-(vector2*)getPos;
-(void)Move:(float)x :(float)y;

-(void)setSize:(float)w :(float)h;
-(void)addSize:(float)w :(float)h;
-(void)mulSize:(float)mag_w :(float)mag_h;
-(vector2*)getSize;

-(void)setUv:(float)u :(float)v;
-(vector2*)getUv;

-(void)setUvSize:(float)w :(float)h;
-(vector2*)getUvSize;

-(void)setTexSize:(float)w :(float)h;
-(vector2*)getTexSize;

-(BOOL)Fadein;
-(BOOL)FadeOut;
-(float)getR;
-(float)getG;
-(float)getB;
-(float)getA;
-(void)setA:(float)a;

-(void)setTexname:(NSString*)str;
-(NSString*)getTexname;

-(void)updateViewRect:(float)w :(float)h;
-(vector2*)getViewRect;

-(BOOL)isTouch:(float)x :(float)y;

-(void)Run;

@end

