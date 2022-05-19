/*
 * q_joints.h
 *
 * Code generation for model "q_joints".
 *
 * Model version              : 1.218
 * Simulink Coder version : 8.6 (R2014a) 27-Dec-2013
 * C source code generated on : Tue Mar 01 11:49:39 2016
 *
 * Target selection: quarc_win64.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: 32-bit Generic
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */
#ifndef RTW_HEADER_q_joints_h_
#define RTW_HEADER_q_joints_h_
#include <math.h>
#include <float.h>
#include <string.h>
#ifndef q_joints_COMMON_INCLUDES_
# define q_joints_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "dt_info.h"
#include "ext_work.h"
#include "hil.h"
#include "quanser_messages.h"
#include "quanser_extern.h"
#endif                                 /* q_joints_COMMON_INCLUDES_ */

#include "q_joints_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_zcfcn.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetBlkStateChangeFlag
# define rtmGetBlkStateChangeFlag(rtm) ((rtm)->ModelData.blkStateChange)
#endif

#ifndef rtmSetBlkStateChangeFlag
# define rtmSetBlkStateChangeFlag(rtm, val) ((rtm)->ModelData.blkStateChange = (val))
#endif

#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->ModelData.contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->ModelData.contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->ModelData.contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->ModelData.contStates = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->ModelData.derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->ModelData.derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ((rtm)->ModelData.intgData)
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ((rtm)->ModelData.intgData = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ((rtm)->ModelData.odeF)
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ((rtm)->ModelData.odeF = (val))
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ((rtm)->ModelData.odeY)
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ((rtm)->ModelData.odeY = (val))
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->ModelData.zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->ModelData.zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->ModelData.derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->ModelData.derivs = (val))
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

