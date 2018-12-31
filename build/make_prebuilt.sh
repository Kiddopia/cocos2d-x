# define output folder environment variable
BUILD_DIR=../build
BUILD_ROOT=../build
UNIVERSAL_OUTPUTFOLDER=../prebuilt/ios/

CONFIGURATION=Release

# Build Simulator version
xcodebuild -project cocos2d-x.xcodeproj -target libcocos2d-x VALID_ARCHS='x86_64' ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

# Build Device version
xcodebuild -project cocos2d-x.xcodeproj -target libcocos2d-x ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/lib"

# Step 2. Create universal binary file using lipo
#lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2d-x.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/libcocos2d-x.a"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2d-x.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/libcocos2d-x.a" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/libcocos2d-x.a"

# remove the build files
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphoneos"
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

# strip symbols
xcrun strip -S "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2d-x.a"

# copy header files
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*/" --include "*.h" --include "*.inl" --exclude "*" ../cocos "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*/" --include "*.h" --exclude "*" --exclude "gaf/**" ../external "${UNIVERSAL_OUTPUTFOLDER}/include/"
