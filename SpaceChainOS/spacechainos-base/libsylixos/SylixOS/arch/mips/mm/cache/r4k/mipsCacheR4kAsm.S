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
;** ��   ��   ��: mipsCacheR4kAsm.S
;**
;** ��   ��   ��: Jiao.JinXing (������)
;**
;** �ļ���������: 2015 �� 12 �� 01 ��
;**
;** ��        ��: MIPS R4K ��ϵ���� CACHE ����.
;*********************************************************************************************************/

#ifndef ASSEMBLY
#define ASSEMBLY 1
#endif

#include <arch/assembler.h>
#include <config/kernel/cache_cfg.h>
#include <config/cpu/cpu_cfg_mips.h>

#if LW_CFG_CACHE_EN > 0

    EXPORT_LABEL(mipsCacheR4kDisableHw)
    EXPORT_LABEL(mipsCacheR4kEnableHw)

    EXPORT_LABEL(mipsDCacheR4kLineFlush)
    EXPORT_LABEL(mipsDCacheR4kLineClear)
    EXPORT_LABEL(mipsDCacheR4kLineInvalidate)
    EXPORT_LABEL(mipsDCacheR4kIndexClear)
    EXPORT_LABEL(mipsDCacheR4kIndexStoreTag)

    EXPORT_LABEL(mipsICacheR4kLineInvalidate)
    EXPORT_LABEL(mipsICacheR4kIndexInvalidate)
    EXPORT_LABEL(mipsICacheR4kFill)
    EXPORT_LABEL(mipsICacheR4kIndexStoreTag)

    EXPORT_LABEL(mipsBranchPredictionDisable)
    EXPORT_LABEL(mipsBranchPredictionEnable)
    EXPORT_LABEL(mipsBranchPredictorInvalidate)

    IMPORT_LABEL(mipsICacheR4kInvalidateAll)
    IMPORT_LABEL(mipsDCacheR4kClearAll)
#if LW_CFG_MIPS_CACHE_L2 > 0
    IMPORT_LABEL(mipsL2R4kClearAll)
#endif

    WEAK(mipsBranchPredictionDisable)
    WEAK(mipsBranchPredictionEnable)
    WEAK(mipsBranchPredictorInvalidate)

    FILE_BEGIN()

;/*********************************************************************************************************
;  ���� CACHE
;*********************************************************************************************************/

FUNC_DEF(mipsCacheR4kDisableHw)
    .set    push
    .set    noreorder
    .set    volatile

    MFC0(T0, CP0_CONFIG)
    ANDI    T0 , T0 , M_ConfigK0
    LI      T1 , MIPS_UNCACHED
    BEQ     T0 , T1 , 1f
    NOP

    SUBU    SP , 32
    SW      RA , 28(SP)
    SW      FP , 24(SP)
    MOV     FP , SP

    JAL     mipsDCacheR4kClearAll
    NOP

    JAL     mipsICacheR4kInvalidateAll
    NOP

#if LW_CFG_MIPS_CACHE_L2 > 0
    JAL     mipsL2R4kClearAll
    NOP
#endif

    MOV     SP , FP
    LW      RA , 28(SP)
    LW      FP , 24(SP)
    ADDU    SP , 32

    MFC0(T0, CP0_CONFIG)
    AND     T0 , T0 , ~M_ConfigK0
    ORI     T0 , T0 , MIPS_UNCACHED
    MTC0(T0, CP0_CONFIG)

1:
    JR      RA
    NOP

    .set    pop
    FUNC_END(mipsCacheR4kDisableHw)

;/*********************************************************************************************************
;  ʹ�� CACHE
;*********************************************************************************************************/

FUNC_DEF(mipsCacheR4kEnableHw)
    .set    push
    .set    noreorder
    .set    volatile

    MFC0(T0, CP0_CONFIG)
    ANDI    T0 , T0 , M_ConfigK0
    LI      T1 , MIPS_CACHABLE_NONCOHERENT
    BEQ     T0 , T1 , 1f
    NOP

    MFC0(T0, CP0_CONFIG)
    AND     T0 , T0 , ~M_ConfigK0
    ORI     T0 , MIPS_CACHABLE_NONCOHERENT
    MTC0(T0, CP0_CONFIG)

