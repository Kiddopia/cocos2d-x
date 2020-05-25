cmake_minimum_required(VERSION 3.6)

if(WIN32)
set(GAF_PLATFORM_INCLUDE_DIR
  ${COCOS_ROOT}/../external/${PLATFORM_FOLDER}-specific/gles/include/OGLES
  )
elseif(MACOSX OR APPLE)
elseif(LINUX)
elseif(ANDROID)
else()
endif()

set(GAFPLAYER_SRC

    GAFAnimationFrame.cpp
    GAFAnimationSequence.cpp
    GAFAsset.cpp
    GAFAssetTextureManager.cpp
    GAFCachedTexture.cpp
    GAFFile.cpp
    GAFFilterData.cpp
    GAFFilterManager.cpp
    GAFLoader.cpp
    GAFMask.cpp
    GAFMovieClip.cpp
    GAFObject.cpp
    GAFPrecompiled.cpp
    GAFQuadCommand.cpp
    GAFShaderManager.cpp
    GAFSoundInfo.cpp
    GAFSprite.cpp
    GAFStream.cpp
    GAFSubobjectState.cpp
    GAFTextData.cpp
    GAFTextField.cpp
    GAFTextureAtlas.cpp
    GAFTextureAtlasElement.cpp
    GAFTimeline.cpp
    GAFTimelineAction.cpp
    MySprite.cpp
    PrimitiveDeserializer.cpp
    TagDefineAnimationFrames.cpp
    TagDefineAnimationFrames2.cpp
    TagDefineAnimationMasks.cpp
    TagDefineAnimationObjects.cpp
    TagDefineAtlas.cpp
    TagDefineAtlas3.cpp
    TagDefineNamedParts.cpp
    TagDefineSequences.cpp
    TagDefineSounds.cpp
    TagDefineStage.cpp
    TagDefineTextField.cpp
    TagDefineTimeline.cpp    
    )

include_directories(
  ${GAF_PLATFORM_INCLUDE_DIR}
  ${GAF_ROOT}
  ${COCOS2DX_ROOT_PATH}
  ${COCOS2DX_ROOT_PATH}/2d
  ${COCOS2DX_ROOT_PATH}/platform/${PLATFORM_FOLDER}
  ${COCOS2DX_ROOT_PATH}/../external/${PLATFORM_FOLDER}-specific/zlib/include
  ${COCOS2DX_ROOT_PATH}/../external/glfw3/include/${PLATFORM_FOLDER}
  ${COCOS2DX_ROOT_PATH}/math
)

add_library(extgaf STATIC ${GAFPLAYER_SRC})

set_target_properties(extgaf
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