/* Block signals (auto storage) */
typedef struct {
  real_T Clock;                        /* '<Root>/Clock' */
  real_T Saturation1;                  /* '<Root>/Saturation1' */
  real_T q1;                           /* '<S4>/Degrees' */
  real_T Sum;                          /* '<S4>/Sum' */
  real_T Kp;                           /* '<S4>/Kp' */
  real_T Saturation;                   /* '<S4>/Saturation' */
  real_T Saturation2;                  /* '<Root>/Saturation2' */
  real_T q2;                           /* '<S5>/Degrees1' */
  real_T Sum3;                         /* '<S5>/Sum3' */
  real_T Kp1;                          /* '<S5>/Kp1' */
  real_T Saturation1_g;                /* '<S5>/Saturation1' */
  real_T Saturation3;                  /* '<Root>/Saturation3' */
  real_T q3;                           /* '<S6>/Degrees' */
  real_T Sum_p;                        /* '<S6>/Sum' */
  real_T Kp_f;                         /* '<S6>/Kp' */
  real_T Saturation_i;                 /* '<S6>/Saturation' */
  real_T Saturation4;                  /* '<Root>/Saturation4' */
  real_T q4;                           /* '<S7>/Degrees' */
  real_T Sum_d;                        /* '<S7>/Sum' */
  real_T Kp_d;                         /* '<S7>/Kp' */
  real_T Saturation_j;                 /* '<S7>/Saturation' */
  real_T Saturation5;                  /* '<Root>/Saturation5' */
  real_T q5;                           /* '<S8>/Degrees' */
  real_T Sum_m;                        /* '<S8>/Sum' */
  real_T Kp_i;                         /* '<S8>/Kp' */
  real_T Saturation_l;                 /* '<S8>/Saturation' */
  real_T Saturation6;                  /* '<Root>/Saturation6' */
  real_T q1_c;                         /* '<S9>/Degrees' */
  real_T Sum_pq;                       /* '<S9>/Sum' */
  real_T Kp_o;                         /* '<S9>/Kp' */
  real_T Saturation_p;                 /* '<S9>/Saturation' */
  real_T Sign1;                        /* '<S4>/Sign1' */
  real_T Sign5;                        /* '<S5>/Sign5' */
  real_T Sign1_n;                      /* '<S6>/Sign1' */
  real_T Sign1_l;                      /* '<S7>/Sign1' */
  real_T Sign1_f;                      /* '<S8>/Sign1' */
  real_T Sign1_e;                      /* '<S9>/Sign1' */
} B_q_joints_T;

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  real_T HILInitialize_AIMinimums[8];  /* '<Root>/HIL Initialize' */
  real_T HILInitialize_AIMaximums[8];  /* '<Root>/HIL Initialize' */
  real_T HILInitialize_AOMinimums[8];  /* '<Root>/HIL Initialize' */
  real_T HILInitialize_AOMaximums[8];  /* '<Root>/HIL Initialize' */
  real_T HILInitialize_AOVoltages[8];  /* '<Root>/HIL Initialize' */
  real_T HILInitialize_FilterFrequency[8];/* '<Root>/HIL Initialize' */
  t_card HILInitialize_Card;           /* '<Root>/HIL Initialize' */
  t_task HILReadEncoderTimebase1_Task; /* '<S2>/HIL Read Encoder Timebase1' */
  void *Takover_PWORK;                 /* '<S1>/Takover' */
  void *EnableAmps_PWORK;              /* '<S1>/Enable Amps' */
  struct {
    void *LoggedData;
  } ToWorkspace24_PWORK;               /* '<Root>/To Workspace24' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac1_PWORK;               /* '<Root>/From Workspac1' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac2_PWORK;               /* '<Root>/From Workspac2' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac3_PWORK;               /* '<Root>/From Workspac3' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac4_PWORK;               /* '<Root>/From Workspac4' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac5_PWORK;               /* '<Root>/From Workspac5' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspac6_PWORK;               /* '<Root>/From Workspac6' */

  struct {
    void *LoggedData;
  } Ta1_PWORK;                         /* '<Root>/Ta1' */

  struct {
    void *LoggedData;
  } Ta2_PWORK;                         /* '<Root>/Ta2' */

  struct {
    void *LoggedData;
  } Ta3_PWORK;                         /* '<Root>/Ta3' */

  struct {
    void *LoggedData;
  } Ta4_PWORK;                         /* '<Root>/Ta4' */

  struct {
    void *LoggedData;
  } Ta5_PWORK;                         /* '<Root>/Ta5' */

  struct {
    void *LoggedData;
  } Ta6_PWORK;                         /* '<Root>/Ta6' */

  struct {
    void *LoggedData;
  } ToWorkspace_PWORK;                 /* '<Root>/To Workspace' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK;                /* '<Root>/To Workspace1' */

  struct {
    void *LoggedData;
  } ToWorkspace10_PWORK;               /* '<Root>/To Workspace10' */

  struct {
    void *LoggedData;
  } ToWorkspace11_PWORK;               /* '<Root>/To Workspace11' */

  struct {
    void *LoggedData;
  } ToWorkspace13_PWORK;               /* '<Root>/To Workspace13' */

  struct {
    void *LoggedData;
  } ToWorkspace14_PWORK;               /* '<Root>/To Workspace14' */

  struct {
    void *LoggedData;
  } ToWorkspace15_PWORK;               /* '<Root>/To Workspace15' */

  struct {
    void *LoggedData;
  } ToWorkspace16_PWORK;               /* '<Root>/To Workspace16' */

  struct {
    void *LoggedData;
  } ToWorkspace17_PWORK;               /* '<Root>/To Workspace17' */

  struct {
    void *LoggedData;
  } ToWorkspace18_PWORK;               /* '<Root>/To Workspace18' */

  struct {
    void *LoggedData;
  } ToWorkspace2_PWORK;                /* '<Root>/To Workspace2' */

  struct {
    void *LoggedData;
  } ToWorkspace3_PWORK;                /* '<Root>/To Workspace3' */

  struct {
    void *LoggedData;
  } ToWorkspace4_PWORK;                /* '<Root>/To Workspace4' */

  struct {
    void *LoggedData;
  } ToWorkspace5_PWORK;                /* '<Root>/To Workspace5' */

  struct {
    void *LoggedData;
  } ToWorkspace6_PWORK;                /* '<Root>/To Workspace6' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK;                /* '<Root>/To Workspace7' */

  struct {
    void *LoggedData;
  } ToWorkspace8_PWORK;                /* '<Root>/To Workspace8' */

  struct {
    void *LoggedData;
  } ToWorkspace9_PWORK;                /* '<Root>/To Workspace9' */

  struct {
    void *LoggedData;
  } q1_PWORK;                          /* '<Root>/q1' */

  struct {
    void *LoggedData;
  } q2_PWORK;                          /* '<Root>/q2' */

  struct {
    void *LoggedData;
  } q3_PWORK;                          /* '<Root>/q3' */

  struct {
    void *LoggedData;
  } q4_PWORK;                          /* '<Root>/q4' */

  struct {
    void *LoggedData;
  } q5_PWORK;                          /* '<Root>/q5' */

  struct {
    void *LoggedData;
  } q6_PWORK;                          /* '<Root>/q6' */

  void *HILWriteAnalog_PWORK;          /* '<S4>/HIL Write Analog' */
  struct {
    void *LoggedData;
  } Tafd1_PWORK;                       /* '<S4>/Tafd1' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK_k;              /* '<S4>/To Workspace1' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK_l;              /* '<S4>/To Workspace7' */

  struct {
    void *LoggedData;
  } check_PWORK;                       /* '<S4>/check' */

  struct {
    void *LoggedData;
  } check1_PWORK;                      /* '<S4>/check1' */

  void *HILWriteAnalog1_PWORK;         /* '<S5>/HIL Write Analog1' */
  struct {
    void *LoggedData;
  } Tafd2_PWORK;                       /* '<S5>/Tafd2' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK_b;              /* '<S5>/To Workspace1' */

  struct {
    void *LoggedData;
  } ToWorkspace2_PWORK_d;              /* '<S5>/To Workspace2' */

  void *HILWriteAnalog_PWORK_i;        /* '<S6>/HIL Write Analog' */
  struct {
    void *LoggedData;
  } Tafd3_PWORK;                       /* '<S6>/Tafd3' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK_f;              /* '<S6>/To Workspace1' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK_n;              /* '<S6>/To Workspace7' */

  void *HILWriteAnalog_PWORK_j;        /* '<S7>/HIL Write Analog' */
  struct {
    void *LoggedData;
  } Tafd4_PWORK;                       /* '<S7>/Tafd4' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK_h;              /* '<S7>/To Workspace7' */

  void *HILWriteAnalog_PWORK_b;        /* '<S8>/HIL Write Analog' */
  struct {
    void *LoggedData;
  } Tafd5_PWORK;                       /* '<S8>/Tafd5' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK_o;              /* '<S8>/To Workspace7' */

  void *HILWriteAnalog_PWORK_c;        /* '<S9>/HIL Write Analog' */
  struct {
    void *LoggedData;
  } Tafd6_PWORK;                       /* '<S9>/Tafd6' */

  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK_b;              /* '<S9>/To Workspace7' */

  void *HILSetEncoderCounts_PWORK;     /* '<S3>/HIL Set Encoder Counts' */
  int32_T HILInitialize_DOStates;      /* '<Root>/HIL Initialize' */
  int32_T HILInitialize_QuadratureModes[8];/* '<Root>/HIL Initialize' */
  int32_T HILInitialize_InitialEICounts[8];/* '<Root>/HIL Initialize' */
  int32_T HILReadEncoderTimebase1_Buffer[6];/* '<S2>/HIL Read Encoder Timebase1' */
  struct {
    int_T PrevIndex;
  } FromWorkspac1_IWORK;               /* '<Root>/From Workspac1' */

  struct {
    int_T PrevIndex;
  } FromWorkspac2_IWORK;               /* '<Root>/From Workspac2' */

  struct {
    int_T PrevIndex;
  } FromWorkspac3_IWORK;               /* '<Root>/From Workspac3' */

  struct {
    int_T PrevIndex;
  } FromWorkspac4_IWORK;               /* '<Root>/From Workspac4' */

  struct {
    int_T PrevIndex;
  } FromWorkspac5_IWORK;               /* '<Root>/From Workspac5' */

  struct {
    int_T PrevIndex;
  } FromWorkspac6_IWORK;               /* '<Root>/From Workspac6' */

  int8_T EncoderReset_SubsysRanBC;     /* '<S1>/Encoder Reset' */
  t_boolean Takover_Buffer;            /* '<S1>/Takover' */
} DW_q_joints_T;

