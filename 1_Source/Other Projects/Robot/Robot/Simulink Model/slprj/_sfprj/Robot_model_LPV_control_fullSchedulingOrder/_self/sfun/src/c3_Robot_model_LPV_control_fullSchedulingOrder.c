/* Include files */

#include "blascompat32.h"
#include "Robot_model_LPV_control_fullSchedulingOrder_sfun.h"
#include "c3_Robot_model_LPV_control_fullSchedulingOrder.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Robot_model_LPV_control_fullSchedulingOrder_sfun_debug_macros.h"

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static const char * c3_debug_family_names[4] = { "nargin", "nargout",
  "DeltaVector", "Delta" };

/* Function Declarations */
static void initialize_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void initialize_params_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void enable_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void disable_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void c3_update_debugger_state_c3_Robot_model_LPV_control_fullScheduli
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static const mxArray
  *get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_st);
static void finalize_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void sf_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void initSimStructsc3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber);
static const mxArray *c3_sf_marshallOut(void *chartInstanceVoid, void *c3_inData);
static void c3_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_Delta, const char_T *c3_identifier, real_T c3_y[144]);
static void c3_b_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId, real_T c3_y[144]);
static void c3_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static const mxArray *c3_b_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static const mxArray *c3_c_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static real_T c3_c_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void c3_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static void c3_check_forloop_overflow_error
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);
static const mxArray *c3_d_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static int32_T c3_d_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void c3_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static uint8_T c3_e_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_b_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder,
   const char_T *c3_identifier);
static uint8_T c3_f_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void init_dsm_address_info
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
  chartInstance->c3_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c3_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder =
    0U;
}

static void initialize_params_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

static void enable_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c3_update_debugger_state_c3_Robot_model_LPV_control_fullScheduli
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

static const mxArray
  *get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
  const mxArray *c3_st;
  const mxArray *c3_y = NULL;
  int32_T c3_i0;
  real_T c3_u[144];
  const mxArray *c3_b_y = NULL;
  uint8_T c3_hoistedGlobal;
  uint8_T c3_b_u;
  const mxArray *c3_c_y = NULL;
  real_T (*c3_Delta)[144];
  c3_Delta = (real_T (*)[144])ssGetOutputPortSignal(chartInstance->S, 1);
  c3_st = NULL;
  c3_st = NULL;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_createcellarray(2), FALSE);
  for (c3_i0 = 0; c3_i0 < 144; c3_i0++) {
    c3_u[c3_i0] = (*c3_Delta)[c3_i0];
  }

  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 12, 12),
                FALSE);
  sf_mex_setcell(c3_y, 0, c3_b_y);
  c3_hoistedGlobal =
    chartInstance->c3_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder;
  c3_b_u = c3_hoistedGlobal;
  c3_c_y = NULL;
  sf_mex_assign(&c3_c_y, sf_mex_create("y", &c3_b_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c3_y, 1, c3_c_y);
  sf_mex_assign(&c3_st, c3_y, FALSE);
  return c3_st;
}

static void set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_st)
{
  const mxArray *c3_u;
  real_T c3_dv0[144];
  int32_T c3_i1;
  real_T (*c3_Delta)[144];
  c3_Delta = (real_T (*)[144])ssGetOutputPortSignal(chartInstance->S, 1);
  chartInstance->c3_doneDoubleBufferReInit = TRUE;
  c3_u = sf_mex_dup(c3_st);
  c3_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c3_u, 0)),
                      "Delta", c3_dv0);
  for (c3_i1 = 0; c3_i1 < 144; c3_i1++) {
    (*c3_Delta)[c3_i1] = c3_dv0[c3_i1];
  }

  chartInstance->c3_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder =
    c3_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c3_u, 1)),
    "is_active_c3_Robot_model_LPV_control_fullSchedulingOrder");
  sf_mex_destroy(&c3_u);
  c3_update_debugger_state_c3_Robot_model_LPV_control_fullScheduli(chartInstance);
  sf_mex_destroy(&c3_st);
}

