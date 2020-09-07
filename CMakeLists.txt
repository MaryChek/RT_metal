cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_STANDARD  90)
set(CMAKE_C_STANDARD_REQUIRED True)

# set the project name
project(RT)

#  find src -type f -name '*.c' | sort | column -c 80 | sed "s/^/       /"
set(${PROJECT_NAME}_SOURCES
		src/fio/fio_zip_load.c src/main.c
		src/gui/coroutine_example.c
        )

add_executable(${PROJECT_NAME}  ${${PROJECT_NAME}_SOURCES})

target_include_directories(${PROJECT_NAME} PUBLIC
        ${SDL2_INCLUDE_DIR}						)

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}/inc				)

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}/lib/mgx/inc		)

target_link_libraries(${PROJECT_NAME} m)
target_link_libraries(${PROJECT_NAME} ${PROJECT_SOURCE_DIR}/lib/mgx/libmgx.a)

find_package(OpenGL REQUIRED)
include_directories( ${OPENGL_INCLUDE_DIRS} )

target_link_libraries(${PROJECT_NAME} ${OPENGL_LIBRARIES} )
target_link_libraries(${PROJECT_NAME} "-framework AppKit")