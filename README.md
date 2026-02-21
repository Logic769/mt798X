<div align="center">

# MT798X TTL 串口救砖工具包

**MediaTek Filogic 系列路由器串口救砖解决方案**

[![Platform](https://img.shields.io/badge/Platform-Windows-blue.svg)]()
[![Chipset](https://img.shields.io/badge/Chipset-MT7981%20%7C%20MT7986%20%7C%20MT7622-green.svg)]()
[![License](https://img.shields.io/badge/License-Open%20Source-orange.svg)]()

</div>

---

## 📖 目录

- [项目简介](#-项目简介)
- [功能特性](#-功能特性)
- [支持的设备](#-支持的设备)
- [工具清单](#-工具清单)
- [快速开始](#-快速开始)
- [详细使用教程](#-详细使用教程)
- [常见问题](#-常见问题)
- [注意事项](#-注意事项)
- [致谢](#-致谢)

---

## 📝 项目简介

本项目是一套完整的 **MediaTek MT798X 系列路由器串口救砖工具包**，主要用于解决路由器因固件刷写失败、配置错误等原因导致的无法启动问题（俗称"变砖"）。

通过 USB 转 TTL 串口工具，配合本工具包中的 `mtk_uartboot` 程序，可以在路由器的 BootROM 阶段直接加载 BL2 和 FIP 固件，从而绕过损坏的引导分区，实现救砖操作。

### 工作原理

```
┌─────────────────────────────────────────────────────────────┐
│                      救砖流程示意图                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   [路由器断电] ──► [连接TTL] ──► [运行救砖脚本]              │
│                                    │                        │
│                                    ▼                        │
│   [等待握手] ◄── [路由器上电] ── [BootROM响应]               │
│       │                                                     │
│       ▼                                                     │
│   [发送BL2] ──► [加载到RAM] ──► [发送FIP]                   │
│                                      │                      │
│                                      ▼                      │
│   [进入U-Boot] ◄── [加载完成] ──► [按Reset进入WebUI]        │
│       │                                                     │
│       ▼                                                     │
│   [恢复固件] ──► [救砖完成]                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## ✨ 功能特性

| 特性 | 说明 |
|:----:|:-----|
| 🔧 **一键救砖** | 提供自动化脚本，简化操作流程 |
| 📦 **多型号支持** | 支持 MT7981/MT7986/MT7622 多款芯片 |
| 🚀 **高速传输** | 支持最高 1500000 波特率，传输更快 |
| 🔄 **自动识别** | 自动匹配 SoC 类型和 DDR 类型 |
| 💻 **图形化工具** | 包含 TFTP 服务器、串口终端等配套工具 |
| 📚 **详细文档** | 提供完整的操作说明和教程 |

---

## 🖥️ 支持的设备

### MT7981 平台 (Filogic 820)

| 设备型号 | 芯片 | DDR类型 | FIP文件 |
|:---------|:----:|:-------:|:--------|
| 360 T7 | MT7981 | DDR3 | `mt7981_360t7-fip-fixed-parts.bin` |
| ABT ASR3000 | MT7981 | DDR3 | `mt7981_abt_asr3000-fip-fixed-parts.bin` |
| 中兴 AX3000T | MT7981 | DDR3 | `mt7981_ax3000t-fip-fixed-parts-multi-layout.bin` |
| Cetron CT3003 | MT7981 | DDR3 | `mt7981_cetron_ct3003-fip-fixed-parts.bin` |
| CLT R30B1 | MT7981 | DDR3 | `mt7981_clt_r30b1-fip-fixed-parts.bin` |
| 移动 A10 | MT7981 | DDR3 | `mt7981_cmcc_a10-fip-fixed-parts.bin` |
| 移动 RAX3000M (NAND) | MT7981 | DDR4 | `mt7981_cmcc_rax3000m-fip-fixed-parts.bin` |
| 移动 RAX3000M (eMMC) | MT7981 | DDR4 | `mt7981_cmcc_rax3000m-emmc-fip.bin` |
| 移动 RAX3000M (NAND-ImmortalWrt) | MT7981 | DDR4 | `mt7981_cmcc_rax3000m-nand-fip-bl31-immortalwrt-uboot.fip` |
| 移动 XR30 (NAND) | MT7981 | DDR4 | `mt7981_cmcc_xr30-fip-114M-parts-CN-MESH.bin` |
| 移动 XR30 (eMMC) | MT7981 | DDR4 | `mt7981_cmcc_xr30-emmc-fip.bin` |
| H3C NX30 Pro | MT7981 | DDR3 | `mt7981_h3c_magic-nx30-pro-fip-fixed-parts.bin` |
| Imou LC-HX3001 | MT7981 | DDR3 | `mt7981_imou_lc-hx3001-fip-fixed-parts.bin` |
| JCG Q30 | MT7981 | DDR3 | `mt7981_jcg_q30-fip-fixed-parts.bin` |
| 康佳 Komi A31 | MT7981 | DDR3 | `mt7981_konka_komi-a31-fip-fixed-parts.bin` |
| Livinet ZR-3020 | MT7981 | DDR3 | `mt7981_livinet_zr-3020-fip-fixed-parts.bin` |
| 锐捷 WR30U | MT7981 | DDR3 | `mt7981_wr30u-fip-fixed-parts-multi-layout.bin` |

### MT7986 平台 (Filogic 830)

| 设备型号 | 芯片 | DDR类型 | FIP文件 |
|:---------|:----:|:-------:|:--------|
| GL.iNet GL-MT6000 | MT7986 | DDR4 | `mt7986_glinet_gl-mt6000-fip.bin` |
| 京东云百里 | MT7986 | DDR4 | `mt7986_jdcloud_re-cp-03-fip.bin` |
| 红米 AX6000 | MT7986 | DDR4 | `mt7986_redmi_ax6000-fip-fixed-parts-multi-layout.bin` |
| 锐捷 RG-X60 Pro | MT7986 | DDR3 | `mt7986_ruijie_rg-x60-pro-fip-fixed-parts.bin` |
| TP-Link XDR608X | MT7986 | DDR3 | `mt7986_tplink_tl-xdr608x-fip-fixed-parts.bin` |

---

## 🧰 工具清单

```
mt798X/
├── MT798XTTL/
│   └── MT798XTTL/
│       ├── fip/                          # FIP固件目录
│       │   ├── mt7981_*.bin              # MT7981平台FIP文件
│       │   └── mt7986_*.bin              # MT7986平台FIP文件
│       ├── mtk_uartboot/                 # MTK串口引导工具
│       │   ├── mtk_uartboot.exe          # Windows版本
│       │   ├── mtk_uartboot              # Linux版本
│       │   ├── mt7981/                   # MT7981 BL2文件
│       │   │   ├── mt7981-ddr3-bl2.bin
│       │   │   └── mt7981-ddr4-bl2.bin
│       │   ├── mt7986/                   # MT7986 BL2文件
│       │   │   ├── mt7986-ddr3-bl2.bin
│       │   │   └── mt7986-ddr4-bl2.bin
│       │   └── mt7622/                   # MT7622 BL2文件
│       │       ├── mt7622-ddr3-bl2.bin
│       │       └── mt7622-2ddr3-bl2.bin
│       ├── MT798X串口TTL救砖命令.bat      # 一键救砖脚本
│       ├── 打开设备管理器命令.bat          # 快捷打开设备管理器
│       ├── RAX3000M TTL接线顺序.jpg       # RAX3000M接线参考
│       └── XR30 TTL接线顺序.jpg           # XR30接线参考
├── Tftpd64_3421/                         # TFTP服务器工具
│   ├── tftpd64.exe                       # 主程序
│   └── tftpd64 V3.51汉化版/              # 汉化版本
├── SecureCRT.exe                         # 串口终端工具
└── WinHex v20.0 x86_x64.exe              # 十六进制编辑器
```

### 工具说明

| 工具 | 用途 |
|:-----|:-----|
| **mtk_uartboot** | MediaTek 官方串口引导工具，用于在 BootROM 阶段加载固件 |
| **Tftpd64** | TFTP 服务器，用于 U-Boot 阶段传输固件文件 |
| **SecureCRT** | 专业串口终端软件，支持多种协议 |
| **WinHex** | 十六进制编辑器，用于查看和编辑二进制文件 |

---

## 🚀 快速开始

### 准备工作

1. **硬件准备**
   - USB 转 TTL 串口线（推荐使用 **3.3V 电平**）
   - 目标路由器
   - Windows 电脑

2. **软件准备**
   - 安装 USB 转 TTL 驱动程序
   - 确认 COM 端口号

### 快速救砖步骤

```mermaid
graph LR
    A[断电连接TTL] --> B[运行救砖脚本]
    B --> C[选择设备型号]
    C --> D[选择波特率]
    D --> E[输入COM口]
    E --> F[路由器上电]
    F --> G[等待握手]
    G --> H[自动传输固件]
    H --> I[进入U-Boot]
    I --> J[恢复系统]
```

#### 步骤详解

**第一步：连接硬件**

1. 路由器断电
2. 使用 USB 转 TTL 连接路由器串口接口
3. 接线顺序（以常见型号为例）：
   - **XR30**: `GND → GND`, `TX → RX`, `RX → TX`
   - **RAX3000M**: 参考图片 `RAX3000M TTL接线顺序.jpg`

**第二步：查看 COM 口**

双击运行 `打开设备管理器命令.bat`，在设备管理器中查看 USB 转 TTL 对应的 COM 端口号。

> ⚠️ **注意**：确保 COM 口没有被其他程序占用

**第三步：运行救砖脚本**

双击运行 `MT798X串口TTL救砖命令.bat`，按照提示操作：

```
请选择对应的fip列表：
1. mt7981_360t7-fip-fixed-parts.bin
2. mt7981_abt_asr3000-fip-fixed-parts.bin
...
```

**第四步：选择参数**

1. 输入对应设备的 fip 序号
2. 选择波特率：
   - **选项1（推荐）**：高波特率（BROM: 921600, BL2: 1500000）
   - **选项2**：低波特率（BROM: 115200, BL2: 115200）
3. 输入 COM 端口号

**第五步：启动路由器**

脚本会显示 `Handshake...` 等待信息，此时给路由器上电。

---

## 📚 详细使用教程

### 救砖过程详解

#### 1. 握手阶段

```
mtk_uartboot - 0.1.1
Using serial port: COM3
Handshake...
```

此时给路由器上电，成功握手后会显示：

```
hw code: 0x7986
hw sub code: 0x8a00
hw ver: 0xca01
sw ver: 0x1
Baud rate set to 115200
sending payload to 0x201000...
```

#### 2. 发送 BL2

BL2（Second Stage Boot Loader）会被加载到 RAM 中执行：

```
Checksum: 0x3c82
Setting baudrate back to 115200
Jumping to 0x201000 in aarch64...
Waiting for BL2. Message below:
==================================
NOTICE:  BL2: v2.10.0   (release):v2.4-rc0-5845-gbacca82a8-dirty
NOTICE:  BL2: Built : 20:30:05, Feb  2 2024
NOTICE:  WDT: Cold boot
NOTICE:  WDT: disabled
NOTICE:  CPU: MT7986 (2000MHz)
NOTICE:  EMI: Using DDR4 settings
NOTICE:  EMI: Detected DRAM size: 1024MB
NOTICE:  EMI: complex R/W mem test passed
NOTICE:  Starting UART download handshake ...
==================================
BL2 UART DL version: 0x10
Baudrate set to: 115200
```

#### 3. 发送 FIP

FIP 固件开始传输：

- **高波特率（1500000）**：约 3-5 秒完成
- **低波特率（115200）**：约 45 秒完成

> 💡 **提示**：在此阶段按住 **Reset 键** 可直接进入 U-Boot WebUI 恢复界面

#### 4. 加载完成

```
FIP sent.
==================================
NOTICE:  Received FIP 0x90b59 @ 0x40400000 ...
==================================
```

此时：
- **按住 Reset**：进入 U-Boot WebUI 恢复界面
- **不按 Reset**：直接启动已安装的固件

### 手动命令方式

如需手动操作，可使用以下命令格式：

```bash
.\mtk_uartboot\mtk_uartboot.exe -s COM<端口号> -p <BL2文件路径> -a -f <FIP文件路径> --brom-load-baudrate <波特率> --bl2-load-baudrate <波特率>
```

**示例**：

```bash
# MT7986 DDR4 设备，使用高波特率
.\mtk_uartboot\mtk_uartboot.exe -s COM3 -p .\mtk_uartboot\mt7986\mt7986-ddr4-bl2.bin -a -f .\fip\mt7986_redmi_ax6000-fip-fixed-parts-multi-layout.bin --brom-load-baudrate 921600 --bl2-load-baudrate 1500000

# MT7981 DDR3 设备，使用低波特率
.\mtk_uartboot\mtk_uartboot.exe -s COM3 -p .\mtk_uartboot\mt7981\mt7981-ddr3-bl2.bin -a -f .\fip\mt7981_h3c_magic-nx30-pro-fip-fixed-parts.bin --brom-load-baudrate 115200 --bl2-load-baudrate 115200
```

---

## ❓ 常见问题

### Q1: 握手失败怎么办？

**可能原因及解决方案**：

| 原因 | 解决方案 |
|:-----|:---------|
| TTL 接线错误 | 检查 TX/RX 是否接反，确认 GND 连接正确 |
| COM 口被占用 | 关闭其他串口工具，重新插拔 USB |
| 波特率不匹配 | 尝试使用低波特率选项 |
| 电平不兼容 | 确保使用 3.3V 电平的 TTL 工具 |

### Q2: 如何判断 DDR 类型？

脚本会自动识别，规则如下：

- **DDR4 设备**：RAX3000M、XR30、京东云百里、GL-MT6000、红米 AX6000
- **DDR3 设备**：其他型号默认为 DDR3

### Q3: eMMC 设备有什么特殊要求？

- eMMC 机型的 U-Boot BL2 上传限制为 **1MB**
- 京东云百里需要刷写解锁 Secure Boot 的 BL2

### Q4: 救砖后如何恢复原厂固件？

1. 进入 U-Boot WebUI（按住 Reset）
2. 使用 TFTP 或 WebUI 上传原厂固件
3. 刷写完成后重启

---

## ⚠️ 注意事项

### 重要警告

> ⚠️ **BL2 文件说明**
> 
> `mtk_uartboot` 文件夹中的 BL2 是 **RAM Boot BL2**，仅用于串口引导，不能直接刷写到闪存！

> ⚠️ **Secure Boot 设备**
> 
> 京东云百里等设备需要刷写解锁 Secure Boot 的 BL2，请使用原厂 BL2 进行恢复。

> ⚠️ **NMBM 支持**
> 
> 部分仓库编译的 XDR4288/608X 的 BL2 和 FIP 未开启 NMBM，恢复时请根据实际情况选择。

### 安全提示

1. **电平选择**：务必使用 **3.3V** 电平的 TTL 工具，5V 可能损坏路由器
2. **防静电**：操作前释放静电，避免损坏芯片
3. **电源稳定**：确保路由器供电稳定，避免断电导致更严重问题
4. **备份原厂**：如有条件，先备份原厂固件

---

## 🙏 致谢

- **mtk_uartboot** - MediaTek 串口引导工具
- **OpenWrt / ImmortalWrt** - 开源路由器固件
- **暗云博客** - 救砖教程参考

---

## 📜 免责声明

本工具包仅供学习和研究使用。使用本工具造成的任何设备损坏、数据丢失等问题，作者不承担任何责任。请确保您了解操作风险后再进行相关操作。

---

<div align="center">

**Made with ❤️ for MediaTek Router Community**

</div>
