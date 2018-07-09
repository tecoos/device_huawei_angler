# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for an aosp Android
# build for angler hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, aosp and angler, hence its name.
#

$(call inherit-product, device/huawei/angler/aosp_angler.mk)

PRODUCT_COPY_FILES += \
    device/huawei/angler/manifest_angler_car.xml:vendor/manifest.xml

# Auto modules
PRODUCT_PACKAGES += \
    android.hardware.automotive.vehicle@2.0-service \
    vehicle.default

# Car init.rc
PRODUCT_COPY_FILES += \
   packages/services/Car/car_product/init/init.bootstat.rc:root/init.bootstat.rc \
   packages/services/Car/car_product/init/init.car.rc:root/init.car.rc

# Enable landscape
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml

# Overwrite handheld_core_hardware.xml with a dummy config.
PRODUCT_COPY_FILES += \
    device/generic/car/common/android.hardware.dummy.xml:system/etc/permissions/handheld_core_hardware.xml \
    device/generic/car/common/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:system/etc/permissions/android.hardware.type.automotive.xml

# TODO Remove this when AAE is fully treble ready
PRODUCT_FULL_TREBLE_OVERRIDE := false

# Add car related sepolicy.
BOARD_SEPOLICY_DIRS += \
    device/generic/car/common/sepolicy \
    packages/services/Car/car_product/sepolicy

$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_NAME := aosp_angler_car
PRODUCT_DEVICE := angler
PRODUCT_BRAND := Android
PRODUCT_MODEL := Android Auto Embedded on angler
PRODUCT_MANUFACTURER := Google
PRODUCT_RESTRICT_VENDOR_FILES := true