static void finalize_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

static void sf_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
  int32_T c3_i2;
  int32_T c3_i3;
  int32_T c3_i4;
  real_T c3_DeltaVector[10];
  uint32_T c3_debug_family_var_map[4];
  real_T c3_nargin = 1.0;
  real_T c3_nargout = 1.0;
  real_T c3_Delta[144];
  real_T c3_b;
  int32_T c3_i5;
  real_T c3_y[2];
  real_T c3_b_b;
  int32_T c3_i6;
  real_T c3_b_y[2];
  int32_T c3_i7;
  real_T c3_v[12];
  int32_T c3_i8;
  int32_T c3_i9;
  int32_T c3_j;
  int32_T c3_b_j;
  int32_T c3_a;
  int32_T c3_c;
  int32_T c3_i10;
  real_T (*c3_b_Delta)[144];
  real_T (*c3_b_DeltaVector)[10];
  c3_b_DeltaVector = (real_T (*)[10])ssGetInputPortSignal(chartInstance->S, 0);
  c3_b_Delta = (real_T (*)[144])ssGetOutputPortSignal(chartInstance->S, 1);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  for (c3_i2 = 0; c3_i2 < 144; c3_i2++) {
    _SFD_DATA_RANGE_CHECK((*c3_b_Delta)[c3_i2], 0U);
  }

  for (c3_i3 = 0; c3_i3 < 10; c3_i3++) {
    _SFD_DATA_RANGE_CHECK((*c3_b_DeltaVector)[c3_i3], 1U);
  }

  chartInstance->c3_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  for (c3_i4 = 0; c3_i4 < 10; c3_i4++) {
    c3_DeltaVector[c3_i4] = (*c3_b_DeltaVector)[c3_i4];
  }

  sf_debug_symbol_scope_push_eml(0U, 4U, 4U, c3_debug_family_names,
    c3_debug_family_var_map);
  sf_debug_symbol_scope_add_eml_importable(&c3_nargin, 0U, c3_c_sf_marshallOut,
    c3_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c3_nargout, 1U, c3_c_sf_marshallOut,
    c3_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(c3_DeltaVector, 2U, c3_b_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(c3_Delta, 3U, c3_sf_marshallOut,
    c3_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 4);
  c3_b = c3_DeltaVector[0];
  for (c3_i5 = 0; c3_i5 < 2; c3_i5++) {
    c3_y[c3_i5] = c3_b;
  }

  c3_b_b = c3_DeltaVector[2];
  for (c3_i6 = 0; c3_i6 < 2; c3_i6++) {
    c3_b_y[c3_i6] = c3_b_b;
  }

  for (c3_i7 = 0; c3_i7 < 2; c3_i7++) {
    c3_v[c3_i7] = c3_y[c3_i7];
  }

  c3_v[2] = c3_DeltaVector[1];
  for (c3_i8 = 0; c3_i8 < 2; c3_i8++) {
    c3_v[c3_i8 + 3] = c3_b_y[c3_i8];
  }

  c3_v[5] = c3_DeltaVector[3];
  c3_v[6] = c3_DeltaVector[4];
  c3_v[7] = c3_DeltaVector[5];
  c3_v[8] = c3_DeltaVector[6];
  c3_v[9] = c3_DeltaVector[7];
  c3_v[10] = c3_DeltaVector[8];
  c3_v[11] = c3_DeltaVector[9];
  for (c3_i9 = 0; c3_i9 < 144; c3_i9++) {
    c3_Delta[c3_i9] = 0.0;
  }

  c3_check_forloop_overflow_error(chartInstance);
  for (c3_j = 1; c3_j < 13; c3_j++) {
    c3_b_j = c3_j;
    c3_a = c3_b_j;
    c3_c = c3_a;
    c3_Delta[(_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
                (real_T)c3_b_j), 1, 12, 1, 0) + 12 *
              (_SFD_EML_ARRAY_BOUNDS_CHECK("", (int32_T)_SFD_INTEGER_CHECK("",
      (real_T)c3_c), 1, 12, 2, 0) - 1)) - 1] = c3_v[_SFD_EML_ARRAY_BOUNDS_CHECK(
      "", (int32_T)_SFD_INTEGER_CHECK("", (real_T)c3_b_j), 1, 12, 1, 0) - 1];
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, -4);
  sf_debug_symbol_scope_pop();
  for (c3_i10 = 0; c3_i10 < 144; c3_i10++) {
    (*c3_b_Delta)[c3_i10] = c3_Delta[c3_i10];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  sf_debug_check_for_state_inconsistency
    (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
     chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void initSimStructsc3_Robot_model_LPV_control_fullSchedulingOrder
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber)
{
}

static const mxArray *c3_sf_marshallOut(void *chartInstanceVoid, void *c3_inData)
{
  const mxArray *c3_mxArrayOutData = NULL;
  int32_T c3_i11;
  int32_T c3_i12;
  int32_T c3_i13;
  real_T c3_b_inData[144];
  int32_T c3_i14;
  int32_T c3_i15;
  int32_T c3_i16;
  real_T c3_u[144];
  const mxArray *c3_y = NULL;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_i11 = 0;
  for (c3_i12 = 0; c3_i12 < 12; c3_i12++) {
    for (c3_i13 = 0; c3_i13 < 12; c3_i13++) {
      c3_b_inData[c3_i13 + c3_i11] = (*(real_T (*)[144])c3_inData)[c3_i13 +
        c3_i11];
    }

    c3_i11 += 12;
  }

  c3_i14 = 0;
  for (c3_i15 = 0; c3_i15 < 12; c3_i15++) {
    for (c3_i16 = 0; c3_i16 < 12; c3_i16++) {
      c3_u[c3_i16 + c3_i14] = c3_b_inData[c3_i16 + c3_i14];
    }

    c3_i14 += 12;
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 12, 12), FALSE);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, FALSE);
  return c3_mxArrayOutData;
}

