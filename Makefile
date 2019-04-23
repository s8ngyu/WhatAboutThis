ARCHS = armv7s armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WhatAboutThis
WhatAboutThis_FILES = Tweak.xm
WhatAboutThis_LDFLAGS = -lmobilegestalt

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
