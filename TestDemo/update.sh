# /bin/sh

rm Podfile.lock
rm -rf ./Pods
rm -rf ./*.xcworkspace
pod install
