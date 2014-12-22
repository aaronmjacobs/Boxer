cmake_minimum_required(VERSION 2.8)
project(Boxer-Examples)

set(EXAMPLE_SOURCES "example.c")
set(EXAMPLE_LIBRARIES ${CMAKE_PROJECT_NAME})

include_directories(${INC_DIR})
add_executable(${PROJECT_NAME} ${EXAMPLE_SOURCES})
target_link_libraries(${PROJECT_NAME} ${EXAMPLE_LIBRARIES})