static void c3_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_Delta, const char_T *c3_identifier, real_T c3_y[144])
{
  emlrtMsgIdentifier c3_thisId;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_Delta), &c3_thisId, c3_y);
  sf_mex_destroy(&c3_Delta);
}

static void c3_b_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId, real_T c3_y[144])
{
  real_T c3_dv1[144];
  int32_T c3_i17;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), c3_dv1, 1, 0, 0U, 1, 0U, 2, 12,
                12);
  for (c3_i17 = 0; c3_i17 < 144; c3_i17++) {
    c3_y[c3_i17] = c3_dv1[c3_i17];
  }

  sf_mex_destroy(&c3_u);
}

static void c3_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_Delta;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y[144];
  int32_T c3_i18;
  int32_T c3_i19;
  int32_T c3_i20;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_Delta = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_Delta), &c3_thisId, c3_y);
  sf_mex_destroy(&c3_Delta);
  c3_i18 = 0;
  for (c3_i19 = 0; c3_i19 < 12; c3_i19++) {
    for (c3_i20 = 0; c3_i20 < 12; c3_i20++) {
      (*(real_T (*)[144])c3_outData)[c3_i20 + c3_i18] = c3_y[c3_i20 + c3_i18];
    }

    c3_i18 += 12;
  }

  sf_mex_destroy(&c3_mxArrayInData);
}

static const mxArray *c3_b_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData = NULL;
  int32_T c3_i21;
  real_T c3_b_inData[10];
  int32_T c3_i22;
  real_T c3_u[10];
  const mxArray *c3_y = NULL;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  for (c3_i21 = 0; c3_i21 < 10; c3_i21++) {
    c3_b_inData[c3_i21] = (*(real_T (*)[10])c3_inData)[c3_i21];
  }

  for (c3_i22 = 0; c3_i22 < 10; c3_i22++) {
    c3_u[c3_i22] = c3_b_inData[c3_i22];
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 1, 10), FALSE);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, FALSE);
  return c3_mxArrayOutData;
}

