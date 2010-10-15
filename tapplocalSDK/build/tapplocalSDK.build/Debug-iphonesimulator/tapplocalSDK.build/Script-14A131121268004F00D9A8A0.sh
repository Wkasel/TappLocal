#!/bin/sh
SDK_VERSION=$(echo ${SDK_NAME} | grep -o '.\{3\}$')

if [ ${PLATFORM_NAME} = "iphonesimulator" ]
then
OTHER_SDK_TO_BUILD=iphoneos${SDK_VERSION}
else
OTHER_SDK_TO_BUILD=iphonesimulator${SDK_VERSION}
fi

echo "XCode has selected SDK: ${PLATFORM_NAME} with version: ${SDK_VERSION} (although back-targetting: ${IPHONEOS_DEPLOYMENT_TARGET})"
echo "...therefore, OTHER_SDK_TO_BUILD = ${OTHER_SDK_TO_BUILD}"

if [ ${ALREADYINVOKED} ]
then
echo "RECURSION: I am NOT the root invocation, so I'm NOT going to recurse"
else

export ALREADYINVOKED="true"

echo "RECURSION: I am the root ... recursing all missing build targets NOW..."
echo "RECURSION: ...about to invoke: xcodebuild -configuration \"${CONFIGURATION}\" -target \"${TARGET_NAME}\" -sdk \"${OTHER_SDK_TO_BUULD}\" ${ACTION} RUN_CLANG_STATIC_ANALYZER=NO"
xcodebuild -configuration "${CONFIGURATION}" -target "${TARGET_NAME}" -sdk "${OTHER_SDK_TO_BUILD}" ${ACTION} RUN_CLANG_STATIC_ANALYZER=NO
fi

ACTION="build"

CURRENTCONFIG_DEVICE_DIR=${SYMROOT}/Debug-iphoneos
CURRENTCONFIG_SIMULATOR_DIR=${SYMROOT}/Debug-iphonesimulator
CURRENTCONFIG_UNIVERSAL_DIR=${SYMROOT}/Debug-universal

rm -rf "${CURRENTCONFIG_UNIVERSAL_DIR}"
mkdir "${CURRENTCONFIG_UNIVERSAL_DIR}"

echo "lipo: for current configuration (${CONFIGURATION}) creating output file: ${CURRENTCONFIG_UNIVERSAL_DIR}/${EXECUTABLE_NAME}"
lipo -create -output "${CURRENTCONFIG_UNIVERSAL_DIR}/${EXECUTABLE_NAME}" "${CURRENTCONFIG_DEVICE_DIR}/${EXECUTABLE_NAME}" "${CURRENTCONFIG_SIMULATOR_DIR}/${EXECUTABLE_NAME}"
