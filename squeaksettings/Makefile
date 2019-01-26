include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SqueakSettings
SqueakSettings_FILES = SQTRootListController.m
SqueakSettings_INSTALL_PATH = /Library/PreferenceBundles
SqueakSettings_FRAMEWORKS = UIKit
SqueakSettings_LDFLAGS += ./Preferences.tbd

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SqueakSettings.plist$(ECHO_END)
