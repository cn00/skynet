

thisdir=$(cd `dirname $0`;pwd)
cd "$thisdir"

build_type="Release" #Debug
mkdir -p $thisdir/build.OSX && pushd $_
cmake --clean-first -GXcode ../  -DOSX=TRUE # -DCMAKE_TOOLCHAIN_FILE=../build/cmake/ios.toolchain.cmake -DPLATFORM="macosx"
popd
cmake --build build.OSX --config ${build_type} #--target xlua lfs lfb expat luasql lsqlite3 nslua libmariadb p7zip

ln -sf $PWD/app         $PWD/bin/${build_type}/
ln -sf $PWD/examples    $PWD/bin/${build_type}/
ln -sf $PWD/lualib      $PWD/bin/${build_type}/
ln -sf $PWD/service     $PWD/bin/${build_type}/

ln -sf $PWD/../Assets/BundleRes/lua     $PWD/bin/${build_type}/
ln -sf $PWD/../Assets/BundleRes/proto   $PWD/bin/${build_type}/