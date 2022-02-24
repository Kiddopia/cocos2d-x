# define output folder environment variable
BUILD_DIR=../build
BUILD_ROOT=../build
UNIVERSAL_OUTPUTFOLDER=../prebuilt/ios/
UNIVERSAL_OUTPUT_INCLUDE_FOLDER=../prebuilt/ios/include/
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
mkdir -p ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --include "*.inl" --exclude "*" ../cocos/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../cocos/editor-support/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/Box2D/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/bullet/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/chipmunk/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/curl/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/freetype2/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/jpeg/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/openssl/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/png/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/webp/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/websockets/include/ios/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/clipper ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/ConvertUTF/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/edtaa3func/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/flatbuffers/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/json ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/md5 ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/poly2tri ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/recast ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/sqlite3/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/tinydir ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/tinyxml2/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/unzip/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/uv/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/xxhash/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../external/zlib/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../pba-external/gaf/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
rsync -zar --include "*/" --include "*.h" --exclude "*" ../pba-external/spine/include/ ${UNIVERSAL_OUTPUT_INCLUDE_FOLDER}
