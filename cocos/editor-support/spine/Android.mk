


LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := spine_static

LOCAL_MODULE_FILENAME := libspine

LOCAL_ARM_MODE := arm


C_FILES := $(shell find $(LOCAL_PATH)/src/spine -name *.c)
CPP_FILES := $(shell find $(LOCAL_PATH)/src/spine -name *.cpp)

LOCAL_SRC_FILES := $(CPP_FILES:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES += $(C_FILES:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/..

LOCAL_STATIC_LIBRARIES := cocos2dx_internal_static

include $(BUILD_STATIC_LIBRARY)
