#!/bin/zsh


create_git () {
  echo 'INITIALIZING GIT'
  git init
  echo 'CREATING .GITIGNORE'
  touch .gitignore
  echo 'out/build/*' >> .gitignore
}

create_directories_and_files() {
  echo 'MAKING DIRECTORIES'
  mkdir src include tests && -p docx/code/src && out/build
  echo 'MAKING MAIN CMAKE FILE'
  touch CMakeLists.txt
  echo 'MAKING TEST FILES'
  touch tests/main.cc tests/CMakeLists.txt
  echo 'MAKING README'
  touch README.md
}

fill_main_cmake() {
  echo 'FILLING MAIN CMAKE FILE'
  cat > CMakeLists.txt << EOF
#
# Setting CMake version
#
cmake_minimum_required(VERSION 3.30.5)

#
# Setting C++ Standard:
#
set(CMAKE_CXX_STANDARD 17)

#
# Requiring C++ Standard:
#
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#
# Setting Project Name (useful when building):
#
project(project_name VERSION 1.0)

#
# Adding Source Files:
#
set(SRC_FILES
    # src/main.cc
    # src/game.cc
    # src/player.cc
    # ...
)

#
# Creating Executable
#
add_executable(\${PROJECT_NAME} \${SRC_FILES})

#
# Adding Header Files
#
target_include_directories(\${PROJECT_NAME} PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)

#
# Adding Test CMake:
#
add_subdirectory(tests)

#
# Custom targets (example)
#
# ...
EOF
}

fill_test_cmake() {
  echo 'FILLING TEST CMAKE FILE'
  cat > tests/CMakeLists.txt << EOF
#
# Adding Catch2 or GTest:
#
find_package(Catch2 3.5.2 REQUIRED)

#
# Specify source files for tests:
#
set(TEST_SOURCES
    test.cc                 # Main test file
    ../src/Game.cc          # Game class implementation
    ../src/Player.cc        # Player class implementation
    # Add additional test files here as needed
)

#
# These tests can use the Catch2-provided main
#
add_executable(tests \${TEST_SOURCES})

#
# Linking tests executable with Catch2 headers
#
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)

#
# Include directories:
#
target_include_directories(tests PRIVATE 
    \${CMAKE_CURRENT_SOURCE_DIR}/../include
    \${CMAKE_CURRENT_SOURCE_DIR}/../src
)

#
# Register the tests to be run
#
add_test(NAME my_tests COMMAND tests)
EOF
}

add_rules_to_readme () {
  cat > README.md << EOF
## Build Instructions

### Main Executable

- cd out/build
- cmake -S ../../ -B .
- cmake --build .
- ./project_name

### Test Executable
- cd tests
- ./tests
EOF
}

main () {
  create_git
  create_directories_and_files
  fill_main_cmake
  fill_test_cmake
  add_rules_to_readme
}

main
