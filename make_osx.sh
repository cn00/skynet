

thisdir=$(cd `dirname $0`;pwd)
cd "$thisdir"

build_type="Release" #Debug
mkdir -p $thisdir/build.OSX && pushd $_
cmake --clean-first -GXcode ../  -DOSX=TRUE -DCMAKE_BUILD_TYPE=${build_type} # -DCMAKE_TOOLCHAIN_FILE=../build/cmake/ios.toolchain.cmake -DPLATFORM="macosx"
cmake --build . --config ${build_type} #--target xlua lfs lfb expat luasql lsqlite3 nslua libmariadb p7zip

ln -sf $PWD/../app         $PWD/bin/${build_type}/
ln -sf $PWD/../examples    $PWD/bin/${build_type}/
ln -sf $PWD/../lualib      $PWD/bin/${build_type}/
ln -sf $PWD/../service     $PWD/bin/${build_type}/

ln -sf $PWD/../../Assets/BundleRes/proto   $PWD/bin/${build_type}/
if [[ ! -s $PWD/bin/${build_type}/sharelua ]];then
    ln -sf $PWD/../../Assets/BundleRes/lua     $PWD/bin/${build_type}/sharelua
fi
popd
