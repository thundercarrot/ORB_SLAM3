@echo off

set EXAMPLES_DIR=%~dp0
call %EXAMPLES_DIR%\windows-run-config.cmd

%ORBSLAM3_BIN_DIR%\stereo_inertial_realsense_t265.exe ^
  C:\dev\collabslam\ORB_SLAM3\Vocabulary\ORBvoc.txt ^
  C:\dev\collabslam\ORB_SLAM3\Examples\Stereo-Inertial\RealSense_T265.yaml

