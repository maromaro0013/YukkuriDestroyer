/*
 File: PVRTexture.m
 */

#import "PVRTexture.h"

#define PVR_TEXTURE_FLAG_TYPE_MASK	0xff

static char gPVRTexIdentifier[4] = "PVR!";

enum
{
	kPVRTextureFlagTypePVRTC_2 = 24,
	kPVRTextureFlagTypePVRTC_4
};

typedef struct _PVRTexHeader
{
	uint32_t headerLength;
	uint32_t height;
	uint32_t width;
	uint32_t numMipmaps;
	uint32_t flags;
	uint32_t dataLength;
	uint32_t bpp;
	uint32_t bitmaskRed;
	uint32_t bitmaskGreen;
	uint32_t bitmaskBlue;
	uint32_t bitmaskAlpha;
	uint32_t pvrTag;
	uint32_t numSurfs;
} PVRTexHeader;


@implementation PVRTexture

- (BOOL)unpackPVRData:(NSData *)data
{
	BOOL success = FALSE;
	PVRTexHeader *header = NULL;
	uint32_t flags, pvrTag;
	uint32_t dataLength = 0, dataOffset = 0, dataSize = 0;
	uint32_t blockSize = 0, widthBlocks = 0, heightBlocks = 0;
	uint32_t width = 0, height = 0, bpp = 4;
	uint8_t *bytes = NULL;
	uint32_t formatFlags;
	
	header = (PVRTexHeader *)[data bytes];
	
	pvrTag = CFSwapInt32LittleToHost(header->pvrTag);
	
	if (gPVRTexIdentifier[0] != ((pvrTag >>  0) & 0xff) ||
		gPVRTexIdentifier[1] != ((pvrTag >>  8) & 0xff) ||
		gPVRTexIdentifier[2] != ((pvrTag >> 16) & 0xff) ||
		gPVRTexIdentifier[3] != ((pvrTag >> 24) & 0xff)) {
		return FALSE;
	}
	
	flags = CFSwapInt32LittleToHost(header->flags);
	formatFlags = flags & PVR_TEXTURE_FLAG_TYPE_MASK;
	
	if (formatFlags == kPVRTextureFlagTypePVRTC_4 || formatFlags == kPVRTextureFlagTypePVRTC_2) {
		[m_imageData removeAllObjects];
		
		if (formatFlags == kPVRTextureFlagTypePVRTC_4) {
			m_internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
		}
		else if (formatFlags == kPVRTextureFlagTypePVRTC_2) {
			m_internalFormat = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
		}
		
		m_width = width = CFSwapInt32LittleToHost(header->width);
		m_height = height = CFSwapInt32LittleToHost(header->height);
		
		if (CFSwapInt32LittleToHost(header->bitmaskAlpha)) {
			m_hasAlpha = TRUE;
		}
		else {
			m_hasAlpha = FALSE;
		}
		
		dataLength = CFSwapInt32LittleToHost(header->dataLength);
		
		bytes = ((uint8_t *)[data bytes]) + sizeof(PVRTexHeader);
		
		// Calculate the data size for each texture level and respect the minimum number of blocks
		while (dataOffset < dataLength) {
			if (formatFlags == kPVRTextureFlagTypePVRTC_4) {
				blockSize = 4 * 4; // Pixel by pixel block size for 4bpp
				widthBlocks = width / 4;
				heightBlocks = height / 4;
				bpp = 4;
			}
			else {
				blockSize = 8 * 4; // Pixel by pixel block size for 2bpp
				widthBlocks = width / 8;
				heightBlocks = height / 4;
				bpp = 2;
			}
			
			// Clamp to minimum number of blocks
			if (widthBlocks < 2) {
				widthBlocks = 2;
			}
			if (heightBlocks < 2) {
				heightBlocks = 2;
			}
			
			dataSize = widthBlocks * heightBlocks * ((blockSize  * bpp) / 8);
			
			[m_imageData addObject:[NSData dataWithBytes:bytes+dataOffset length:dataSize]];
			
			dataOffset += dataSize;
			
			width = MAX(width >> 1, 1);
			height = MAX(height >> 1, 1);
		}
		success = TRUE;
	}
	
	return success;
}

// [notice] no mipmaps
- (BOOL)createGLTexture
{
	NSData *data;
	GLenum err;
	
	if ([m_imageData count] <= 0) {
		return FALSE;
	}
	
	data = [m_imageData objectAtIndex:0];
	int length = (int)[data length];
	glCompressedTexImage2D(GL_TEXTURE_2D, 0, m_internalFormat, m_width, m_height, 0, length, [data bytes]);
	
	err = glGetError();
	if (err != GL_NO_ERROR) {
		NSLog(@"Error uploading compressed texture level: %d. glError: 0x%04X", 0, err);
		return FALSE;
	}
	
	[m_imageData removeAllObjects];
	
	return TRUE;
}


- (id)initWithContentsOfFile:(NSString *)path
{
	if (self = [super init]) {
		NSData *data = [NSData dataWithContentsOfFile:path];
		
		m_imageData = [[NSMutableArray alloc] initWithCapacity:0];
		
		m_width = m_height = 0;
		m_internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
		m_hasAlpha = FALSE;
		
		if (!data || ![self unpackPVRData:data] || ![self createGLTexture]) {
//			[self release];
			self = nil;
		}
	}
	
	return self;
}


- (id)initWithContentsOfURL:(NSURL *)url
{
	if (![url isFileURL]) {
//		[self release];
		return nil;
	}
	
	return [self initWithContentsOfFile:[url path]];
}


+ (id)pvrTextureWithContentsOfFile:(NSString *)path {
	return [[self alloc] initWithContentsOfFile:path];
}


+ (id)pvrTextureWithContentsOfURL:(NSURL *)url {
	if (![url isFileURL])
		return nil;
	
	return [PVRTexture pvrTextureWithContentsOfFile:[url path]];
}

@end
