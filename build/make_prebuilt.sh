# define output folder environment variable
BUILD_DIR=../build
BUILD_ROOT=../build
UNIVERSAL_OUTPUTFOLDER=../prebuilt/ios/

CONFIGURATION=Release

# Build Simulator version
xcodebuild -project cocos2dx.xcodeproj -target libcocos2dx VALID_ARCHS='x86_64' ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

# Build Device version
xcodebuild -project cocos2dx.xcodeproj -target libcocos2dx ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/lib"

# Step 2. Create universal binary file using lipo
#lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2dx.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/libcocos2dx.a"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2dx.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/libcocos2dx.a" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/libcocos2dx.a"

# remove the build files
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphoneos"
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

# strip symbols
xcrun strip -S "${UNIVERSAL_OUTPUTFOLDER}/lib/libcocos2dx.a"

# copy header files
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --exclude "editor-support/cocosbuilder/" --exclude "editor-support/spine/" --include "*/" --include "*.h" --include "*.inl" --exclude "*" ../cocos/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --exclude "Box2D/" --include "*/" --include "*.h" --exclude "*" ../external/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*/" --include "*.h" --exclude "*" ../cocos/editor-support/cocostudio "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/Box2D/include/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
#rsync -zar --include "gaf/" --include "*.h" --exclude "*" ../pba-external/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*.h" --exclude "*" ../pba-external/gaf/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
rsync -zar --include "*/" --include "*.h" --exclude "*" ../pba-external/spine/include/ "${UNIVERSAL_OUTPUTFOLDER}/include/"
