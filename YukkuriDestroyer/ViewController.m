//
//  ViewController.m
//  YukkuriDestroyer
//
//  Created by y-ohta on 2014/10/27.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
	if (m_yukkuribuilder != nil) {
		[m_yukkuribuilder touchesBegan:location.x :location.y];
	}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
	if (m_yukkuribuilder != nil) {
		[m_yukkuribuilder touchesEnded:location.x :location.y];
	}
}

// ------------------------------------------------------------- //

- (void)viewDidLoad {
	[super viewDidLoad];
	self.preferredFramesPerSecond = 60;
	
	// opengl helper
	m_gleshelper = [GLEShelper helperWithView:(GLKView *)self.view];
	[m_gleshelper initView];
	// drawer
	m_drawobj = [GLESdrawWithParts GLESdrawWithHelper:m_gleshelper];
	
	CGRect rect = self.view.bounds;
//	NSLog(@"%f:%f", rect.size.width, rect.size.height);
	
	// loading texture
	m_textures = [[TextureData alloc] init];
	[m_textures Build:@"yukkuri_4" :@"pvr"];
	[m_textures Build:@"number_4" :@"pvr"];
	

	// yukkuri
	m_yukkuribuilder = [[YukkuriGroup alloc] init];
	[m_yukkuribuilder setViewRect:rect.size.width :rect.size.height];
	// number
	m_numbers = [[NumberGroup alloc] init];
	[m_numbers setViewRect:rect.size.width :rect.size.height];
	[m_numbers setNumber:100];
	[m_numbers setMargin:16.0f :0.0f];
	[m_numbers setBegin:50.0f :1100.0f];

	// game manager
	m_gamemanager = [[GameManager alloc] init];
	[m_gamemanager setTimeLimit:3600];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
	[m_gleshelper setDispSize:rect.size.width :rect.size.height];
	[m_gleshelper Begin];
	
	// test lines
	[m_drawobj drawLine:[m_gleshelper getDispW]/2 :0.0f :[m_gleshelper getDispW]/2:[m_gleshelper getDispH]];
	[m_drawobj drawLine:0.0f :[m_gleshelper getDispH]/2 :[m_gleshelper getDispW]:[m_gleshelper getDispH]/2];
	
	
	for (int i = 0; i < [m_yukkuribuilder getAmount]; i++) {
		PtYukkuri* yukkuri = [m_yukkuribuilder getYukkuri:i];
		[m_drawobj drawParts:yukkuri :m_textures];
	}
	[m_yukkuribuilder Run];

	[m_numbers setNumber:[m_gamemanager getTime]/60];
	[m_numbers DrawNumbers:m_drawobj :m_textures];

	[m_gamemanager countTime];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
