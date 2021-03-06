/*
 * q_joints_dt.h
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

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(t_boolean),
  sizeof(t_card),
  sizeof(t_task)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "t_boolean",
  "t_card",
  "t_task"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&q_joints_B.Clock), 0, 0, 37 }
  ,

  { (char_T *)(&q_joints_DW.HILInitialize_AIMinimums[0]), 0, 0, 48 },

  { (char_T *)(&q_joints_DW.HILInitialize_Card), 15, 0, 1 },

  { (char_T *)(&q_joints_DW.HILReadEncoderTimebase1_Task), 16, 0, 1 },

  { (char_T *)(&q_joints_DW.Takover_PWORK), 11, 0, 63 },

  { (char_T *)(&q_joints_DW.HILInitialize_DOStates), 6, 0, 23 },

  { (char_T *)(&q_joints_DW.FromWorkspac1_IWORK.PrevIndex), 10, 0, 6 },

  { (char_T *)(&q_joints_DW.EncoderReset_SubsysRanBC), 2, 0, 1 },

  { (char_T *)(&q_joints_DW.Takover_Buffer), 14, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  9U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&q_joints_P.Kd[0]), 0, 0, 48 },

  { (char_T *)(&q_joints_P.HILReadEncoderTimebase1_clock), 6, 0, 14 },

  { (char_T *)(&q_joints_P.HILInitialize_analog_input_chan[0]), 7, 0, 47 },

  { (char_T *)(&q_joints_P.HILInitialize_active), 8, 0, 35 },

  { (char_T *)(&q_joints_P.Mode_Value), 0, 0, 63 },

  { (char_T *)(&q_joints_P.HILSetEncoderCounts_Active), 8, 0, 10 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  6U,
  rtPTransitions
};

/* [EOF] q_joints_dt.h */
