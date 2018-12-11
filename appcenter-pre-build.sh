#!/usr/bin/env bash

# Example: Change bundle name of an iOS app for non-production
if [ "$APPCENTER_BRANCH" == "master" ];
then
    plutil -replace BuildMode=1 $APPCENTER_SOURCE_DIRECTORY/SchoolConnectOnBoarding/Helper/Info.plist
fi
