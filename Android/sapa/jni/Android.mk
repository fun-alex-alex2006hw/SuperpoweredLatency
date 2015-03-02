LOCAL_PATH := $(call my-dir)

# include Samsung Professional Audio SDK for ARM
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    include $(CLEAR_VARS)
        LOCAL_MODULE := libsapaclient
        LOCAL_SRC_FILES := apa/lib/libsapaclient.a
    include $(PREBUILT_STATIC_LIBRARY)
    include $(CLEAR_VARS)
        LOCAL_MODULE := libjack
        LOCAL_SRC_FILES := apa/lib/libjack.so
    include $(PREBUILT_SHARED_LIBRARY)
endif

# build the JNI for Samsung Professional Audio SDK (ARM only)
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    include $(CLEAR_VARS)
        LOCAL_MODULE := wave

        LOCAL_C_INCLUDES := \
            $(LOCAL_PATH)/apa/include \
            $(LOCAL_PATH)/../../app/src/main/jni

        LOCAL_SRC_FILES := sapa.cpp sapaClient.cpp \
            $(LOCAL_PATH)/../../app/src/main/jni/latencyMeasurer.cpp

        LOCAL_SHARED_LIBRARIES := libjack
        LOCAL_STATIC_LIBRARIES := libsapaclient
        LOCAL_CFLAGS = -mfloat-abi=softfp -mfpu=neon -O3

        LOCAL_LDLIBS := -llog -landroid -lOpenSLES
    include $(BUILD_SHARED_LIBRARY)
endif
