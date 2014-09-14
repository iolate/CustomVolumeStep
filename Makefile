FW_DEVICE_IP=10.48.129.164
include theos/makefiles/common.mk

TWEAK_NAME = CustomVolumeStep
CustomVolumeStep_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp CustomVolumeStepSettings.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CustomVolumeStep.plist$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"
