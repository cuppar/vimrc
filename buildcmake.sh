#!/bin/env bash

# if no source dir, exit
if [[ $# -lt 1 ]];
then
  echo "===> Error: need source dir arg"
  exit
fi

# clean build dir
sourceDir=$1
buildDir="${sourceDir}/build";
echo "===> Build dir: $buildDir";
echo

if [[ -d $buildDir ]];
then
  echo "===> Clean old build dir";
  echo "rm -r $buildDir";
  echo
  rm -r $buildDir;
fi

# cmake generate build files
echo "===> CMake generate build files";
echo "cmake -S $sourceDir -Bbuild";
echo
cmake -S "$sourceDir" -Bbuild;

# CMake build
echo
echo "===> CMake building...";
echo "cmake --build ${buildDir}";
echo
cmake --build "${buildDir}"

# exec binary
echo
echo "===> Exec target"
echo "${buildDir}/main"
echo
"${buildDir}/main"

