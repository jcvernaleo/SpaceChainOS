/*********************************************************************************************************
**
**                                    中国软件开源组织
**
**                                   嵌入式实时操作系统
**
**                                SylixOS(TM)  LW : long wing
**
**                               Copyright All Rights Reserved
**
**--------------文件信息--------------------------------------------------------------------------------
**
** 文   件   名: lib_strcspn.c
**
** 创   建   人: Han.Hui (韩辉)
**
** 文件创建日期: 2007 年 02 月 13 日
**
** 描        述: 库
*********************************************************************************************************/
#include "../SylixOS/kernel/include/k_kernel.h"
/*********************************************************************************************************
** 函数名称: lib_strcspn
** 功能描述: 
** 输　入  : 
** 输　出  : 
** 全局变量: 
** 调用模块: 
*********************************************************************************************************/
size_t  lib_strcspn (CPCHAR  cpcS1, CPCHAR  cpcS2)
{
    /*
     *  Copyright (c) 1990 The Regents of the University of California.
     */

    const char *p, *spanp;
    char        c, sc;

    for (p = cpcS1;;) {
        c = *p++;
        spanp = cpcS2;
        do {
            if ((sc = *spanp++) == c) {
                return (p - 1 - cpcS1);
            }
        } while (sc != 0);
    }
}
/*********************************************************************************************************
  END
*********************************************************************************************************/