static const mxArray *c3_c_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData = NULL;
  real_T c3_u;
  const mxArray *c3_y = NULL;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_u = *(real_T *)c3_inData;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", &c3_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, FALSE);
  return c3_mxArrayOutData;
}

static real_T c3_c_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  real_T c3_y;
  real_T c3_d0;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_d0, 1, 0, 0U, 0, 0U, 0);
  c3_y = c3_d0;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void c3_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_nargout;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_nargout = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_y = c3_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_nargout), &c3_thisId);
  sf_mex_destroy(&c3_nargout);
  *(real_T *)c3_outData = c3_y;
  sf_mex_destroy(&c3_mxArrayInData);
}

const mxArray
  *sf_c3_Robot_model_LPV_control_fullSchedulingOrder_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c3_nameCaptureInfo;
  c3_ResolvedFunctionInfo c3_info[8];
  c3_ResolvedFunctionInfo (*c3_b_info)[8];
  const mxArray *c3_m0 = NULL;
  int32_T c3_i23;
  c3_ResolvedFunctionInfo *c3_r0;
  c3_nameCaptureInfo = NULL;
  c3_nameCaptureInfo = NULL;
  c3_b_info = (c3_ResolvedFunctionInfo (*)[8])c3_info;
  (*c3_b_info)[0].context = "";
  (*c3_b_info)[0].name = "mtimes";
  (*c3_b_info)[0].dominantType = "double";
  (*c3_b_info)[0].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  (*c3_b_info)[0].fileTimeLo = 1289519692U;
  (*c3_b_info)[0].fileTimeHi = 0U;
  (*c3_b_info)[0].mFileTimeLo = 0U;
  (*c3_b_info)[0].mFileTimeHi = 0U;
  (*c3_b_info)[1].context = "";
  (*c3_b_info)[1].name = "diag";
  (*c3_b_info)[1].dominantType = "double";
  (*c3_b_info)[1].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/diag.m";
  (*c3_b_info)[1].fileTimeLo = 1286818686U;
  (*c3_b_info)[1].fileTimeHi = 0U;
  (*c3_b_info)[1].mFileTimeLo = 0U;
  (*c3_b_info)[1].mFileTimeHi = 0U;
  (*c3_b_info)[2].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/diag.m";
  (*c3_b_info)[2].name = "eml_index_class";
  (*c3_b_info)[2].dominantType = "";
  (*c3_b_info)[2].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  (*c3_b_info)[2].fileTimeLo = 1323170578U;
  (*c3_b_info)[2].fileTimeHi = 0U;
  (*c3_b_info)[2].mFileTimeLo = 0U;
  (*c3_b_info)[2].mFileTimeHi = 0U;
  (*c3_b_info)[3].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/diag.m";
  (*c3_b_info)[3].name = "eml_index_plus";
  (*c3_b_info)[3].dominantType = "coder.internal.indexInt";
  (*c3_b_info)[3].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_plus.m";
  (*c3_b_info)[3].fileTimeLo = 1286818778U;
  (*c3_b_info)[3].fileTimeHi = 0U;
  (*c3_b_info)[3].mFileTimeLo = 0U;
  (*c3_b_info)[3].mFileTimeHi = 0U;
  (*c3_b_info)[4].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_plus.m";
  (*c3_b_info)[4].name = "eml_index_class";
  (*c3_b_info)[4].dominantType = "";
  (*c3_b_info)[4].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  (*c3_b_info)[4].fileTimeLo = 1323170578U;
  (*c3_b_info)[4].fileTimeHi = 0U;
  (*c3_b_info)[4].mFileTimeLo = 0U;
  (*c3_b_info)[4].mFileTimeHi = 0U;
  (*c3_b_info)[5].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/diag.m";
  (*c3_b_info)[5].name = "eml_scalar_eg";
  (*c3_b_info)[5].dominantType = "double";
  (*c3_b_info)[5].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  (*c3_b_info)[5].fileTimeLo = 1286818796U;
  (*c3_b_info)[5].fileTimeHi = 0U;
  (*c3_b_info)[5].mFileTimeLo = 0U;
  (*c3_b_info)[5].mFileTimeHi = 0U;
  (*c3_b_info)[6].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/diag.m";
  (*c3_b_info)[6].name = "eml_int_forloop_overflow_check";
  (*c3_b_info)[6].dominantType = "";
  (*c3_b_info)[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m";
  (*c3_b_info)[6].fileTimeLo = 1332168672U;
  (*c3_b_info)[6].fileTimeHi = 0U;
  (*c3_b_info)[6].mFileTimeLo = 0U;
  (*c3_b_info)[6].mFileTimeHi = 0U;
  (*c3_b_info)[7].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper";
  (*c3_b_info)[7].name = "intmax";
  (*c3_b_info)[7].dominantType = "char";
  (*c3_b_info)[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/intmax.m";
  (*c3_b_info)[7].fileTimeLo = 1311255316U;
  (*c3_b_info)[7].fileTimeHi = 0U;
  (*c3_b_info)[7].mFileTimeLo = 0U;
  (*c3_b_info)[7].mFileTimeHi = 0U;
  sf_mex_assign(&c3_m0, sf_mex_createstruct("nameCaptureInfo", 1, 8), FALSE);
  for (c3_i23 = 0; c3_i23 < 8; c3_i23++) {
    c3_r0 = &c3_info[c3_i23];
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c3_r0->context)), "context", "nameCaptureInfo",
                    c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c3_r0->name)), "name", "nameCaptureInfo", c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c3_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c3_r0->resolved)), "resolved", "nameCaptureInfo",
                    c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c3_i23);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c3_i23);
  }

  sf_mex_assign(&c3_nameCaptureInfo, c3_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c3_nameCaptureInfo);
  return c3_nameCaptureInfo;
}

