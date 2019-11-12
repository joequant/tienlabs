cp nix.conf status-react/nix
pushd status-react
make shell TARGET_OS=android
popd
