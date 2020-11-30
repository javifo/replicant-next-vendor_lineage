#----------------------------------------------------------------------
# Generate device tree image (dt.img)
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_CUSTOM_BOOTIMG_MK)),)
ifeq ($(strip $(BOARD_KERNEL_SEPARATED_DT)),true)
INSTALLED_DTIMAGE_TARGET := $(PRODUCT_OUT)/dt.img

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTIMAGE_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_DTIMAGE_TARGET)

.PHONY: dtimage
dtimage: $(INSTALLED_DTIMAGE_TARGET)

endif
endif