static void c3_check_forloop_overflow_error
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

static const mxArray *c3_d_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData = NULL;
  int32_T c3_u;
  const mxArray *c3_y = NULL;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_u = *(int32_T *)c3_inData;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", &c3_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, FALSE);
  return c3_mxArrayOutData;
}

static int32_T c3_d_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  int32_T c3_y;
  int32_T c3_i24;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_i24, 1, 6, 0U, 0, 0U, 0);
  c3_y = c3_i24;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void c3_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_b_sfEvent;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  int32_T c3_y;
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
    chartInstanceVoid;
  c3_b_sfEvent = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_y = c3_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_b_sfEvent),
    &c3_thisId);
  sf_mex_destroy(&c3_b_sfEvent);
  *(int32_T *)c3_outData = c3_y;
  sf_mex_destroy(&c3_mxArrayInData);
}

static uint8_T c3_e_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_b_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder,
   const char_T *c3_identifier)
{
  uint8_T c3_y;
  emlrtMsgIdentifier c3_thisId;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_y = c3_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c3_b_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder), &c3_thisId);
  sf_mex_destroy(&c3_b_is_active_c3_Robot_model_LPV_control_fullSchedulingOrder);
  return c3_y;
}

static uint8_T c3_f_emlrt_marshallIn
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  uint8_T c3_y;
  uint8_T c3_u0;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_u0, 1, 3, 0U, 0, 0U, 0);
  c3_y = c3_u0;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void init_dsm_address_info
  (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance)
{
}

/* SFunction Glue Code */
void sf_c3_Robot_model_LPV_control_fullSchedulingOrder_get_check_sum(mxArray
  *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1235832684U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1518753600U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3907686630U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(118322004U);
}

