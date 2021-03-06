/*********************************************************************************************************
**
**                                    中国软件开源组织
**
**                                   嵌入式实时操作系统
**
**                                       SylixOS(TM)
**
**                               Copyright  All Rights Reserved
**
**--------------文件信息--------------------------------------------------------------------------------
**
** 文   件   名: sparcBacktrace.h
**
** 创   建   人: Xu.Guizhou (徐贵洲)
**
** 文件创建日期: 2017 年 05 月 15 日
**
** 描        述: SPARC 体系构架堆栈回溯.
*********************************************************************************************************/

#ifndef __ARCH_SPARC_BACKTRACE_H
#define __ARCH_SPARC_BACKTRACE_H

#include "sys/cdefs.h"

/*********************************************************************************************************
  SPARC 栈帧结构
*********************************************************************************************************/

struct layout {
    unsigned long   locals[8];
    unsigned long   ins[6];
    unsigned long   next;
    void           *return_address;
};

#endif                                                                  /*  __ARCH_SPARC_BACKTRACE_H    */
/*********************************************************************************************************
  END
*********************************************************************************************************/
