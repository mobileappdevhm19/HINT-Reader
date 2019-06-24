cmake_minimum_required(VERSION 3.4.1)

# now build app's shared lib
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

# Import the CMakeLists.txt for the glm library
#add_subdirectory(glm) # if your CMakeLists is at '../cpp'
#add_subdirectory(../src/main/cpp/glm) # if your CMakeLists is at '../app'



add_library(gl2jni SHARED
            gl_code.cpp
            )

# add lib dependencies
target_link_libraries(gl2jni
                      android
                      log
                      EGL
                      GLESv2)
