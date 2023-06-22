# Building on Windows using vcpkg and CMake

## Clone repository

```
git clone <this repo>
```

## Update CMake to the latest version

https://cmake.org/download/

This will avoid warnings about Boost being newer than some packages.

When installing CMake, take the option to add CMake to the PATH variable.

## Install vcpkg

If you haven't already, install vcpkg anywhere you like:

```
git clone https://github.com/Microsoft/vcpkg.git
.\vcpkg\bootstrap-vcpkg.bat
```

Note the path to vcpkg, which will be needed later.

We are using vcpkg in "manifest" mode. There is no need for the "integrate" step. Dependencies are listed in vcpkg.json.

If you will be using ORB-SLAM3 in a project that is already using vcpkg, use that instance (you might need to update it).


## Build ORB-SLAM3

```
cd ORB_SLAM3
cmake -B build -DCMAKE_TOOLCHAIN_FILE=<path to your vcpkg dir>\scripts\buildsystems\vcpkg.cmake
cmake --build build --config Release
```

Both steps will take a while.

## Uncompress Vocabulary file

```
cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..
```

## Test ORB-SLAM3

```
bin\mono_euroc.exe .\Vocabulary\ORBvoc.txt .\Examples\Monocular\EuRoC.yaml <download path>\MH_01_easy .\Examples\Monocular\EuRoC_TimeStamps\MH01.txt
```

See the original ORB_SLAM3 README on obtaining the EuRoC images. (get ASL format dataset "Machine Hall 1" from https://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets)

## Using in your own project

Add include directories to your project:

```
<ORB_SLAM3 dir>
<ORB_SLAM3 dir>\include
<ORB_SLAM3 dir>\include\CameraModels
<ORB_SLAM3 dir>\Thirdparty\Sophus
```

Add library directories to your project:

```
<ORB_SLAM3 dir>\lib
```

Add input libraries:

```
ORB_SLAM3.lib
DBoW2.lib
hashlibpp.lib
g2o.lib
```

In your code, add the following includes:

```
#define _WIN_
#define COMPILEDWITHC11
#define HAVE_EIGEN
#define HAVE_GLEW
#include <opencv2/core/core.hpp>
#pragma warning(push)
#pragma warning(disable: 4996 4267 4244 4305)
#include <System.h>
#pragma warning(pop)
```

## Suggestion

Include both vcpkg and ORB_SLAM3 as submodules in your project. This will keep version skew to a minimum.
