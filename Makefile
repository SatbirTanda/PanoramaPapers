ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PanoramaPapers
PanoramaPapers_FILES = Tweak.xm
PanoramaPapers_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += panoramapapers
include $(THEOS_MAKE_PATH)/aggregate.mk
