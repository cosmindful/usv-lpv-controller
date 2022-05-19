/*
 * q_joints_data.c
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
#include "q_joints.h"
#include "q_joints_private.h"

/* Block parameters (auto storage) */
P_q_joints_T q_joints_P = {
  /*  Variable: Kd
   * Referenced by:
   *   '<S4>/Kd'
   *   '<S5>/Kd1'
   *   '<S6>/Kd'
   *   '<S7>/Kd'
   *   '<S8>/Kd'
   *   '<S9>/Kd'
   */
  { 0.05, 0.05, 0.05, 0.013, 0.003, 0.002 },

  /*  Variable: Kp
   * Referenced by:
   *   '<S4>/Kp'
   *   '<S5>/Kp1'
   *   '<S6>/Kp'
   *   '<S7>/Kp'
   *   '<S8>/Kp'
   *   '<S9>/Kp'
   */
  { 2.5, 2.5, 2.5, 2.9, 2.9, 2.4 },
  1.0,                                 /* Variable: con_gain
                                        * Referenced by:
                                        *   '<S4>/Sign'
                                        *   '<S5>/Sign4'
                                        *   '<S6>/Sign'
                                        *   '<S7>/Sign'
                                        *   '<S8>/Sign'
                                        *   '<S9>/Sign'
                                        */
  10.0,                                /* Mask Parameter: HILInitialize_analog_input_maxi
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  -10.0,                               /* Mask Parameter: HILInitialize_analog_input_mini
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  5.0,                                 /* Mask Parameter: HILInitialize_analog_output_max
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  -5.0,                                /* Mask Parameter: HILInitialize_analog_output_min
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  170.0,                               /* Mask Parameter: CompareToConstant_const
                                        * Referenced by: '<S10>/Constant'
                                        */
  41.0,                                /* Mask Parameter: CompareToConstant_const_h
                                        * Referenced by: '<S11>/Constant'
                                        */
  -11.0,                               /* Mask Parameter: CompareToConstant_const_o
                                        * Referenced by: '<S12>/Constant'
                                        */
  191.0,                               /* Mask Parameter: CompareToConstant1_const
                                        * Referenced by: '<S13>/Constant'
                                        */
  8.333333333333334E+6,                /* Mask Parameter: HILInitialize_encoder_filter_fr
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */

  /*  Mask Parameter: HILInitialize_final_analog_outp
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
  0.0,                                 /* Mask Parameter: HILInitialize_final_pwm_outputs
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */

  /*  Mask Parameter: HILInitialize_initial_analog_ou
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },
  0.0,                                 /* Mask Parameter: HILInitialize_initial_pwm_outpu
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  16276.041666666668,                  /* Mask Parameter: HILInitialize_pwm_frequency
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1.0,                                 /* Mask Parameter: HILInitialize_set_other_outputs
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0.0,                                 /* Mask Parameter: HILInitialize_set_other_outpu_k
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0.0,                                 /* Mask Parameter: HILInitialize_set_other_outpu_b
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1.0,                                 /* Mask Parameter: HILInitialize_set_other_outpu_n
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0.0,                                 /* Mask Parameter: HILInitialize_watchdog_analog_o
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0.0,                                 /* Mask Parameter: HILInitialize_watchdog_other_ou
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0.0,                                 /* Mask Parameter: HILInitialize_watchdog_pwm_outp
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILReadEncoderTimebase1_clock
                                        * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                        */

  /*  Mask Parameter: HILInitialize_clock_modes
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0, 0 },

  /*  Mask Parameter: HILSetEncoderCounts_counts
   * Referenced by: '<S3>/HIL Set Encoder Counts'
   */
  { 0, 0, 0, 0, 0, 0 },

  /*  Mask Parameter: HILInitialize_hardware_clocks
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0, 1 },
  0,                                   /* Mask Parameter: HILInitialize_initial_encoder_c
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_pwm_modes
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_watchdog_digital_
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */

  /*  Mask Parameter: HILInitialize_analog_input_chan
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U },

  /*  Mask Parameter: HILInitialize_analog_output_cha
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U },

  /*  Mask Parameter: HILSetEncoderCounts_channels
   * Referenced by: '<S3>/HIL Set Encoder Counts'
   */
  { 0U, 1U, 2U, 3U, 4U, 5U },

  /*  Mask Parameter: HILReadEncoderTimebase1_channel
   * Referenced by: '<S2>/HIL Read Encoder Timebase1'
   */
  { 0U, 1U, 2U, 3U, 4U, 5U },
  8U,                                  /* Mask Parameter: Takover_channels
                                        * Referenced by: '<S1>/Takover'
                                        */
  6U,                                  /* Mask Parameter: EnableAmps_channels
                                        * Referenced by: '<S1>/Enable Amps'
                                        */
  0U,                                  /* Mask Parameter: HILWriteAnalog_channels
                                        * Referenced by: '<S4>/HIL Write Analog'
                                        */
  1U,                                  /* Mask Parameter: HILWriteAnalog1_channels
                                        * Referenced by: '<S5>/HIL Write Analog1'
                                        */
  2U,                                  /* Mask Parameter: HILWriteAnalog_channels_l
                                        * Referenced by: '<S6>/HIL Write Analog'
                                        */
  3U,                                  /* Mask Parameter: HILWriteAnalog_channels_h
                                        * Referenced by: '<S7>/HIL Write Analog'
                                        */
  4U,                                  /* Mask Parameter: HILWriteAnalog_channels_f
                                        * Referenced by: '<S8>/HIL Write Analog'
                                        */
  5U,                                  /* Mask Parameter: HILWriteAnalog_channels_lh
                                        * Referenced by: '<S9>/HIL Write Analog'
                                        */
  8U,                                  /* Mask Parameter: HILInitialize_digital_output_ch
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */

  /*  Mask Parameter: HILInitialize_encoder_channels
   * Referenced by: '<Root>/HIL Initialize'
   */
  { 0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U },
  4U,                                  /* Mask Parameter: HILInitialize_quadrature
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1000U,                               /* Mask Parameter: HILReadEncoderTimebase1_samples
                                        * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_active
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_final_digital_out
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_initial_digital_o
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_analog_input_
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_analog_inpu_c
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_analog_output
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_analog_outp_j
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_analog_outp_i
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_analog_outp_l
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_analog_out_lc
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_analog_outp_a
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_analog_outp_p
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_clock_frequen
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_clock_frequ_p
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_clock_params_
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_clock_param_b
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_digital_outpu
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_digital_out_f
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_digital_out_e
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_digital_out_m
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_digital_out_g
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_digital_out_l
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_digital_out_d
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_encoder_count
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_encoder_cou_n
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_encoder_param
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_encoder_par_e
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_other_outpu_g
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_pwm_outputs_a
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_pwm_outputs_h
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_pwm_outputs_k
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_pwm_output_aa
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_pwm_outputs_o
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1,                                   /* Mask Parameter: HILInitialize_set_pwm_params_at
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  0,                                   /* Mask Parameter: HILInitialize_set_pwm_params__k
                                        * Referenced by: '<Root>/HIL Initialize'
                                        */
  1.0,                                 /* Expression: 1.0
                                        * Referenced by: '<Root>/Mode'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<S1>/Constant'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Gain1'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Gain2'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Gain3'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Gain4'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Gain5'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Gain6'
                                        */
  0.0,                                 /* Expression: 0.0
                                        * Referenced by: '<Root>/Gain'
                                        */
  170.0,                               /* Expression: 170
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  -170.0,                              /* Expression: -170
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  -0.0009,                             /* Expression: -360/1000/4/100
                                        * Referenced by: '<S4>/Degrees'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn_A
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn_C
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn_D
                                        * Referenced by: '<S4>/Transfer Fcn'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S4>/Saturation'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S4>/Saturation'
                                        */
  40.0,                                /* Expression: 40
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  -40.0,                               /* Expression: -40
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  -0.0009,                             /* Expression: -360/1000/4/100
                                        * Referenced by: '<S5>/Degrees1'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn1_A
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn1_C
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn1_D
                                        * Referenced by: '<S5>/Transfer Fcn1'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S5>/Saturation1'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S5>/Saturation1'
                                        */
  190.0,                               /* Expression: 190
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  -10.0,                               /* Expression: -10
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  0.0009,                              /* Expression: 360/1000/4/100
                                        * Referenced by: '<S6>/Degrees'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn_A_a
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn_C_k
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn_D_m
                                        * Referenced by: '<S6>/Transfer Fcn'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S6>/Saturation'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S6>/Saturation'
                                        */
  170.0,                               /* Expression: 170
                                        * Referenced by: '<Root>/Saturation4'
                                        */
  -170.0,                              /* Expression: -170
                                        * Referenced by: '<Root>/Saturation4'
                                        */
  0.0018,                              /* Expression: 360/500/4/100
                                        * Referenced by: '<S7>/Degrees'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn_A_g
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn_C_a
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn_D_j
                                        * Referenced by: '<S7>/Transfer Fcn'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S7>/Saturation'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S7>/Saturation'
                                        */
  100.0,                               /* Expression: 100
                                        * Referenced by: '<Root>/Saturation5'
                                        */
  -100.0,                              /* Expression: -100
                                        * Referenced by: '<Root>/Saturation5'
                                        */
  0.0018,                              /* Expression: 360/500/4/100
                                        * Referenced by: '<S8>/Degrees'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn_A_m
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn_C_l
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn_D_k
                                        * Referenced by: '<S8>/Transfer Fcn'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S8>/Saturation'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S8>/Saturation'
                                        */
  175.0,                               /* Expression: 175
                                        * Referenced by: '<Root>/Saturation6'
                                        */
  -175.0,                              /* Expression: -175
                                        * Referenced by: '<Root>/Saturation6'
                                        */
  0.0018,                              /* Expression: 360/500/4/100
                                        * Referenced by: '<S9>/Degrees'
                                        */
  -100.0,                              /* Computed Parameter: TransferFcn_A_p
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  -10000.0,                            /* Computed Parameter: TransferFcn_C_kh
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  100.0,                               /* Computed Parameter: TransferFcn_D_d
                                        * Referenced by: '<S9>/Transfer Fcn'
                                        */
  5.0,                                 /* Expression: 5
                                        * Referenced by: '<S9>/Saturation'
                                        */
  -5.0,                                /* Expression: -5
                                        * Referenced by: '<S9>/Saturation'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S4>/Sign1'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<S5>/Sign5'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<S6>/Sign1'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<S7>/Sign1'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<S8>/Sign1'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<S9>/Sign1'
                                        */
  1,                                   /* Computed Parameter: HILSetEncoderCounts_Active
                                        * Referenced by: '<S3>/HIL Set Encoder Counts'
                                        */
  1,                                   /* Computed Parameter: HILReadEncoderTimebase1_Active
                                        * Referenced by: '<S2>/HIL Read Encoder Timebase1'
                                        */
  0,                                   /* Computed Parameter: Takover_Active
                                        * Referenced by: '<S1>/Takover'
                                        */
  0,                                   /* Computed Parameter: EnableAmps_Active
                                        * Referenced by: '<S1>/Enable Amps'
                                        */
  0,                                   /* Computed Parameter: HILWriteAnalog_Active
                                        * Referenced by: '<S4>/HIL Write Analog'
                                        */
  0,                                   /* Computed Parameter: HILWriteAnalog1_Active
                                        * Referenced by: '<S5>/HIL Write Analog1'
                                        */
  0,                                   /* Computed Parameter: HILWriteAnalog_Active_p
                                        * Referenced by: '<S6>/HIL Write Analog'
                                        */
  0,                                   /* Computed Parameter: HILWriteAnalog_Active_j
                                        * Referenced by: '<S7>/HIL Write Analog'
                                        */
  0,                                   /* Computed Parameter: HILWriteAnalog_Active_f
                                        * Referenced by: '<S8>/HIL Write Analog'
                                        */
  0                                    /* Computed Parameter: HILWriteAnalog_Active_p2
                                        * Referenced by: '<S9>/HIL Write Analog'
                                        */
};
