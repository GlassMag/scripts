#!/bin/bash

git clone https://github.com/najahiiii/aarch64-linux-gnu/ -b gcc9-20190316 --depth=1 gcc

make clean distclean

export ARCH=arm64

export CROSS_COMPILE=/home/runner/CrappyKernel/gcc/bin/aarch64-linux-gnu-

export KBUILD_BUILD_USER=CrappyUser

export KBUILD_BUILD_HOST=Semaphore

export USE_CCACHE=1

export CACHE_DIR=~/.ccache

tanggal=$(date +'%m%d-%H%M')


curl -F chat_id="-1001415832052" -F parse_mode="HTML" -F text="Building <b>CrappyKernel Liquid</b>
Compiler : <code>GNU GCC 9</code>
Last Commit : <code>$(git log --oneline --decorate --color --pretty=%s --first-parent -1)</code>
Build Started on : <code>$(date)</code>
Build using : <code>SemaphoreCI</code>" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage




rm -rf output

mkdir output

START=$(date +"%s");

make -C $(pwd) O=output santoni_defconfig

make -j12 -C $(pwd) O=output 2>&1| tee ${tanggal}-Log.txt


if [ ! -f output/arch/arm64/boot/Image.gz-dtb ]; then

    sad[0]="CAADBQAD_QADcX38FEShXDvMS63qAg"

    sad[1]="CAADBQADCAEAAnF9_BQn_wgQXxXZYgI"

    sad[2]="CAADBQADlAADcX38FOe-kEXhrShYAg"

    randS=$[$RANDOM % ${#sad[@]}]

    sadS=${sad[$randS]}

    curl -F chat_id="-1001324692867" -F document=@"${tanggal}-Log.txt" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendDocument

    curl -F chat_id="-1001415832052" -F text="Build throw an error(s)" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

    curl -F chat_id="-1001415832052" -F sticker="${sadS}" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker

    exit

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

happy[0]="CAADBQAD4wADcX38FIeK7yk7KBaxAg"

happy[1]="CAADBQAD7wADcX38FBn4lWaZGvmtAg"

happy[2]="CAADBQADkwADcX38FOQ9JIMIFhnQAg"

randS=$[$RANDOM % ${#happy[@]}]

happyS=${happy[$randS]}


curl -F chat_id="-1001415832052" -F text="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds." https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendMessage

curl -F chat_id="-1001415832052" -F sticker="${happyS}" https://api.telegram.org/bot757761074:AAFKxcBRT-hsNfyC0wXTH_GXJozT7yzflKU/sendSticker


fi

