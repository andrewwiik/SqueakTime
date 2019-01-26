ifeq ($(SIMULATOR),1)
	export TARGET = simulator:clang:latest
	export ARCHS = x86_64
else
	export TARGET = iphone:latest:10.0
	export ARCHS = armv7 arm64
endif

include $(THEOS)/makefiles/common.mk
export ADDITIONAL_CFLAGS = -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers -I$(THEOS_PROJECT_DIR)/

TWEAK_NAME = SqueakTime
SqueakTime_FILES = $(wildcard *.m) Tweak.xm
SqueakTime_LDFLAGS += ./NanoTimeKitCompanion.tbd ./MediaRemote.tbd

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += squeaksettings
include $(THEOS_MAKE_PATH)/aggregate.mk
