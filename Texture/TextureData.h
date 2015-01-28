/*
 File: TextureData.h
 */

#import <UIKit/UIKit.h>
#import "PVRTexture.h"

@interface TextureData : NSObject {
	NSMutableDictionary* m_nameidx;
	NSMutableDictionary* m_bufidx;
}

-(id)init;
-(BOOL)Build:(NSString *)name :(NSString *)type;
-(BOOL)Bind:(NSString *)name;
-(void)UnBind;

@end