#!/bin/bash
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 gcc
git clone https://bitbucket.org/xanaxdroid/dragontc-9.0/ --depth=1 clang

make clean distclean mrproper
export ARCH=arm64     
export KBUILD_BUILD_USER=ProtoChuz
export KBUILD_BUILD_HOST=SemaphoreCI
export USE_CCACHE=1
export CACHE_DIR=~/.ccache
tanggal=$(date +'%m%d-%H%M')
curl -F chat_id="-1001415832052" -F parse_mode="HTML" -F text="Building <b>CrappyKernel Liquid</b>
Compiler : <code>Google GCC 4.9 & Clang</code>
Last Commit : <code>$(git log --oneline --decorate --color --pretty=%s --first-parent -1)</code>
Build Started on : <code>$(date)</code>
Build using : <code>SemaphoreCI</code>" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
rm -rf output
mkdir output
START=$(date +"%s");

alias rolling="make ARCH=arm64 santoni_defconfig && time make -j$(nproc --all) ARCH=arm64 CC=${PWD}/clang/bin/clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE="${PWD}/gcc/bin/aarch64-linux-gnu-""
export CLANG_TCHAIN=/home/runner/CrappyKernel/clang/bin/clang && export KBUILD_COMPILER_STRING=$(${PWD}/dtc/bin/clang --version | head -n 1 | perl -pe 's/\(.*?\)//gs' | sed -e 's/ */ /g' -e 's/[[:space:]]*$//' -e 's/DragonTC/Yuka/g')

export CROSS_COMPILE=${PWD}/gcc/bin/aarch64-linux-android-



make -C ${PWD} O=out santoni_defconfig;
make O=output -j$(nproc --all);

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
zip -r9 CrappyKernel-Liquid-${tanggal}.zip * -x README.md CrappyKernel-Liquid--${tanggal}.zip
curl -F chat_id="-1001415832052" -F document=@"CrappyKernel-Liquid-${tanggal}.zip" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument
END=$(date +"%s")
DIFF=$(($END - $START))
curl -F chat_id="-1001415832052" -F text="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds." https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage
curl -F chat_id="-1001415832052" -F sticker="CAADBQADkwADcX38FOQ9JIMIFhnQAg" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker

fi
