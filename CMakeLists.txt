cmake_minimum_required(VERSION 3.1)
project(Boxer)

option(BOXER_BUILD_EXAMPLES "Build example program" OFF)

set(INC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")

set(SOURCES)
set(LIBRARIES)
set(BOXER_DEFINITIONS)

if (BUILD_SHARED_LIBS)
   add_definitions(-DBOXER_BUILD_DLL)
   list(APPEND BOXER_DEFINITIONS
      -DBOXER_DLL
   )
endif (BUILD_SHARED_LIBS)

if (APPLE)
   list(APPEND SOURCES
      "${LIB_DIR}/boxer_osx.mm"
   )
   find_library(COCOA_LIBRARY Cocoa)
   list(APPEND LIBRARIES
      ${COCOA_LIBRARY}
   )
endif (APPLE)

if (WIN32)
   list(APPEND SOURCES
      "${LIB_DIR}/boxer_win.cpp"
   )
endif (WIN32)

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
   list(APPEND SOURCES
      "${LIB_DIR}/boxer_linux.cpp"
   )
   find_package(PkgConfig REQUIRED)
   pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
   list(APPEND LIBRARIES
      ${GTK3_LIBRARIES}
   )
   include_directories(${GTK3_INCLUDE_DIRS})
   link_directories(${GTK3_LIBRARY_DIRS})
   add_definitions(${GTK3_CFLAGS_OTHER})
endif (${CMAKE_SYSTEM_NAME} MATCHES "Linux")

include_directories(${INC_DIR})
add_library(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})

# Compiler requirements
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)

if(BUILD_SHARED_LIBS)
   list(APPEND LIBRARIES
      ${PROJECT_NAME}
   )
endif(BUILD_SHARED_LIBS)

# Export
set(BOXER_LIBRARIES ${LIBRARIES} PARENT_SCOPE)
set(BOXER_INCLUDE_DIR ${INC_DIR} PARENT_SCOPE)
set(BOXER_DEFINITIONS ${BOXER_DEFINITIONS} PARENT_SCOPE)

if (BOXER_BUILD_EXAMPLES)
   add_subdirectory(example)
endif()