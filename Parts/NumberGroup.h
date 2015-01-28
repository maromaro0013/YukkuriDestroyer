//
//  NumberGroup.h
//
//  Created by y-ohta on 2014/10/24.

#import <Foundation/Foundation.h>
#import "GLESdrawWithParts.h"
#import "PtNumber.h"

#define cNUMBERGROUP_DIG_MAX	(8)

@interface NumberGroup: NSObject {
	int m_number;
	int m_dig_count;
	vector2* m_viewrect;

	float m_begin_x;
	float m_begin_y;

	float m_margin_x;
	float m_margin_y;

	PtNumber* m_number_arr[cNUMBERGROUP_DIG_MAX];
}

-(id)init;
-(void)setViewRect:(float)w :(float)h;

-(void)setBegin:(float)x :(float)y;
-(void)setNumber:(int)number;
-(void)setMargin:(float)x :(float)y;

-(void)DrawNumbers:(GLESdrawWithParts*)draw :(TextureData*)texture;

@end
