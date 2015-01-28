/*
 File: TextureData.m
 */

#import "TextureData.h"

@implementation TextureData

-(id)init {
	self = [super init];
	m_nameidx = [[NSMutableDictionary alloc] init];
	m_bufidx = [[NSMutableDictionary alloc] init];

	return self;
}

-(BOOL)Build:(NSString *)name :(NSString *)type {

	// PVRTC format
	if ([type compare:@"pvr"] == NSOrderedSame) {
		GLuint texid = 0;
		glGenTextures(1, &texid);
		NSNumber* texnumber = [NSNumber numberWithInteger:texid];
		glBindTexture(GL_TEXTURE_2D, texid);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

		NSString* path =[[NSBundle mainBundle] pathForResource:name ofType:@"pvr"];
		PVRTexture *tex = [PVRTexture pvrTextureWithContentsOfFile:path];

		if (tex == nil) {
			return FALSE;
		}

//		[tex retain];
		NSString* namekey = [name stringByAppendingString:@"_name"];
		[m_nameidx setObject:texnumber forKey:namekey];
		[m_bufidx setObject:tex forKey:[name stringByAppendingString:@"_buf"]];

		glBindTexture(GL_TEXTURE_2D, 0);
		return TRUE;
	}
	return FALSE;
}

-(BOOL)Bind:(NSString *)name {
	NSString* namekey = [name stringByAppendingString:@"_name"];
	NSNumber* texnumber = [m_nameidx objectForKey:namekey];

	if (texnumber == nil) {
		return FALSE;
	}

	int val = [texnumber intValue];
	glBindTexture(GL_TEXTURE_2D, val);

	return TRUE;
}
-(void)UnBind {
	glBindTexture(GL_TEXTURE_2D, 0);
}

@end

