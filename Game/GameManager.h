//
//  Gamemanager.h
//
//  Created by y-ohta on 2014/10/24.

#import <Foundation/Foundation.h>

@interface GameManager: NSObject {
	int m_score;
	int m_time;
	int m_time_limit;
}

-(id)init;

-(void)setScore:(int)score;
-(int)getScore;

-(void)setTimeLimit:(int)time;
-(void)setTime:(int)time;
-(int)getTime;
-(BOOL)countTime;

@end
