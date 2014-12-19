cmake_minimum_required(VERSION 2.8)
project(Boxer)

set(INC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")

set(SOURCES "")
set(LIBRARIES "")

if (NOT WIN32)
   # C++11
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif (NOT WIN32)

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