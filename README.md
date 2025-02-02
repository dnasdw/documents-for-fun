# documents-for-fun
## A3004NS
相关文章：[TOTOLINK A3004NS 国行刷入 Breed 不死和 hiboy Padavan 固件](https://woodenrobot.me/2019/09/17/A3004NS/) 

包含 TOTOLINK A3004NS 路由器刷机相关文件

```
.
├── A3004NS_3.4.3.9-099.trx
├── STOCK_ROM_UPGRADE_A3004NS_3.4.3.9-099_20170307-0247.trx
├── breed 备份
├── breed-mt7621-totolink-a3004ns.bin
└── dd备份
```

## 优酷路由宝 YK-L1c
相关文章：[优酷土豆路由宝 YK-L1c 刷机过程](https://www.sqyai.com/post-562.html)

包含优酷路由宝 YK-L1c 刷入 Padavan 固件相关文件
```
.
├── RT-N14U-GPIO-1-youku1-128M_3.4.3.9-099.trx
├── Youku-L1c-0818-root.bin
└── breed-mt7620-youku-yk1.bin
```

## 群晖 Synology DSM
相关文章：
- [修复黑群晖 Moments 1.3.x 版本人物识别不能使用问题](https://woodenrobot.me/2019/09/26/fix-moments/)
- [群晖 Video Station 支持 DTS 和 eac3 解决方案](https://woodenrobot.me/2019/08/12/syn-vediostation/)

```
.
└── libsynophoto-plugin-detection.so
└── ffmpeg_dts_eac3_patch.sh
```

- [x] Synology DS918+ / DSM 7.1-42661 Update 1 / Video Station 3.0.3-2084 / ffmpeg 4.4.2-43
- [x] Synology DS918+ / DSM 7.0.1-42218 Update 3 / Video Station 3.0.2-2072 / ffmpeg 4.3.3-39
- [x] Synology DS918+ / DSM 7.0.1-42218 / Video Station 3.0.1-2067 / ffmpeg 4.3.3-39

ffmpeg wrapper (rev12):

### install

```Shell
sh -c "$(wget -O - https://raw.githubusercontent.com/dnasdw/documents-for-fun/master/Synology/ffmpeg_dts_eac3_patch.sh)" -p install
```

### uninstall

```Shell
sh -c "$(wget -O - https://raw.githubusercontent.com/dnasdw/documents-for-fun/master/Synology/ffmpeg_dts_eac3_patch.sh)" -p uninstall
```

### install with proxy

```Shell
sh -c "$(wget -e "https_proxy=http://192.168.3.7:1083" -O - https://raw.githubusercontent.com/dnasdw/documents-for-fun/master/Synology/ffmpeg_dts_eac3_patch.sh)" -p install
```

### uninstall with proxy

```Shell
sh -c "$(wget -e "https_proxy=http://192.168.3.7:1083" -O - https://raw.githubusercontent.com/dnasdw/documents-for-fun/master/Synology/ffmpeg_dts_eac3_patch.sh)" -p uninstall
```