mxArray
  *sf_c3_Robot_model_LPV_control_fullSchedulingOrder_get_autoinheritance_info
  (void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("ZxHA0brovF2fKwnIQICNIG");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(10);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
      pr[1] = (double)(12);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

static const mxArray
  *sf_get_sim_state_info_c3_Robot_model_LPV_control_fullSchedulingOrder(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[4],T\"Delta\",},{M[8],M[0],T\"is_active_c3_Robot_model_LPV_control_fullSchedulingOrder\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c3_Robot_model_LPV_control_fullSchedulingOrder_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct
      *chartInstance;
    chartInstance =
      (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)
      ((ChartInfoStruct *)(ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
           3,
           1,
           1,
           2,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation
            (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
             chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds
            (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
             chartInstance->chartNumber,
             0,
             0,
             0);
          _SFD_SET_DATA_PROPS(0,2,0,1,"Delta");
          _SFD_SET_DATA_PROPS(1,1,1,0,"DeltaVector");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,244);
        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 12;
          dimVector[1]= 12;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_sf_marshallOut,(MexInFcnForType)
            c3_sf_marshallIn);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 10;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          real_T (*c3_Delta)[144];
          real_T (*c3_DeltaVector)[10];
          c3_DeltaVector = (real_T (*)[10])ssGetInputPortSignal(chartInstance->S,
            0);
          c3_Delta = (real_T (*)[144])ssGetOutputPortSignal(chartInstance->S, 1);
          _SFD_SET_DATA_VALUE_PTR(0U, *c3_Delta);
          _SFD_SET_DATA_VALUE_PTR(1U, *c3_DeltaVector);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration
        (_Robot_model_LPV_control_fullSchedulingOrderMachineNumber_,
         chartInstance->chartNumber,chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization()
{
  return "wgzVO2xQtJvookL5wHG7BB";
}

static void sf_opaque_initialize_c3_Robot_model_LPV_control_fullSchedulingOrder
  (void *chartInstanceVar)
{
  chart_debug_initialization
    (((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
      chartInstanceVar)->S,0);
  initialize_params_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
  initialize_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_enable_c3_Robot_model_LPV_control_fullSchedulingOrder(void
  *chartInstanceVar)
{
  enable_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_disable_c3_Robot_model_LPV_control_fullSchedulingOrder
  (void *chartInstanceVar)
{
  disable_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_gateway_c3_Robot_model_LPV_control_fullSchedulingOrder
  (void *chartInstanceVar)
{
  sf_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*)
    get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c3_Robot_model_LPV_control_fullSchedulingOrder();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void
  sf_internal_set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct* S, const mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c3_Robot_model_LPV_control_fullSchedulingOrder();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct* S)
{
  return
    sf_internal_get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder(S);
}

static void
  sf_opaque_set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder(S, st);
}

static void sf_opaque_terminate_c3_Robot_model_LPV_control_fullSchedulingOrder
  (void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S =
      ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
       chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
    }

    finalize_c3_Robot_model_LPV_control_fullSchedulingOrder
      ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
       chartInstanceVar);
    free((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }

  unload_Robot_model_LPV_control_fullSchedulingOrder_optimization_info();
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc3_Robot_model_LPV_control_fullSchedulingOrder
    ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
     chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c3_Robot_model_LPV_control_fullSchedulingOrder
      ((SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c3_Robot_model_LPV_control_fullSchedulingOrder
  (SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Robot_model_LPV_control_fullSchedulingOrder_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      3);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,3,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,3,
      "gatewayCannotBeInlinedMultipleTimes"));
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,3,1);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,3,1);
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,3);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(325375201U));
  ssSetChecksum1(S,(3481395829U));
  ssSetChecksum2(S,(3732076665U));
  ssSetChecksum3(S,(1042208820U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c3_Robot_model_LPV_control_fullSchedulingOrder(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c3_Robot_model_LPV_control_fullSchedulingOrder(SimStruct *S)
{
  SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *chartInstance;
  chartInstance =
    (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct *)malloc
    (sizeof(SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc3_Robot_model_LPV_control_fullSchedulingOrderInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c3_Robot_model_LPV_control_fullSchedulingOrder;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c3_Robot_model_LPV_control_fullSchedulingOrder_method_dispatcher(SimStruct *
  S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c3_Robot_model_LPV_control_fullSchedulingOrder(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c3_Robot_model_LPV_control_fullSchedulingOrder(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c3_Robot_model_LPV_control_fullSchedulingOrder(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c3_Robot_model_LPV_control_fullSchedulingOrder_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
