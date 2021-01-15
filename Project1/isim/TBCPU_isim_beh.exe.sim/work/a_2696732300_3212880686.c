/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Keithan/Documents/School/COE758/Project1Final/Project1/SDRAMController.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);


static void work_a_2696732300_3212880686_p_0(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    unsigned char t4;
    char *t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(54, ng0);
    t3 = (t0 + 992U);
    t4 = xsi_signal_has_event(t3);
    if (t4 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t3 = (t0 + 3472);
    *((int *)t3) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t5 = (t0 + 1352U);
    t12 = *((char **)t5);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB11;

LAB13:    t3 = (t0 + 1352U);
    t5 = *((char **)t3);
    t1 = *((unsigned char *)t5);
    t2 = (t1 == (unsigned char)2);
    if (t2 != 0)
        goto LAB14;

LAB15:
LAB12:    goto LAB3;

LAB5:    t5 = (t0 + 1512U);
    t9 = *((char **)t5);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    t1 = t11;
    goto LAB7;

LAB8:    t5 = (t0 + 1032U);
    t6 = *((char **)t5);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t2 = t8;
    goto LAB10;

LAB11:    xsi_set_current_line(56, ng0);
    t5 = (t0 + 1672U);
    t15 = *((char **)t5);
    t5 = (t0 + 1192U);
    t16 = *((char **)t5);
    t5 = (t0 + 6180U);
    t17 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t16, t5);
    t18 = (t17 - 0);
    t19 = (t18 * 1);
    t20 = (8U * t19);
    t21 = (0U + t20);
    t22 = (t0 + 3552);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t15, 8U);
    xsi_driver_first_trans_delta(t22, t21, 8U, 0LL);
    goto LAB12;

LAB14:    xsi_set_current_line(58, ng0);
    t3 = (t0 + 1992U);
    t6 = *((char **)t3);
    t3 = (t0 + 1192U);
    t9 = *((char **)t3);
    t3 = (t0 + 6180U);
    t17 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t9, t3);
    t18 = (t17 - 0);
    t19 = (t18 * 1);
    xsi_vhdl_check_range_of_index(0, 65535, 1, t17);
    t20 = (8U * t19);
    t21 = (0 + t20);
    t12 = (t6 + t21);
    t15 = (t0 + 3616);
    t16 = (t15 + 56U);
    t22 = *((char **)t16);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t12, 8U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB12;

}


extern void work_a_2696732300_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2696732300_3212880686_p_0};
	xsi_register_didat("work_a_2696732300_3212880686", "isim/TBCPU_isim_beh.exe.sim/work/a_2696732300_3212880686.didat");
	xsi_register_executes(pe);
}