/* Continuous states (auto storage) */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<S4>/Transfer Fcn' */
  real_T TransferFcn1_CSTATE;          /* '<S5>/Transfer Fcn1' */
  real_T TransferFcn_CSTATE_o;         /* '<S6>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_g;         /* '<S7>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_i;         /* '<S8>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_c;         /* '<S9>/Transfer Fcn' */
} X_q_joints_T;

/* State derivatives (auto storage) */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<S4>/Transfer Fcn' */
  real_T TransferFcn1_CSTATE;          /* '<S5>/Transfer Fcn1' */
  real_T TransferFcn_CSTATE_o;         /* '<S6>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_g;         /* '<S7>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_i;         /* '<S8>/Transfer Fcn' */
  real_T TransferFcn_CSTATE_c;         /* '<S9>/Transfer Fcn' */
} XDot_q_joints_T;

/* State disabled  */
typedef struct {
  boolean_T TransferFcn_CSTATE;        /* '<S4>/Transfer Fcn' */
  boolean_T TransferFcn1_CSTATE;       /* '<S5>/Transfer Fcn1' */
  boolean_T TransferFcn_CSTATE_o;      /* '<S6>/Transfer Fcn' */
  boolean_T TransferFcn_CSTATE_g;      /* '<S7>/Transfer Fcn' */
  boolean_T TransferFcn_CSTATE_i;      /* '<S8>/Transfer Fcn' */
  boolean_T TransferFcn_CSTATE_c;      /* '<S9>/Transfer Fcn' */
} XDis_q_joints_T;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState EncoderReset_Trig_ZCE;    /* '<S1>/Encoder Reset' */
} PrevZCX_q_joints_T;

