cmake_minimum_required(VERSION 2.8)
project(Boxer)

set(INC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")

set(SOURCES "")
set(LIBRARIES "")

if (APPLE)
   list(APPEND SOURCES
      "${LIB_DIR}/boxer_osx.mm"
   )
   find_library(COCOA_LIBRARY Cocoa)
   list(APPEND LIBRARIES
      ${COCOA_LIBRARY}
   )
endif (APPLE)

include_directories(${INC_DIR})
add_library(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})