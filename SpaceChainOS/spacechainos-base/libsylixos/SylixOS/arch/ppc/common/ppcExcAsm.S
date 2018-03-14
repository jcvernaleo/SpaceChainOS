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
;** ��   ��   ��: ppcExcAsm.S
;**
;** ��   ��   ��: Jiao.JinXing (������)
;**
;** �ļ���������: 2015 �� 12 �� 15 ��
;**
;** ��        ��: PowerPC ��ϵ�����쳣����.
;*********************************************************************************************************/

#ifndef ASSEMBLY
#define ASSEMBLY 1
#endif

#include <arch/assembler.h>
#include "ppcContextAsm.h"

    FILE_BEGIN()
    
    IMPORT_LABEL(API_ThreadTcbInter)
    IMPORT_LABEL(API_InterStackBaseGet)
    IMPORT_LABEL(API_InterEnter)
    IMPORT_LABEL(API_InterExit)
    
    IMPORT_LABEL(archMachineCheckExceptionHandle)
    IMPORT_LABEL(archDataStorageExceptionHandle)
    IMPORT_LABEL(archInstructionStorageExceptionHandle)
    IMPORT_LABEL(bspIntHandle)
    IMPORT_LABEL(archAlignmentExceptionHandle)
    IMPORT_LABEL(archProgramExceptionHandle)
    IMPORT_LABEL(archFpuUnavailableExceptionHandle)
    IMPORT_LABEL(archDecrementerInterruptHandle)
    IMPORT_LABEL(archSystemCallHandle)
    IMPORT_LABEL(archTraceHandle)
    IMPORT_LABEL(archFpAssistExceptionHandle)
    
    EXPORT_LABEL(archMachineCheckExceptionEntry)
    EXPORT_LABEL(archDataStorageExceptionEntry)
    EXPORT_LABEL(archInstructionStorageExceptionEntry)
    EXPORT_LABEL(archExternalInterruptEntry)
    EXPORT_LABEL(archAlignmentExceptionEntry)
    EXPORT_LABEL(archProgramExceptionEntry)
    EXPORT_LABEL(archFpuUnavailableExceptionEntry)
    EXPORT_LABEL(archDecrementerInterruptEntry)
    EXPORT_LABEL(archSystemCallEntry)
    EXPORT_LABEL(archTraceEntry)
    EXPORT_LABEL(archFpAssistExceptionEntry)
    
;/*********************************************************************************************************
;  �쳣��ں�
;*********************************************************************************************************/

MACRO_DEF(EXC_ENTRY, handle)
    EXC_SAVE_REGS                                                       ;/*  ���мĴ�����ջ              */

    ;/*
    ; *  if (API_InterEnter() == 1) {
    ; *      current stack = SP;
    ; *      SP = interrupt stack;
    ; *  }
    ; */
    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */
    BL      API_InterEnter                                              ;/*  ��ȡ�жϲ����ŵ�����ֵ V0   */

    CMPWI   CR0, R3 , 1
    BNE     CR0, 1f

    BL      API_ThreadTcbInter                                          ;/*  get current tcb             */
    ADDI    SP , SP , 16
    STW     SP , 0(R3)                                                  ;/*  current stack = SP          */
    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */

    BL      API_InterStackBaseGet                                       ;/*  ��õ�ǰ CPU �ж϶�ջջ��   */
    OR      SP , R3 , R3
    SUBI    SP , SP , 16                                                ;/*  ���� C ����ջ֡             */

1:
    MFSPR   R3 , SRR0                                                   ;/*  ���ݷ��ص�ַ                */
    ISYNC
    BL      \handle                                                     ;/*  ���ô�������                */

    BL      API_InterExit
    ADDI    SP , SP , 16

    RESTORE_REGS                                                        ;/*  ���мĴ�����ջ              */
    MACRO_END()

;/*********************************************************************************************************
;  ��������쳣���(Vector 0x200)
;*********************************************************************************************************/

FUNC_DEF(archMachineCheckExceptionEntry)
    EXC_ENTRY   archMachineCheckExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  ���ݴ洢�쳣���(Vector 0x300)
;*********************************************************************************************************/

FUNC_DEF(archDataStorageExceptionEntry)
    EXC_ENTRY   archDataStorageExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  ָ������쳣���(Vector 0x400)
;*********************************************************************************************************/

FUNC_DEF(archInstructionStorageExceptionEntry)
    EXC_ENTRY   archInstructionStorageExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  �ⲿ�ж����(Vector 0x500)
;*********************************************************************************************************/

FUNC_DEF(archExternalInterruptEntry)
    EXC_ENTRY   bspIntHandle
    FUNC_END()

;/*********************************************************************************************************
;  �Ƕ����쳣���(Vector 0x600)
;*********************************************************************************************************/

FUNC_DEF(archAlignmentExceptionEntry)
    EXC_ENTRY   archAlignmentExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  �����쳣���(Vector 0x700)
;*********************************************************************************************************/

FUNC_DEF(archProgramExceptionEntry)
    EXC_ENTRY   archProgramExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  FPU �������쳣���(Vector 0x800)
;*********************************************************************************************************/

FUNC_DEF(archFpuUnavailableExceptionEntry)
    EXC_ENTRY   archFpuUnavailableExceptionHandle
    FUNC_END()

;/*********************************************************************************************************
;  Decrementer �ж����(Vector 0x900)
;*********************************************************************************************************/

FUNC_DEF(archDecrementerInterruptEntry)
    EXC_ENTRY   archDecrementerInterruptHandle
    FUNC_END()

;/*********************************************************************************************************
;  ϵͳ�������(Vector 0xC00)
;*********************************************************************************************************/

FUNC_DEF(archSystemCallEntry)
    EXC_ENTRY   archSystemCallHandle
    FUNC_END()

;/*********************************************************************************************************
;  Trace ���(Vector 0xD00)
;*********************************************************************************************************/

FUNC_DEF(archTraceEntry)
    EXC_ENTRY   archTraceHandle
    FUNC_END()

;/*********************************************************************************************************
;  Floating-Point Assist �쳣���(Vector 0xE00)
;*********************************************************************************************************/

FUNC_DEF(archFpAssistExceptionEntry)
    EXC_ENTRY   archFpAssistExceptionHandle
    FUNC_END()

    FILE_END()

;/*********************************************************************************************************
;  END
;*********************************************************************************************************/