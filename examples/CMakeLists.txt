# Project definition
cmake_minimum_required(VERSION 3.1)
project(Boxer-Examples VERSION 1.0.0 LANGUAGES C)

# Executable definition and features
add_executable(${PROJECT_NAME} "example.c")
target_link_libraries(${PROJECT_NAME} PRIVATE Boxer)
