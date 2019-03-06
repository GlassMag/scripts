#!/bin/bash
git clone git://github.com/krasCGQ/aarch64-linux-android -b a53-7.x --depth=1 gcc
make clean distclean mrproper
export ARCH=arm64
export CROSS_COMPILE=/home/runner/CrappyKernel/gcc/bin/aarch64-cortex_a53-linux-android-
export KBUILD_BUILD_USER=ProtoChuz
export KBUILD_BUILD_HOST=SemaphoreCI
export USE_CCACHE=1
export CACHE_DIR=~/.ccache
tanggal=$(date +'%m%d-%H%M')
curl -F chat_id="-1001415832052" -F parse_mode="HTML" -F text="Building <b>CrappyKernel Liquor</b>
Compiler : <code>Linaro GCC 7.3</code>
Last Commit : <code>$(git log --oneline --decorate --color --pretty=%s --first-parent -1)</code>
Build Started on : <code>$(date)</code>
Build using : <code>SemaphoreCI</code>" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
rm -rf output
mkdir output
START=$(date +"%s");
make -C $(pwd) O=output santoni_nontreble_defconfig
make -j$(nproc --all) -C $(pwd) O=output 2>&1| tee ${tanggal}-Log.txt
if [ ! -f output/arch/arm64/boot/Image.gz-dtb ]; then
    echo "HolyCrap, Compiling Failed"
    curl -F chat_id="-1001324692867" -F document=@"${tanggal}-Log.txt" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument
    curl -F chat_id="-1001415832052" -F text="Build throw an error(s)" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
    curl -F chat_id="-1001415832052" -F sticker="CAADBQADlAADcX38FOe-kEXhrShYAg" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker

else 
cp output/arch/arm64/boot/Image.gz AnyKernel2/kernel/Image.gz

cp output/arch/arm64/boot/dts/qcom/msm8940-pmi8950-qrd-sku7_S88536AA2.dtb AnyKernel2/nontreble/msm8940-pmi8950-qrd-sku7_S88536AA2.dtb

cp output/arch/arm64/boot/dts/qcom/msm8940-pmi8950-qrd-sku7_S88536AA2-treble.dtb AnyKernel2/treble/msm8940-pmi8950-qrd-sku7_S88536AA2-treble.dtb

cd AnyKernel2
rm -rf *.zip
zip -r9 CrappyKernel-Liquor-${tanggal}.zip * -x README.md CrappyKernel-Liquor--${tanggal}.zip
curl -F chat_id="-1001415832052" -F document=@"CrappyKernel-Liquor-${tanggal}.zip" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument
END=$(date +"%s")
DIFF=$(($END - $START))
curl -F chat_id="-1001415832052" -F text="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds." https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
curl -F chat_id="-1001415832052" -F sticker="CAADBQADkwADcX38FOQ9JIMIFhnQAg" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker

fi
