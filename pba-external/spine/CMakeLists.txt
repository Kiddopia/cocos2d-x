cmake_minimum_required(VERSION 3.17.3)

# set TARGET
set(TARGET spine)

# set Spine path
set(Spine_ROOT ${COCOS2DX_ROOT_PATH}/pba-external/spine)

# search all files and populate list
file(GLOB Spine_List_SRC
            ${Spine_ROOT}/src/spine/*.cpp
)

# include all files from list as well as include individual files
set(Spine_SRC
    ${Spine_List_SRC}
)

# Add source files
add_library(spine STATIC ${Spine_SRC})

# Link cocos2d
target_link_libraries(spine cocos2d)

# add precompile header
target_precompile_headers(spine
		PUBLIC ${COCOS2DX_ROOT_PATH}/cocos/cocos2d.h
		PUBLIC ${COCOS2DX_ROOT_PATH}/cocos/ui/CocosGUI.h)

# target include directories for other 
target_include_directories(spine 
        PUBLIC	${Spine_ROOT}/include
)