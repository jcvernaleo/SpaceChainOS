/*********************************************************************************************************
**
**                                    �й�������Դ��֯
**
**                                   Ƕ��ʽʵʱ����ϵͳ
**
**                                SylixOS(TM)  LW : long wing
**
**                               Copyright All Rights Reserved
**
**--------------�ļ���Ϣ--------------------------------------------------------------------------------
**
** ��   ��   ��: cpu_cfg_c6x.h
**
** ��   ��   ��: Jiao.JinXing (������)
**
** �ļ���������: 2017 �� 02 �� 28 ��
**
** ��        ��: TI C6X DSP �����빦������.
*********************************************************************************************************/

#ifndef __CPU_CFG_C6X_H
#define __CPU_CFG_C6X_H

/*********************************************************************************************************
  CPU ��ϵ�ṹ
*********************************************************************************************************/

#define LW_CFG_CPU_ARCH_C6X             1                               /*  CPU �ܹ�                    */
#define LW_CFG_CPU_ARCH_FAMILY          "TI C6000(R)"                   /*  TI C6000 family             */

/*********************************************************************************************************
  CPU �ֳ������ʹ�С�˶���
*********************************************************************************************************/

#define LW_CFG_CPU_ENDIAN               0                               /*  0: С��  1: ���            */
#define LW_CFG_CPU_WORD_LENGHT          32                              /*  CPU �ֳ�                    */

/*********************************************************************************************************
  C6X ����
*********************************************************************************************************/

#define LW_CFG_C6X_CACHE_L2             1                               /*  �Ƿ��������� C6X ���� CACHE */

/*********************************************************************************************************
  �������㵥Ԫ (TI ���� DSP ����Ҫ��һ�㴦����һ���л�����ĸ���������, ����Ĵ����Ѿ���������ͨ��������)
*********************************************************************************************************/

#define LW_CFG_CPU_FPU_EN               0                               /*  CPU �Ƿ�ӵ�� FPU            */

#endif                                                                  /*  __CPU_CFG_C6X_H             */
/*********************************************************************************************************
  END
*********************************************************************************************************/