#ifndef ODE4_INTG
#define ODE4_INTG

/* ODE4 Integration Data */
typedef struct {
  real_T *y;                           /* output */
  real_T *f[4];                        /* derivatives */
} ODE4_IntgData;

#endif

/* Parameters (auto storage) */
struct P_q_joints_T_ {
  real_T Kd[6];                        /* Variable: Kd
                                        * Referenced by:
                                        *   '<S4>/Kd'
                                        *   '<S5>/Kd1'
                                        *   '<S6>/Kd'
                                        *   '<S7>/Kd'
                                        *   '<S8>/Kd'
                                        *   '<S9>/Kd'
                                        */
  real_T Kp[6];                        /* Variable: Kp
                                        * Referenced by:
                                        *   '<S4>/Kp'
                                        *   '<S5>/Kp1'
                                        *   '<S6>/Kp'
                                        *   '<S7>/Kp'
                                        *   '<S8>/Kp'
                                        *   '<S9>/Kp'
                                        */
  real_T con_gain;                     /* Variable: con_gain
                                        * Referenced by:
                                        *   '<S4>/Sign'
                                        *   '<S5>/Sign4'
                                        *   '<S6>/Sign'
                                        *   '<S7>/Sign'
                                        *   '<S8>/Sign'
                                        *   '<S9>/Sign'
                                        */
  real_T HILInitialize_analog_input_maxi;/* Mask Parameter: HILInitialize_analog_input_maxi
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_analog_input_mini;/* Mask Parameter: HILInitialize_analog_input_mini
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_analog_output_max;/* Mask Parameter: HILInitialize_analog_output_max
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_analog_output_min;/* Mask Parameter: HILInitialize_analog_output_min
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T CompareToConstant_const;      /* Mask Parameter: CompareToConstant_const
                                        * Referenced by: '<S10>/Constant'
                                        */
  real_T CompareToConstant_const_h;    /* Mask Parameter: CompareToConstant_const_h
                                        * Referenced by: '<S11>/Constant'
                                        */
  real_T CompareToConstant_const_o;    /* Mask Parameter: CompareToConstant_const_o
                                        * Referenced by: '<S12>/Constant'
                                        */
  real_T CompareToConstant1_const;     /* Mask Parameter: CompareToConstant1_const
                                        * Referenced by: '<S13>/Constant'
                                        */
  real_T HILInitialize_encoder_filter_fr;/* Mask Parameter: HILInitialize_encoder_filter_fr
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_final_analog_outp[8];/* Mask Parameter: HILInitialize_final_analog_outp
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  real_T HILInitialize_final_pwm_outputs;/* Mask Parameter: HILInitialize_final_pwm_outputs
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_initial_analog_ou[8];/* Mask Parameter: HILInitialize_initial_analog_ou
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  real_T HILInitialize_initial_pwm_outpu;/* Mask Parameter: HILInitialize_initial_pwm_outpu
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_pwm_frequency;  /* Mask Parameter: HILInitialize_pwm_frequency
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  real_T HILInitialize_set_other_outputs;/* Mask Parameter: HILInitialize_set_other_outputs
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_set_other_outpu_k;/* Mask Parameter: HILInitialize_set_other_outpu_k
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_set_other_outpu_b;/* Mask Parameter: HILInitialize_set_other_outpu_b
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_set_other_outpu_n;/* Mask Parameter: HILInitialize_set_other_outpu_n
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_watchdog_analog_o;/* Mask Parameter: HILInitialize_watchdog_analog_o
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_watchdog_other_ou;/* Mask Parameter: HILInitialize_watchdog_other_ou
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  real_T HILInitialize_watchdog_pwm_outp;/* Mask Parameter: HILInitialize_watchdog_pwm_outp
                                          * Referenced by: '<Root>/HIL Initialize'
                                          */
  int32_T HILReadEncoderTimebase1_clock;/* Mask Parameter: HILReadEncoderTimebase1_clock
                                         * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                         */
  int32_T HILInitialize_clock_modes[2];/* Mask Parameter: HILInitialize_clock_modes
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  int32_T HILSetEncoderCounts_counts[6];/* Mask Parameter: HILSetEncoderCounts_counts
                                         * Referenced by: '<S3>/HIL Set Encoder Counts'
                                         */
  int32_T HILInitialize_hardware_clocks[2];/* Mask Parameter: HILInitialize_hardware_clocks
                                            * Referenced by: '<Root>/HIL Initialize'
                                            */
  int32_T HILInitialize_initial_encoder_c;/* Mask Parameter: HILInitialize_initial_encoder_c
                                           * Referenced by: '<Root>/HIL Initialize'
                                           */
  int32_T HILInitialize_pwm_modes;     /* Mask Parameter: HILInitialize_pwm_modes
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  int32_T HILInitialize_watchdog_digital_;/* Mask Parameter: HILInitialize_watchdog_digital_
                                           * Referenced by: '<Root>/HIL Initialize'
                                           */
  uint32_T HILInitialize_analog_input_chan[8];/* Mask Parameter: HILInitialize_analog_input_chan
                                               * Referenced by: '<Root>/HIL Initialize'
                                               */
  uint32_T HILInitialize_analog_output_cha[8];/* Mask Parameter: HILInitialize_analog_output_cha
                                               * Referenced by: '<Root>/HIL Initialize'
                                               */
  uint32_T HILSetEncoderCounts_channels[6];/* Mask Parameter: HILSetEncoderCounts_channels
                                            * Referenced by: '<S3>/HIL Set Encoder Counts'
                                            */
  uint32_T HILReadEncoderTimebase1_channel[6];/* Mask Parameter: HILReadEncoderTimebase1_channel
                                               * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                               */
  uint32_T Takover_channels;           /* Mask Parameter: Takover_channels
                                        * Referenced by: '<S1>/Takover'
                                        */
  uint32_T EnableAmps_channels;        /* Mask Parameter: EnableAmps_channels
                                        * Referenced by: '<S1>/Enable Amps'
                                        */
  uint32_T HILWriteAnalog_channels;    /* Mask Parameter: HILWriteAnalog_channels
                                        * Referenced by: '<S4>/HIL Write Analog'
                                        */
  uint32_T HILWriteAnalog1_channels;   /* Mask Parameter: HILWriteAnalog1_channels
                                        * Referenced by: '<S5>/HIL Write Analog1'
                                        */
  uint32_T HILWriteAnalog_channels_l;  /* Mask Parameter: HILWriteAnalog_channels_l
                                        * Referenced by: '<S6>/HIL Write Analog'
                                        */
  uint32_T HILWriteAnalog_channels_h;  /* Mask Parameter: HILWriteAnalog_channels_h
                                        * Referenced by: '<S7>/HIL Write Analog'
                                        */
  uint32_T HILWriteAnalog_channels_f;  /* Mask Parameter: HILWriteAnalog_channels_f
                                        * Referenced by: '<S8>/HIL Write Analog'
                                        */
  uint32_T HILWriteAnalog_channels_lh; /* Mask Parameter: HILWriteAnalog_channels_lh
                                        * Referenced by: '<S9>/HIL Write Analog'
                                        */
  uint32_T HILInitialize_digital_output_ch;/* Mask Parameter: HILInitialize_digital_output_ch
                                            * Referenced by: '<Root>/HIL Initialize'
                                            */
  uint32_T HILInitialize_encoder_channels[8];/* Mask Parameter: HILInitialize_encoder_channels
                                              * Referenced by: '<Root>/HIL Initialize'
                                              */
  uint32_T HILInitialize_quadrature;   /* Mask Parameter: HILInitialize_quadrature
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  uint32_T HILReadEncoderTimebase1_samples;/* Mask Parameter: HILReadEncoderTimebase1_samples
                                            * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                            */
  boolean_T HILInitialize_active;      /* Mask Parameter: HILInitialize_active
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  boolean_T HILInitialize_final_digital_out;/* Mask Parameter: HILInitialize_final_digital_out
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_initial_digital_o;/* Mask Parameter: HILInitialize_initial_digital_o
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_input_;/* Mask Parameter: HILInitialize_set_analog_input_
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_inpu_c;/* Mask Parameter: HILInitialize_set_analog_inpu_c
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_output;/* Mask Parameter: HILInitialize_set_analog_output
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_outp_j;/* Mask Parameter: HILInitialize_set_analog_outp_j
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_outp_i;/* Mask Parameter: HILInitialize_set_analog_outp_i
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_outp_l;/* Mask Parameter: HILInitialize_set_analog_outp_l
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_out_lc;/* Mask Parameter: HILInitialize_set_analog_out_lc
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_outp_a;/* Mask Parameter: HILInitialize_set_analog_outp_a
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_analog_outp_p;/* Mask Parameter: HILInitialize_set_analog_outp_p
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_clock_frequen;/* Mask Parameter: HILInitialize_set_clock_frequen
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_clock_frequ_p;/* Mask Parameter: HILInitialize_set_clock_frequ_p
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_clock_params_;/* Mask Parameter: HILInitialize_set_clock_params_
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_clock_param_b;/* Mask Parameter: HILInitialize_set_clock_param_b
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_outpu;/* Mask Parameter: HILInitialize_set_digital_outpu
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_f;/* Mask Parameter: HILInitialize_set_digital_out_f
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_e;/* Mask Parameter: HILInitialize_set_digital_out_e
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_m;/* Mask Parameter: HILInitialize_set_digital_out_m
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_g;/* Mask Parameter: HILInitialize_set_digital_out_g
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_l;/* Mask Parameter: HILInitialize_set_digital_out_l
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_digital_out_d;/* Mask Parameter: HILInitialize_set_digital_out_d
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_encoder_count;/* Mask Parameter: HILInitialize_set_encoder_count
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_encoder_cou_n;/* Mask Parameter: HILInitialize_set_encoder_cou_n
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_encoder_param;/* Mask Parameter: HILInitialize_set_encoder_param
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_encoder_par_e;/* Mask Parameter: HILInitialize_set_encoder_par_e
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_other_outpu_g;/* Mask Parameter: HILInitialize_set_other_outpu_g
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_outputs_a;/* Mask Parameter: HILInitialize_set_pwm_outputs_a
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_outputs_h;/* Mask Parameter: HILInitialize_set_pwm_outputs_h
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_outputs_k;/* Mask Parameter: HILInitialize_set_pwm_outputs_k
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_output_aa;/* Mask Parameter: HILInitialize_set_pwm_output_aa
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_outputs_o;/* Mask Parameter: HILInitialize_set_pwm_outputs_o
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_params_at;/* Mask Parameter: HILInitialize_set_pwm_params_at
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  boolean_T HILInitialize_set_pwm_params__k;/* Mask Parameter: HILInitialize_set_pwm_params__k
                                             * Referenced by: '<Root>/HIL Initialize'
                                             */
  real_T Mode_Value;                   /* Expression: 1.0
                                        * Referenced by: '<Root>/Mode'
                                        */
  real_T Constant_Value;               /* Expression: 0
                                        * Referenced by: '<S1>/Constant'
                                        */
  real_T Gain1_Gain;                   /* Expression: 1
                                        * Referenced by: '<Root>/Gain1'
                                        */
  real_T Gain2_Gain;                   /* Expression: 1
                                        * Referenced by: '<Root>/Gain2'
                                        */
  real_T Gain3_Gain;                   /* Expression: 1
                                        * Referenced by: '<Root>/Gain3'
                                        */
  real_T Gain4_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain4'
                                        */
  real_T Gain5_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain5'
                                        */
  real_T Gain6_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain6'
                                        */
  real_T Gain_Gain;                    /* Expression: 0.0
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T Saturation1_UpperSat;         /* Expression: 170
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T Saturation1_LowerSat;         /* Expression: -170
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T Degrees_Gain;                 /* Expression: -360/1000/4/100
                                        * Referenced by: '<S4>/Degrees'
                                        */
  real_T TransferFcn_A;                /* Computed Parameter: TransferFcn_A
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  real_T TransferFcn_C;                /* Computed Parameter: TransferFcn_C
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  real_T TransferFcn_D;                /* Computed Parameter: TransferFcn_D
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 5
                                        * Referenced by: '<S4>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: -5
                                        * Referenced by: '<S4>/Saturation'
                                        */
  real_T Saturation2_UpperSat;         /* Expression: 40
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T Saturation2_LowerSat;         /* Expression: -40
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T Degrees1_Gain;                /* Expression: -360/1000/4/100
                                        * Referenced by: '<S5>/Degrees1'
                                        */
  real_T TransferFcn1_A;               /* Computed Parameter: TransferFcn1_A
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  real_T TransferFcn1_C;               /* Computed Parameter: TransferFcn1_C
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  real_T TransferFcn1_D;               /* Computed Parameter: TransferFcn1_D
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  real_T Saturation1_UpperSat_j;       /* Expression: 5
                                        * Referenced by: '<S5>/Saturation1'
                                        */
  real_T Saturation1_LowerSat_c;       /* Expression: -5
                                        * Referenced by: '<S5>/Saturation1'
                                        */
  real_T Saturation3_UpperSat;         /* Expression: 190
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  real_T Saturation3_LowerSat;         /* Expression: -10
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  real_T Degrees_Gain_o;               /* Expression: 360/1000/4/100
                                        * Referenced by: '<S6>/Degrees'
                                        */
  real_T TransferFcn_A_a;              /* Computed Parameter: TransferFcn_A_a
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  real_T TransferFcn_C_k;              /* Computed Parameter: TransferFcn_C_k
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  real_T TransferFcn_D_m;              /* Computed Parameter: TransferFcn_D_m
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  real_T Saturation_UpperSat_l;        /* Expression: 5
                                        * Referenced by: '<S6>/Saturation'
                                        */
  real_T Saturation_LowerSat_e;        /* Expression: -5
                                        * Referenced by: '<S6>/Saturation'
                                        */
  real_T Saturation4_UpperSat;         /* Expression: 170
                                        * Referenced by: '<Root>/Saturation4'
                                        */
  real_T Saturation4_LowerSat;         /* Expression: -170
                                        * Referenced by: '<Root>/Saturation4'
                                        */
  real_T Degrees_Gain_d;               /* Expression: 360/500/4/100
                                        * Referenced by: '<S7>/Degrees'
                                        */
  real_T TransferFcn_A_g;              /* Computed Parameter: TransferFcn_A_g
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  real_T TransferFcn_C_a;              /* Computed Parameter: TransferFcn_C_a
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  real_T TransferFcn_D_j;              /* Computed Parameter: TransferFcn_D_j
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  real_T Saturation_UpperSat_k;        /* Expression: 5
                                        * Referenced by: '<S7>/Saturation'
                                        */
  real_T Saturation_LowerSat_l;        /* Expression: -5
                                        * Referenced by: '<S7>/Saturation'
                                        */
  real_T Saturation5_UpperSat;         /* Expression: 100
                                        * Referenced by: '<Root>/Saturation5'
                                        */
  real_T Saturation5_LowerSat;         /* Expression: -100
                                        * Referenced by: '<Root>/Saturation5'
                                        */
  real_T Degrees_Gain_k;               /* Expression: 360/500/4/100
                                        * Referenced by: '<S8>/Degrees'
                                        */
  real_T TransferFcn_A_m;              /* Computed Parameter: TransferFcn_A_m
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  real_T TransferFcn_C_l;              /* Computed Parameter: TransferFcn_C_l
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  real_T TransferFcn_D_k;              /* Computed Parameter: TransferFcn_D_k
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  real_T Saturation_UpperSat_b;        /* Expression: 5
                                        * Referenced by: '<S8>/Saturation'
                                        */
  real_T Saturation_LowerSat_i;        /* Expression: -5
                                        * Referenced by: '<S8>/Saturation'
                                        */
  real_T Saturation6_UpperSat;         /* Expression: 175
                                        * Referenced by: '<Root>/Saturation6'
                                        */
  real_T Saturation6_LowerSat;         /* Expression: -175
                                        * Referenced by: '<Root>/Saturation6'
                                        */
  real_T Degrees_Gain_kt;              /* Expression: 360/500/4/100
                                        * Referenced by: '<S9>/Degrees'
                                        */
  real_T TransferFcn_A_p;              /* Computed Parameter: TransferFcn_A_p
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  real_T TransferFcn_C_kh;             /* Computed Parameter: TransferFcn_C_kh
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  real_T TransferFcn_D_d;              /* Computed Parameter: TransferFcn_D_d
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  real_T Saturation_UpperSat_n;        /* Expression: 5
                                        * Referenced by: '<S9>/Saturation'
                                        */
  real_T Saturation_LowerSat_f;        /* Expression: -5
                                        * Referenced by: '<S9>/Saturation'
                                        */
  real_T Sign1_Gain;                   /* Expression: 1
                                        * Referenced by: '<S4>/Sign1'
                                        */
  real_T Sign5_Gain;                   /* Expression: 1
                                        * Referenced by: '<S5>/Sign5'
                                        */
  real_T Sign1_Gain_m;                 /* Expression: -1
                                        * Referenced by: '<S6>/Sign1'
                                        */
  real_T Sign1_Gain_i;                 /* Expression: -1
                                        * Referenced by: '<S7>/Sign1'
                                        */
  real_T Sign1_Gain_h;                 /* Expression: -1
                                        * Referenced by: '<S8>/Sign1'
                                        */
  real_T Sign1_Gain_p;                 /* Expression: -1
                                        * Referenced by: '<S9>/Sign1'
                                        */
  boolean_T HILSetEncoderCounts_Active;/* Computed Parameter: HILSetEncoderCounts_Active
                                        * Referenced by: '<S3>/HIL Set Encoder Counts'
                                        */
  boolean_T HILReadEncoderTimebase1_Active;/* Computed Parameter: HILReadEncoderTimebase1_Active
                                            * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                            */
  boolean_T Takover_Active;            /* Computed Parameter: Takover_Active
                                        * Referenced by: '<S1>/Takover'
                                        */
  boolean_T EnableAmps_Active;         /* Computed Parameter: EnableAmps_Active
                                        * Referenced by: '<S1>/Enable Amps'
                                        */
  boolean_T HILWriteAnalog_Active;     /* Computed Parameter: HILWriteAnalog_Active
                                        * Referenced by: '<S4>/HIL Write Analog'
                                        */
  boolean_T HILWriteAnalog1_Active;    /* Computed Parameter: HILWriteAnalog1_Active
                                        * Referenced by: '<S5>/HIL Write Analog1'
                                        */
  boolean_T HILWriteAnalog_Active_p;   /* Computed Parameter: HILWriteAnalog_Active_p
                                        * Referenced by: '<S6>/HIL Write Analog'
                                        */
  boolean_T HILWriteAnalog_Active_j;   /* Computed Parameter: HILWriteAnalog_Active_j
                                        * Referenced by: '<S7>/HIL Write Analog'
                                        */
  boolean_T HILWriteAnalog_Active_f;   /* Computed Parameter: HILWriteAnalog_Active_f
                                        * Referenced by: '<S8>/HIL Write Analog'
                                        */
  boolean_T HILWriteAnalog_Active_p2;  /* Computed Parameter: HILWriteAnalog_Active_p2
                                        * Referenced by: '<S9>/HIL Write Analog'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_q_joints_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;
  RTWSolverInfo solverInfo;

  /*
   * ModelData:
   * The following substructure contains information regarding
   * the data used in the model.
   */
  struct {
    X_q_joints_T *contStates;
    real_T *derivs;
    boolean_T *contStateDisabled;
    boolean_T zCCacheNeedsReset;
    boolean_T derivCacheNeedsReset;
    boolean_T blkStateChange;
    real_T odeY[6];
    real_T odeF[4][6];
    ODE4_IntgData intgData;
  } ModelData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
    int_T numContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T tFinal;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (auto storage) */
extern P_q_joints_T q_joints_P;

/* Block signals (auto storage) */
extern B_q_joints_T q_joints_B;

/* Continuous states (auto storage) */
extern X_q_joints_T q_joints_X;

/* Block states (auto storage) */
extern DW_q_joints_T q_joints_DW;

/* External data declarations for dependent source files */

/* Zero-crossing (trigger) state */
extern PrevZCX_q_joints_T q_joints_PrevZCX;

/* Model entry point functions */
extern void q_joints_initialize(void);
extern void q_joints_step(void);
extern void q_joints_terminate(void);

/* Real-time Model object */
extern RT_MODEL_q_joints_T *const q_joints_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'q_joints'
 * '<S1>'   : 'q_joints/CRS takeover'
 * '<S2>'   : 'q_joints/Subsystem'
 * '<S3>'   : 'q_joints/CRS takeover/Encoder Reset'
 * '<S4>'   : 'q_joints/Subsystem/Closed loop Joint 1'
 * '<S5>'   : 'q_joints/Subsystem/Closed loop Joint 2'
 * '<S6>'   : 'q_joints/Subsystem/Closed loop Joint 3'
 * '<S7>'   : 'q_joints/Subsystem/Closed loop Joint 4'
 * '<S8>'   : 'q_joints/Subsystem/Closed loop Joint 5'
 * '<S9>'   : 'q_joints/Subsystem/Closed loop Joint 6'
 * '<S10>'  : 'q_joints/Subsystem/Closed loop Joint 1/Compare To Constant'
 * '<S11>'  : 'q_joints/Subsystem/Closed loop Joint 2/Compare To Constant'
 * '<S12>'  : 'q_joints/Subsystem/Closed loop Joint 3/Compare To Constant'
 * '<S13>'  : 'q_joints/Subsystem/Closed loop Joint 3/Compare To Constant1'
 */
#endif                                 /* RTW_HEADER_q_joints_h_ */
