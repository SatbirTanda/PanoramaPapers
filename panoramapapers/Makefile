include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PanoramaPapers
PanoramaPapers_FILES = SSTRootListController.m
PanoramaPapers_INSTALL_PATH = /Library/PreferenceBundles
PanoramaPapers_FRAMEWORKS = UIKit
PanoramaPapers_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PanoramaPapers.plist$(ECHO_END)
