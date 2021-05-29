@import Foundation;
#import <CydiaSubstrate/CydiaSubstrate.h>

// default to hiding media controls at unlock

MSHookInterface(SBLockScreenViewController,FakeSBLockScreenViewController,NSObject)

@implementation FakeSBLockScreenViewController

-(void)_updateMediaControlsForScreenMode
{
	[super _updateMediaControlsForScreenMode];
	
	if([self isShowingMediaControls])
	{
		[self _setMediaControlsVisible:false];
	}
}

@end

// stop MediaPlayerUI from hiding the volume HUD on lockscreen

MSHookInterface(SpringBoard,FakeSpringBoard,NSObject)

@implementation FakeSpringBoard

-(void)setSystemVolumeHUDEnabled:(BOOL)value forAudioCategory:(NSString*)key
{
	if([self isLocked])
	{
		return;
	}
	
	[super setSystemVolumeHUDEnabled:value forAudioCategory:key];
}

@end