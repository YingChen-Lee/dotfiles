#!/bin/bash

set -u

# 获取进程列表，去掉第一行
PSAUX=$(ps aux | awk '{ if (NR != 1) print $0 }')

# Linux下ps -ef和ps aux的区别及格式详解
# https://www.cnblogs.com/5201351/p/4206461.html
# 显示的字段
# USER      //用户名
# %CPU      //进程占用的CPU百分比
# %MEM      //占用内存的百分比
# VSZ       //该进程使用的虚拟內存量（KB）
# RSS       //该进程占用的固定內存量（KB）（驻留中页的数量）
# STAT      //进程的状态
    # D      //无法中断的休眠状态（通常 IO 的进程）
    # R      //正在运行可中在队列中可过行的
    # S      //处于休眠状态
    # T      //停止或被追踪
    # W      //进入内存交换 （从内核2.6开始无效）
    # X      //死掉的进程 （基本很少见）
    # Z      //僵尸进程
    # <      //优先级高的进程
    # N      //优先级较低的进程
    # L      //有些页被锁进内存
    # s      //进程的领导者（在它之下有子进程）
    # l      //多线程，克隆线程（使用 CLONE_THREAD, 类似 NPTL pthreads）
    # +      //位于后台的进程组
# START     //该进程被触发启动时间
# TIME      //该进程实际使用CPU运行的时间
FIELD_TITLE=('USER：%s\n'
    'PID：%s\n'
    '%%CPU：%s\n'
    '%%MEM：%s\n'
    'VSZ (kb)：%s\n'
    'RSS（kb）：%s\n'
    'TTY：%s\n'
    'STAT：%s\n'
    '    STAT DETAIL：%s\n'
    'TIME STARTED：%s\n'
    'CPU TIME：%s\n'
    'COMMAND：%s')


FIELD_FORMAT=''
for A_FIELD_FMT in "${FIELD_TITLE[@]}"; do
    FIELD_FORMAT="${FIELD_FORMAT}${A_FIELD_FMT}"
done


# awk 使用
# awk 入门教程 http://www.ruanyifeng.com/blog/2018/11/awk.html
# AWK 简明教程 https://coolshell.cn/articles/9070.html
# 提取预览信息
PROGRAM='{ cmdline=""; '
PROGRAM="${PROGRAM}"'statDetail=""; '
PROGRAM="${PROGRAM}"'for (i = 1; i <= length($8); i++) { '
PROGRAM="${PROGRAM}"'    tmp = substr($8, i, 1); '
PROGRAM="${PROGRAM}"'    if (tmp == "D") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "Uninterrupted sleep (usually IO)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "R") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "Running or runnable (on run queue)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "S") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "Interruptible sleep (waitng for an event to complete)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "T") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "Stopped, either by a job control signal or because it is being traced"); '
PROGRAM="${PROGRAM}"'    if (tmp == "W") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "paging (not valid since the 2.6.xx kernel)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "X") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "dead (should never be seen)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "Z") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "Defunct ("zombie") process, terminated but not reaped by its parent"); '
PROGRAM="${PROGRAM}"'    if (tmp == "<") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "high-priority"); '
PROGRAM="${PROGRAM}"'    if (tmp == "N") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "low-priority"); '
PROGRAM="${PROGRAM}"'    if (tmp == "L") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "has pages locked into memory (for real-time and custom IO)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "s") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "is a session leader"); '
PROGRAM="${PROGRAM}"'    if (tmp == "l") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "is multi-threaded (using CLONE_TRHEAD, like NPTL pthreads do)"); '
PROGRAM="${PROGRAM}"'    if (tmp == "+") statDetail = sprintf("    %s\n      %s ... %s", statDetail, tmp, "is in the foregorund process group"); '
PROGRAM="${PROGRAM}"'    for (j = 0; j < 8; j++) tmp = sprintf("%s%s", tmp, substr($8, i, 1)); '
PROGRAM="${PROGRAM}"'}'
PROGRAM="${PROGRAM}"'for (i = 11; i <= NF; i++) cmdline=sprintf("%s %s", cmdline, $i);'
PROGRAM="${PROGRAM}"'printf("'
PROGRAM="${PROGRAM}""${FIELD_FORMAT}"'", $1, $2, $3, $4, $5, $6, $7, $8, statDetail, $9, $10, cmdline) }'


# echo "${PROGRAM}"

# 用于提取预览信息的命令
preview_cmd='echo {} | awk '"'${PROGRAM}'"

# echo
# echo "${preview_cmd}"

# 选择的进程
SELECTED_PS=$(echo "$PSAUX" | fzf -e -m \
                    --tmux 80%,80% \
                    --header='Process List' \
                    --bind 'ctrl-a:select-all' \
                    --with-nth='1,2,11..' \
                    --border \
                    --preview "${preview_cmd}")

# 提取选中进程的 PID
SELECTED_PS_IDS=$(echo -e "${SELECTED_PS}" | awk '{print $2}')


# 杀掉选中进程
if [[ -n ${SELECTED_PS_IDS} ]]; then
    kill $@ ${SELECTED_PS_IDS}
fi
