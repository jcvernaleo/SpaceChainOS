;/*********************************************************************************************************
;**
;**                                    �й�������Դ��֯
;**
;**                                   Ƕ��ʽʵʱ����ϵͳ
;**
;**                                       SylixOS(TM)
;**
;**                               Copyright  All Rights Reserved
;**
;**--------------�ļ���Ϣ--------------------------------------------------------------------------------
;**
;** ��   ��   ��: ppcL2Cache745xAsm.s
;**
;** ��   ��   ��: Jiao.JinXing (������)
;**
;** �ļ���������: 2017 �� 09 �� 01 ��
;**
;** ��        ��: MPC745x ��ϵ���� L2 CACHE ����.
;*********************************************************************************************************/

#ifndef ASSEMBLY
#define ASSEMBLY 1
#endif

#include <arch/assembler.h>
#include <config/kernel/cache_cfg.h>

#if LW_CFG_CACHE_EN > 0 && LW_CFG_PPC_CACHE_L2 > 0

#define __SYLIXOS_PPC745X__

/*********************************************************************************************************
  ���¶���ӿ���
*********************************************************************************************************/

#define ppc750L2CacheSetCR              ppc745xL2CacheSetCR
#define ppc750L2CacheGetCR              ppc745xL2CacheGetCR

#define ppc750L2CacheInit               ppc745xL2CacheInit

#define ppc750L2CacheEnable             ppc745xL2CacheEnable
#define ppc750L2CacheDisable            ppc745xL2CacheDisable
#define ppc750L2CacheIsEnable           ppc745xL2CacheIsEnable

#define ppc750L2CacheInvalidateAll      ppc745xL2CacheInvalidateAll

#define ppc750L2CacheFlushAllSW         ppc745xL2CacheFlushAllSW
#define ppc750L2CacheFlushAllHW         ppc745xL2CacheFlushAllHW
#define ppc750L2CacheSetWriteThrough    ppc745xL2CacheSetWriteThrough

/*********************************************************************************************************
  ���� 750 L2 CACHE ����
*********************************************************************************************************/

#include "ppcL2Cache750Asm.S"

    FILE_END()

#endif
;/*********************************************************************************************************
;  END
;*********************************************************************************************************/