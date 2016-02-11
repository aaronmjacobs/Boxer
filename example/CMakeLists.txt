# Project definition
cmake_minimum_required(VERSION 3.1)
project(Boxer-Examples VERSION 1.0.0 LANGUAGES C)

# Executable definition and features
add_executable(${PROJECT_NAME} "example.c")
target_include_directories(${PROJECT_NAME} PRIVATE $<TARGET_PROPERTY:Boxer,INTERFACE_INCLUDE_DIRECTORIES>)
target_link_libraries(${PROJECT_NAME} PRIVATE Boxer $<TARGET_PROPERTY:Boxer,INTERFACE_LINK_LIBRARIES>)
target_compile_features(${PROJECT_NAME} PRIVATE $<TARGET_PROPERTY:Boxer,INTERFACE_COMPILE_FEATURES>)
target_compile_definitions(${PROJECT_NAME} INTERFACE $<TARGET_PROPERTY:Boxer,INTERFACE_COMPILE_DEFINITIONS>)