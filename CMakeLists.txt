cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_STANDARD  90)
set(CMAKE_C_STANDARD_REQUIRED True)

# set the project name
project(RT)

#  find src -type f -name '*.c' | sort | column -c 80 | sed "s/^/       /"
set(${PROJECT_NAME}_SOURCES
		src/err/rt_err.c         src/gui/rt_editor_drag_file.c
		src/err/rt_warn.c                src/main.c
		src/fio/fio_zip_load.c src/rts/rts_init.c
		src/fio/fio_zip_save.c           src/rtc/rtc_init.c
		src/gui/coroutine_example.c      src/rtc/rtc_loop.c
		)

add_executable(${PROJECT_NAME}  ${${PROJECT_NAME}_SOURCES})

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}/inc				)

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}/lib/mlx/inc		)

target_include_directories(${PROJECT_NAME} PUBLIC
		${PROJECT_SOURCE_DIR}/lib/ft/inc		)

target_link_libraries(${PROJECT_NAME} ${PROJECT_SOURCE_DIR}/lib/ft/libft.a)

target_link_libraries(${PROJECT_NAME} ${PROJECT_SOURCE_DIR}/lib/mlx/libmlx.dylib)
target_link_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/lib/mlx)

target_link_libraries(${PROJECT_NAME} "-framework AppKit")
