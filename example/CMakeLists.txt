cmake_minimum_required(VERSION 3.1)
project(Boxer-Examples)

set(EXAMPLE_SOURCES "example.cpp")
set(EXAMPLE_LIBRARIES ${CMAKE_PROJECT_NAME})

include_directories(${INC_DIR})
add_executable(${PROJECT_NAME} ${EXAMPLE_SOURCES})
target_link_libraries(${PROJECT_NAME} ${EXAMPLE_LIBRARIES})

# Compiler requirements
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)