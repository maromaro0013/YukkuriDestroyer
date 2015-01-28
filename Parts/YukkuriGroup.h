//
//  YukkuriBuilder.h
//
//  Created by y-ohta on 2014/10/23.

#import <Foundation/Foundation.h>
#import "GLESdrawWithParts.h"
#import "PtYukkuri.h"

#define cYUKKURI_BUILD_MAX					(256)
#define cYUKKURI_BORN_INTERVAL				(14)

#define cYUKKURI_BORN_Y_MIN					(60)
#define cYUKKURI_BORN_Y_MAX					(800)

@interface YukkuriGroup: NSObject {
@private
	PtYukkuri* m_YukkuriArr[cYUKKURI_BUILD_MAX];
	int m_count;
	vector2* m_viewrect;

	int m_born_interval;
}

-(id)init;

-(int)getAmount;

-(BOOL)buildWithType:(int)type :(float)x :(float)y;
-(PtYukkuri*)getYukkuri:(int)idx;
-(void)RemoveYukkuri:(int)idx;

-(void)setViewRect:(float)w :(float)h;

-(void)touchesBegan:(float)x :(float)y;
-(void)touchesEnded:(float)x :(float)y;

-(void)Run;

-(void)DrawYukkuri:(GLESdrawWithParts*)draw :(TextureData*)texture;

@end

