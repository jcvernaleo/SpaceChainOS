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
** ��   ��   ��: ThreadGetStackMini.c
**
** ��   ��   ��: Han.Hui (����)
**
** �ļ���������: 2007 �� 01 �� 02 ��
**
** ��        ��: �߳�����ջ��С��С
*********************************************************************************************************/
#define  __SYLIXOS_KERNEL
#include "../SylixOS/kernel/include/k_kernel.h"
/*********************************************************************************************************
** ��������: API_ThreadGetStackMini
** ��������: �߳�����ջ��С��С
** �䡡��  : NONE
** �䡡��  : ��С��ջ��С
** ȫ�ֱ���: 
** ����ģ��: 
                                           API ����
*********************************************************************************************************/
LW_API  
ULONG  API_ThreadGetStackMini (VOID)
{
    return  (__STK_MINMUM_BYTE_SIZE);
}
/*********************************************************************************************************
  END
*********************************************************************************************************/