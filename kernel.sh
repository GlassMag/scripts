#!/bin/bash
make clean distclean mrproper
export ARCH=arm64
export CROSS_COMPILE=/home/runner/android_kernel_xiaomi_santoni/uber/bin/aarch64-linux-android-
export KBUILD_BUILD_USER=magchuz
export KBUILD_BUILD_HOST=CrappyServer
export USE_CCACHE=1
export CACHE_DIR=~/.ccache
curl -F chat_id="-1001415832052" -F text="Compiling New Commits..." https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
tanggal=$(date +'%m%d-%H%M')
rm -rf output
mkdir output
make -C $(pwd) O=output santoni_nontreble_defconfig
make -j8 -C $(pwd) O=output
if [ ! -f output/arch/arm64/boot/Image.gz-dtb ]; then
    echo "HolyCrap, Compiling Failed"
    curl -F chat_id="-1001415832052" -F text="HolyCrap, Compile Fail :(" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

else 
cp output/arch/arm64/boot/Image.gz-dtb AnyKernel2/zImage
cd AnyKernel2
rm -rf *.zip
zip -r9 CrappyKernel-Liquor-${tanggal}.zip * -x README.md CrappyKernel-Liquor--${tanggal}.zip
echo "Yeehaa Booooi, Compiling Success!"
curl -F chat_id="-1001415832052" -F document=@"CrappyKernel-Liquor-${tanggal}.zip" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument
curl -F chat_id="-1001415832052" -F text="HolyCrap, Compile Success :)" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
curl -F chat_id="-1001415832052" -F text="Whats New ?
$(git log --oneline --decorate --color --pretty=%s --first-parent -3)" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

fi
curl -F chat_id="-1001415832052" -F sticker="CAADBQADZwADqZrmFoa87YicX2hwAg" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker
