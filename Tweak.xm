
#define SETTING_PATH @"/var/mobile/Library/Preferences/kr.iolate.customvolumestep.plist"
#define DEFAULT_VALUE 16
// 1/16 = 0.0625f

float step = 1.0f / (float)DEFAULT_VALUE;

%hook VolumeControl
- (void)_changeVolumeBy:(float)arg1 {
    if (arg1 > 0) {
        %orig(step);
    }else{
        %orig(-step);
    }
}
%end

void _reloadPrefs() {
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:SETTING_PATH] ?: NULL;
    
    int s = [[dic objectForKey:@"Step"] intValue] ?: DEFAULT_VALUE;
    step = 1.0f / (float)s;
}

void reloadPrefs(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    _reloadPrefs();
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &reloadPrefs, CFSTR("customvolumestep/reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    
    _reloadPrefs();
}