1:
    JR      RA
    NOP

    .set    pop
    FUNC_END(mipsCacheR4kEnableHw)

;/*********************************************************************************************************
;  CACHE ������
;*********************************************************************************************************/

MACRO_DEF(CACHE_OP op addr)
    .set    push
    .set    noat
    .set    noreorder
    .set    volatile
    .set    mips32

    cache   \op , 0(\addr)

    JR      RA
    NOP

    .set    pop
    MACRO_END()

;/*********************************************************************************************************
;  ��дһ�� DCACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsDCacheR4kLineFlush)
    CACHE_OP    Hit_Writeback_D         A0
    FUNC_END(mipsDCacheR4kLineFlush)

;/*********************************************************************************************************
;  ��д����Чһ�� DCACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsDCacheR4kLineClear)
    CACHE_OP    Hit_Writeback_Inv_D     A0
    FUNC_END(mipsDCacheR4kLineClear)

;/*********************************************************************************************************
;  ��Чһ�� DCACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsDCacheR4kLineInvalidate)
    CACHE_OP    Hit_Invalidate_D        A0
    FUNC_END(mipsDCacheR4kLineInvalidate)

;/*********************************************************************************************************
;  ͨ�� Cache �洢���ĵ�ַ������д����Чһ�� DCACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsDCacheR4kIndexClear)
    CACHE_OP    Index_Writeback_Inv_D   A0
    FUNC_END(mipsDCacheR4kIndexClear)

;/*********************************************************************************************************
;  ��Чһ�� ICACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsICacheR4kLineInvalidate)
    CACHE_OP    Hit_Invalidate_I        A0
    FUNC_END(mipsICacheR4kLineInvalidate)

;/*********************************************************************************************************
;  ͨ�� CACHE �洢���ĵ�ַ������д����Чһ�� ICACHE ��
;*********************************************************************************************************/

FUNC_DEF(mipsICacheR4kIndexInvalidate)
    CACHE_OP    Index_Invalidate_I      A0
    FUNC_END(mipsICacheR4kIndexInvalidate)

;/*********************************************************************************************************
;  FILL ICACHE
;*********************************************************************************************************/

FUNC_DEF(mipsICacheR4kFill)
    CACHE_OP    Fill_I                  A0
    FUNC_END(mipsICacheR4kFill)

;/*********************************************************************************************************
;  ���� DCACHE �� TAG
;*********************************************************************************************************/

FUNC_DEF(mipsDCacheR4kIndexStoreTag)
    CACHE_OP    Index_Store_Tag_D       A0
    FUNC_END(mipsDCacheR4kIndexStoreTag)

;/*********************************************************************************************************
;  ���� ICACHE �� TAG
;*********************************************************************************************************/

FUNC_DEF(mipsICacheR4kIndexStoreTag)
    CACHE_OP    Index_Store_Tag_I       A0
    FUNC_END(mipsICacheR4kIndexStoreTag)

;/*********************************************************************************************************
;  ���ܷ�֧Ԥ��
;*********************************************************************************************************/

FUNC_DEF(mipsBranchPredictionDisable)
    JR      RA
    NOP
    FUNC_END(mipsBranchPredictionDisable)

;/*********************************************************************************************************
;  ʹ�ܷ�֧Ԥ��
;*********************************************************************************************************/

FUNC_DEF(mipsBranchPredictionEnable)
    JR      RA
    NOP
    FUNC_END(mipsBranchPredictionEnable)

;/*********************************************************************************************************
;  ��Ч��֧Ԥ��
;*********************************************************************************************************/

FUNC_DEF(mipsBranchPredictorInvalidate)
    JR      RA
    NOP
    FUNC_END(mipsBranchPredictorInvalidate)

    FILE_END()

#endif
;/*********************************************************************************************************
;  END
;*********************************************************************************************************/