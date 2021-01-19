cmake_minimum_required(VERSION 3.9)

project(hell LANGUAGES CXX VERSION 1.0.0)

add_compile_options(-std=c++17)

set(SRC src/main.cc)

add_executable(hello ${SRC})