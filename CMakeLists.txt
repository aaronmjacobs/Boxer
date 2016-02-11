# Project definition
cmake_minimum_required(VERSION 3.1)
project(Boxer VERSION 1.0.0 LANGUAGES CXX)

# Source files
set(BOXER_LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")
set(BOXER_SOURCES)
set(BOXER_LINUX ${CMAKE_SYSTEM_NAME} MATCHES "Linux")
if (APPLE)
   list(APPEND BOXER_SOURCES
      "${BOXER_LIB_DIR}/boxer_osx.mm"
   )
elseif (WIN32)
   list(APPEND BOXER_SOURCES
      "${BOXER_LIB_DIR}/boxer_win.cpp"
   )
elseif (BOXER_LINUX)
   list(APPEND BOXER_SOURCES
      "${BOXER_LIB_DIR}/boxer_linux.cpp"
   )
endif (APPLE)

# Library definition and features
add_library(${PROJECT_NAME} ${BOXER_SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_compile_features(${PROJECT_NAME} PUBLIC cxx_strong_enums cxx_nullptr)

# Platform-specific dependencies
if (APPLE)
   find_library(COCOA_LIBRARY Cocoa)
   target_link_libraries(${PROJECT_NAME} PUBLIC ${COCOA_LIBRARY})
elseif (BOXER_LINUX)
   find_package(PkgConfig REQUIRED)
   pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
   target_link_libraries(${PROJECT_NAME} PUBLIC ${GTK3_LIBRARIES})
   target_include_directories(${PROJECT_NAME} PRIVATE ${GTK3_INCLUDE_DIRS})
endif (APPLE)

# Symbol exporting
if (BUILD_SHARED_LIBS)
   target_compile_definitions(${PROJECT_NAME} PRIVATE "BOXER_BUILD_DLL")
   target_compile_definitions(${PROJECT_NAME} INTERFACE "BOXER_DLL")
endif (BUILD_SHARED_LIBS)

# Build options
option(BOXER_BUILD_EXAMPLES "Build example program" OFF)
if (BOXER_BUILD_EXAMPLES)
   add_subdirectory(example)
endif()