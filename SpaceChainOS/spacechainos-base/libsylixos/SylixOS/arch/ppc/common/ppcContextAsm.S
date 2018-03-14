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
;** ��   ��   ��: ppcContextAsm.S
;**
;** ��   ��   ��: Jiao.JinXing (������)
;**
;** �ļ���������: 2015 �� 12 �� 15 ��
;**
;** ��        ��: PowerPC ��ϵ�����������л�.
;*********************************************************************************************************/

#ifndef ASSEMBLY
#define ASSEMBLY 1
#endif

#include <arch/assembler.h>
#include <config/kernel/kernel_cfg.h>
#include <config/mp/mp_cfg.h>
#include "ppcContextAsm.h"

    FILE_BEGIN()

    IMPORT_LABEL(_SchedSwp)
#if LW_CFG_SMP_EN > 0
    IMPORT_LABEL(_SchedSafeStack)
#endif
#if LW_CFG_COROUTINE_EN > 0
    IMPORT_LABEL(_SchedCrSwp)
#endif
    
    EXPORT_LABEL(archTaskCtxStart)
    EXPORT_LABEL(archTaskCtxSwitch)
#if LW_CFG_COROUTINE_EN > 0
    EXPORT_LABEL(archCrtCtxSwitch)
#endif
    EXPORT_LABEL(archIntCtxLoad)
    EXPORT_LABEL(archSigCtxLoad)

;/*********************************************************************************************************
;  ��ǰ CPU ��ʼ���ж�����ִ��
;  ����Ϊ��ǰ CPU ���ƿ�, �� R3 Ϊ��ǰ CPU ���ƿ�ָ��
;*********************************************************************************************************/

FUNC_DEF(archTaskCtxStart)
    LWZ     R4 , 0(R3)                                                  ;/*  ��ȡ�������ջջ����ַ      */
    LWZ     SP , 0(R4)                                                  ;/*  ��ջָ�븳ֵ                */

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    FUNC_END()

;/*********************************************************************************************************
;  �߳��л� 
;  ����Ϊ��ǰ CPU ���ƿ�, �� R3 Ϊ��ǰ CPU ���ƿ�ָ��
;*********************************************************************************************************/

FUNC_DEF(archTaskCtxSwitch)
    SAVE_REGS                                                           ;/*  ���мĴ�����ջ              */

    LWZ     R4 , 0(R3)                                                  ;/*  stack current = SP          */
    STW     SP , 0(R4)

    OR      R14, R3 , R3                                                ;/*  ���浱ǰ CPU ��Ϣ           */

#if LW_CFG_SMP_EN > 0
    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */
    BL      _SchedSafeStack                                             ;/*  _SchedSafeStack();          */
    OR      SP , R3 , R3
    OR      R3 , R14, R14
#endif

    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */
    BL      _SchedSwp                                                   ;/*  _SchedSwp();                */
    OR      R3 , R14, R14

    LWZ     R4 , 0(R3)                                                  ;/*  SP = stack current          */
    LWZ     SP , 0(R4)

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    FUNC_END()

;/*********************************************************************************************************
;  Э���л� 
;  ����Ϊ��ǰ CPU ���ƿ�, �� R3 Ϊ��ǰ CPU ���ƿ�ָ��
;*********************************************************************************************************/

#if LW_CFG_COROUTINE_EN > 0
FUNC_DEF(archCrtCtxSwitch)
    SAVE_REGS                                                           ;/*  ���мĴ�����ջ              */

    LWZ     R4 , 8(R3)                                                  ;/*  stack current = SP          */
    STW     SP , 0(R4)

    OR      R14, R3 , R3                                                ;/*  ���浱ǰ CPU ��Ϣ           */
    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */
    BL      _SchedCrSwp                                                 ;/*  _SchedCrSwp();              */
    OR      R3 , R14, R14

    LWZ     R4 , 8(R3)                                                  ;/*  SP = stack current          */
    LWZ     SP , 0(R4)

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    FUNC_END()
#endif

;/*********************************************************************************************************
;  �жϷ���ʱ, �߳�װ�� 
;  ����Ϊ��ǰ CPU ���ƿ�, �� R3 Ϊ��ǰ CPU ���ƿ�ָ��
;*********************************************************************************************************/

FUNC_DEF(archIntCtxLoad)
    LWZ     R4 , 0(R3)                                                  ;/*  SP = stack current          */
    LWZ     SP , 0(R4)

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    FUNC_END()

;/*********************************************************************************************************
;  �ź������ķ���
;  ����Ϊ��Ҫ���صĶ�ջջ��λ��
;*********************************************************************************************************/

FUNC_DEF(archSigCtxLoad)
    OR      SP , R3 , R3                                                ;/*  ���صĶ�ջָ��              */

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    FUNC_END()

    FILE_END()

;/*********************************************************************************************************
;  END
;*********************************************************************************************************/