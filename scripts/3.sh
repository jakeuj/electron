#!/bin/bash

# 定義 Miniconda 安裝目錄
MINICONDA_DIR="/opt/miniconda3"
MINICONDA_FILE="Miniconda3-latest-Linux-x86_64.sh"
LLaMA_Factory="LLaMA-Factory"

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $SCRIPT_DIR

# 檢查 Miniconda 是否已安裝
if [ -d "$MINICONDA_DIR" ]; then
    echo "Miniconda is installed $MINICONDA_DIR"
else
    echo "Miniconda not found! Installing..."

    # 下載必要文件
    if [ ! -f "$SCRIPT_DIR/$MINICONDA_FILE" ]; then
        wget https://repo.anaconda.com/miniconda/$MINICONDA_FILE -O /tmp/$MINICONDA_FILE
    else
        echo "$MINICONDA_FILE is existed"
    fi

    # 使安裝腳本可執行
    chmod +x /tmp/$MINICONDA_FILE

    # 執行安裝腳本
    sudo bash /tmp/$MINICONDA_FILE -b -p $MINICONDA_DIR

    # 添加 Miniconda 到當前會話的 PATH
    export PATH="$MINICONDA_DIR/bin:$PATH"

    # 讓 conda 初始化
    source $MINICONDA_DIR/bin/activate
    conda init

    echo "Miniconda is installed and already in PATH。"
    echo "Please run 'source ~/.bashrc' to update your PATH."
fi

echo "Finish."
exit 0
