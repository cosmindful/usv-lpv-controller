/* Include files */

#include "blascompat32.h"
#include "Robot_model_LPV_control_sfun.h"
#include "c2_Robot_model_LPV_control.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Robot_model_LPV_control_sfun_debug_macros.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static const char * c2_debug_family_names[29] = { "q2", "q3", "qd2", "qd3", "b1",
  "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b", "v", "theta1", "theta2",
  "theta3", "theta4", "theta6", "theta10", "theta5", "theta7", "theta8",
  "theta9", "nargin", "nargout", "rho", "theta" };

/* Function Declarations */
static void initialize_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void initialize_params_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void enable_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void disable_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void c2_update_debugger_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void set_sim_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance, const mxArray
   *c2_st);
static void finalize_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void sf_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void c2_chartstep_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void initSimStructsc2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static void c2_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_theta, const char_T *c2_identifier, real_T
  c2_y[10]);
static void c2_b_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[10]);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static real_T c2_c_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_d_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[9]);
static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[13]);
static real_T c2_mpower(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, real_T c2_a);
static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_e_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_f_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_b_is_active_c2_Robot_model_LPV_control, const
  char_T *c2_identifier);
static uint8_T c2_g_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c2_is_active_c2_Robot_model_LPV_control = 0U;
}

static void initialize_params_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
}

static void enable_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c2_update_debugger_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  int32_T c2_i0;
  real_T c2_u[10];
  const mxArray *c2_b_y = NULL;
  uint8_T c2_hoistedGlobal;
  uint8_T c2_b_u;
  const mxArray *c2_c_y = NULL;
  real_T (*c2_theta)[10];
  c2_theta = (real_T (*)[10])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellarray(2), FALSE);
  for (c2_i0 = 0; c2_i0 < 10; c2_i0++) {
    c2_u[c2_i0] = (*c2_theta)[c2_i0];
  }

  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 10), FALSE);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_hoistedGlobal = chartInstance->c2_is_active_c2_Robot_model_LPV_control;
  c2_b_u = c2_hoistedGlobal;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_b_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  sf_mex_assign(&c2_st, c2_y, FALSE);
  return c2_st;
}

static void set_sim_state_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance, const mxArray
   *c2_st)
{
  const mxArray *c2_u;
  real_T c2_dv0[10];
  int32_T c2_i1;
  real_T (*c2_theta)[10];
  c2_theta = (real_T (*)[10])ssGetOutputPortSignal(chartInstance->S, 1);
  chartInstance->c2_doneDoubleBufferReInit = TRUE;
  c2_u = sf_mex_dup(c2_st);
  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
                      "theta", c2_dv0);
  for (c2_i1 = 0; c2_i1 < 10; c2_i1++) {
    (*c2_theta)[c2_i1] = c2_dv0[c2_i1];
  }

  chartInstance->c2_is_active_c2_Robot_model_LPV_control = c2_f_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)),
     "is_active_c2_Robot_model_LPV_control");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_Robot_model_LPV_control(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
}

static void sf_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  int32_T c2_i2;
  int32_T c2_i3;
  real_T (*c2_theta)[10];
  real_T (*c2_rho)[4];
  c2_theta = (real_T (*)[10])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_rho = (real_T (*)[4])ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  for (c2_i2 = 0; c2_i2 < 4; c2_i2++) {
    _SFD_DATA_RANGE_CHECK((*c2_rho)[c2_i2], 0U);
  }

  for (c2_i3 = 0; c2_i3 < 10; c2_i3++) {
    _SFD_DATA_RANGE_CHECK((*c2_theta)[c2_i3], 1U);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  c2_chartstep_c2_Robot_model_LPV_control(chartInstance);
  sf_debug_check_for_state_inconsistency(_Robot_model_LPV_controlMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void c2_chartstep_c2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
  int32_T c2_i4;
  real_T c2_rho[4];
  uint32_T c2_debug_family_var_map[29];
  real_T c2_q2;
  real_T c2_q3;
  real_T c2_qd2;
  real_T c2_qd3;
  real_T c2_b1;
  real_T c2_b2;
  real_T c2_b3;
  real_T c2_b4;
  real_T c2_b5;
  real_T c2_b6;
  real_T c2_b7;
  real_T c2_b8;
  real_T c2_b9;
  real_T c2_b[9];
  real_T c2_v;
  real_T c2_theta1;
  real_T c2_theta2;
  real_T c2_theta3;
  real_T c2_theta4;
  real_T c2_theta6;
  real_T c2_theta10;
  real_T c2_theta5;
  real_T c2_theta7;
  real_T c2_theta8;
  real_T c2_theta9;
  real_T c2_nargin = 1.0;
  real_T c2_nargout = 1.0;
  real_T c2_theta[10];
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_a;
  real_T c2_b_y;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_c_b;
  real_T c2_c_y;
  real_T c2_b_a;
  real_T c2_d_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_c_a;
  real_T c2_e_y;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_d_a;
  real_T c2_f_y;
  real_T c2_e_a;
  real_T c2_g_y;
  real_T c2_B;
  real_T c2_h_y;
  real_T c2_i_y;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_f_a;
  real_T c2_d_b;
  real_T c2_j_y;
  real_T c2_A;
  real_T c2_b_B;
  real_T c2_k_x;
  real_T c2_k_y;
  real_T c2_l_x;
  real_T c2_l_y;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_b_A;
  real_T c2_c_B;
  real_T c2_o_x;
  real_T c2_m_y;
  real_T c2_p_x;
  real_T c2_n_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_g_a;
  real_T c2_e_b;
  real_T c2_o_y;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_h_a;
  real_T c2_f_b;
  real_T c2_p_y;
  real_T c2_c_A;
  real_T c2_d_B;
  real_T c2_u_x;
  real_T c2_q_y;
  real_T c2_v_x;
  real_T c2_r_y;
  real_T c2_w_x;
  real_T c2_x_x;
  real_T c2_i_a;
  real_T c2_g_b;
  real_T c2_s_y;
  real_T c2_d_A;
  real_T c2_e_B;
  real_T c2_y_x;
  real_T c2_t_y;
  real_T c2_ab_x;
  real_T c2_u_y;
  real_T c2_bb_x;
  real_T c2_cb_x;
  real_T c2_j_a;
  real_T c2_h_b;
  real_T c2_v_y;
  real_T c2_db_x;
  real_T c2_eb_x;
  real_T c2_k_a;
  real_T c2_i_b;
  real_T c2_w_y;
  real_T c2_e_A;
  real_T c2_f_B;
  real_T c2_fb_x;
  real_T c2_x_y;
  real_T c2_gb_x;
  real_T c2_y_y;
  real_T c2_g_B;
  real_T c2_ab_y;
  real_T c2_bb_y;
  real_T c2_hb_x;
  real_T c2_ib_x;
  real_T c2_f_A;
  real_T c2_h_B;
  real_T c2_jb_x;
  real_T c2_cb_y;
  real_T c2_kb_x;
  real_T c2_db_y;
  real_T c2_eb_y;
  real_T c2_g_A;
  real_T c2_i_B;
  real_T c2_lb_x;
  real_T c2_fb_y;
  real_T c2_mb_x;
  real_T c2_gb_y;
  real_T c2_j_B;
  real_T c2_hb_y;
  real_T c2_ib_y;
  real_T c2_nb_x;
  real_T c2_ob_x;
  real_T c2_h_A;
  real_T c2_k_B;
  real_T c2_pb_x;
  real_T c2_jb_y;
  real_T c2_qb_x;
  real_T c2_kb_y;
  real_T c2_lb_y;
  real_T c2_i_A;
  real_T c2_l_B;
  real_T c2_rb_x;
  real_T c2_mb_y;
  real_T c2_sb_x;
  real_T c2_nb_y;
  real_T c2_tb_x;
  real_T c2_ub_x;
  real_T c2_j_A;
  real_T c2_m_B;
  real_T c2_vb_x;
  real_T c2_ob_y;
  real_T c2_wb_x;
  real_T c2_pb_y;
  real_T c2_xb_x;
  real_T c2_yb_x;
  real_T c2_k_A;
  real_T c2_n_B;
  real_T c2_ac_x;
  real_T c2_qb_y;
  real_T c2_bc_x;
  real_T c2_rb_y;
  real_T c2_sb_y;
  real_T c2_cc_x;
  real_T c2_dc_x;
  real_T c2_l_a;
  real_T c2_j_b;
  real_T c2_tb_y;
  real_T c2_l_A;
  real_T c2_o_B;
  real_T c2_ec_x;
  real_T c2_ub_y;
  real_T c2_fc_x;
  real_T c2_vb_y;
  real_T c2_gc_x;
  real_T c2_hc_x;
  real_T c2_m_A;
  real_T c2_p_B;
  real_T c2_ic_x;
  real_T c2_wb_y;
  real_T c2_jc_x;
  real_T c2_xb_y;
  real_T c2_kc_x;
  real_T c2_lc_x;
  real_T c2_n_A;
  real_T c2_q_B;
  real_T c2_mc_x;
  real_T c2_yb_y;
  real_T c2_nc_x;
  real_T c2_ac_y;
  real_T c2_bc_y;
  real_T c2_oc_x;
  real_T c2_pc_x;
  real_T c2_m_a;
  real_T c2_k_b;
  real_T c2_cc_y;
  real_T c2_o_A;
  real_T c2_r_B;
  real_T c2_qc_x;
  real_T c2_dc_y;
  real_T c2_rc_x;
  real_T c2_ec_y;
  int32_T c2_i5;
  real_T (*c2_b_theta)[10];
  real_T (*c2_b_rho)[4];
  c2_b_theta = (real_T (*)[10])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_b_rho = (real_T (*)[4])ssGetInputPortSignal(chartInstance->S, 0);
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  for (c2_i4 = 0; c2_i4 < 4; c2_i4++) {
    c2_rho[c2_i4] = (*c2_b_rho)[c2_i4];
  }

  sf_debug_symbol_scope_push_eml(0U, 29U, 29U, c2_debug_family_names,
    c2_debug_family_var_map);
  sf_debug_symbol_scope_add_eml_importable(&c2_q2, 0U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_q3, 1U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_qd2, 2U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_qd3, 3U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(&c2_b1, 4U, c2_c_sf_marshallOut);
  sf_debug_symbol_scope_add_eml(&c2_b2, 5U, c2_c_sf_marshallOut);
  sf_debug_symbol_scope_add_eml(&c2_b3, 6U, c2_c_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c2_b4, 7U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_b5, 8U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_b6, 9U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(&c2_b7, 10U, c2_c_sf_marshallOut);
  sf_debug_symbol_scope_add_eml(&c2_b8, 11U, c2_c_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(&c2_b9, 12U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(c2_b, 13U, c2_d_sf_marshallOut,
    c2_c_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_v, 14U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta1, 15U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta2, 16U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta3, 17U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta4, 18U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta6, 19U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta10, 20U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta5, 21U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta7, 22U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta8, 23U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_theta9, 24U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_nargin, 25U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml_importable(&c2_nargout, 26U, c2_c_sf_marshallOut,
    c2_b_sf_marshallIn);
  sf_debug_symbol_scope_add_eml(c2_rho, 27U, c2_b_sf_marshallOut);
  sf_debug_symbol_scope_add_eml_importable(c2_theta, 28U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  c2_q2 = c2_rho[0];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 4);
  c2_q3 = c2_rho[1];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 5);
  c2_qd2 = c2_rho[2];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 6);
  c2_qd3 = c2_rho[3];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 9);
  c2_b1 = 0.0715;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 10);
  c2_b2 = 0.0058;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 11);
  c2_b3 = 0.0114;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 12);
  c2_b4 = 0.3264;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 13);
  c2_b5 = 0.3957;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 14);
  c2_b6 = 0.6253;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 15);
  c2_b7 = 0.0749;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 16);
  c2_b8 = 0.0705;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 17);
  c2_b9 = 1.1261;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 18);
  c2_b[0] = c2_b1;
  c2_b[1] = c2_b2;
  c2_b[2] = c2_b3;
  c2_b[3] = c2_b4;
  c2_b[4] = c2_b5;
  c2_b[5] = c2_b6;
  c2_b[6] = c2_b7;
  c2_b[7] = c2_b8;
  c2_b[8] = c2_b9;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 21);
  c2_x = -c2_q2 + c2_q3;
  c2_b_x = c2_x;
  c2_b_x = muDoubleScalarCos(c2_b_x);
  c2_b_b = c2_b_x;
  c2_y = 0.0749 * c2_b_b;
  c2_a = c2_y;
  c2_b_y = c2_a * 0.0114;
  c2_c_x = -c2_q2 + c2_q3;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarCos(c2_d_x);
  c2_c_b = c2_d_x;
  c2_c_y = 0.0058 * c2_c_b;
  c2_b_a = c2_c_y;
  c2_d_y = c2_b_a * 0.0114;
  c2_e_x = -c2_q2 + c2_q3;
  c2_f_x = c2_e_x;
  c2_f_x = muDoubleScalarCos(c2_f_x);
  c2_c_a = c2_mpower(chartInstance, c2_f_x);
  c2_e_y = c2_c_a * 0.00012996;
  c2_g_x = -c2_q2 + c2_q3;
  c2_h_x = c2_g_x;
  c2_h_x = muDoubleScalarCos(c2_h_x);
  c2_d_a = c2_h_x;
  c2_f_y = c2_d_a * 0.0114;
  c2_e_a = c2_f_y;
  c2_g_y = c2_e_a * 0.0705;
  c2_v = ((((0.0053553499999999992 + c2_b_y) - c2_d_y) + 0.00040889999999999991)
          - c2_e_y) + c2_g_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 23);
  c2_B = c2_v;
  c2_h_y = c2_B;
  c2_i_y = c2_h_y;
  c2_theta1 = 1.0 / c2_i_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 24);
  c2_i_x = -c2_q2 + c2_q3;
  c2_j_x = c2_i_x;
  c2_j_x = muDoubleScalarSin(c2_j_x);
  c2_f_a = c2_qd2;
  c2_d_b = c2_j_x;
  c2_j_y = c2_f_a * c2_d_b;
  c2_A = c2_j_y;
  c2_b_B = c2_v;
  c2_k_x = c2_A;
  c2_k_y = c2_b_B;
  c2_l_x = c2_k_x;
  c2_l_y = c2_k_y;
  c2_theta2 = c2_l_x / c2_l_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 25);
  c2_m_x = -c2_q2 + c2_q3;
  c2_n_x = c2_m_x;
  c2_n_x = muDoubleScalarCos(c2_n_x);
  c2_b_A = c2_n_x;
  c2_c_B = c2_v;
  c2_o_x = c2_b_A;
  c2_m_y = c2_c_B;
  c2_p_x = c2_o_x;
  c2_n_y = c2_m_y;
  c2_theta3 = c2_p_x / c2_n_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 26);
  c2_q_x = -c2_q2 + c2_q3;
  c2_r_x = c2_q_x;
  c2_r_x = muDoubleScalarCos(c2_r_x);
  c2_g_a = c2_qd2;
  c2_e_b = c2_r_x;
  c2_o_y = c2_g_a * c2_e_b;
  c2_s_x = -c2_q2 + c2_q3;
  c2_t_x = c2_s_x;
  c2_t_x = muDoubleScalarSin(c2_t_x);
  c2_h_a = c2_o_y;
  c2_f_b = c2_t_x;
  c2_p_y = c2_h_a * c2_f_b;
  c2_c_A = c2_p_y;
  c2_d_B = c2_v;
  c2_u_x = c2_c_A;
  c2_q_y = c2_d_B;
  c2_v_x = c2_u_x;
  c2_r_y = c2_q_y;
  c2_theta4 = c2_v_x / c2_r_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 27);
  c2_w_x = -c2_q2 + c2_q3;
  c2_x_x = c2_w_x;
  c2_x_x = muDoubleScalarSin(c2_x_x);
  c2_i_a = c2_qd3;
  c2_g_b = c2_x_x;
  c2_s_y = c2_i_a * c2_g_b;
  c2_d_A = c2_s_y;
  c2_e_B = c2_v;
  c2_y_x = c2_d_A;
  c2_t_y = c2_e_B;
  c2_ab_x = c2_y_x;
  c2_u_y = c2_t_y;
  c2_theta6 = c2_ab_x / c2_u_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 28);
  c2_bb_x = -c2_q2 + c2_q3;
  c2_cb_x = c2_bb_x;
  c2_cb_x = muDoubleScalarCos(c2_cb_x);
  c2_j_a = c2_qd3;
  c2_h_b = c2_cb_x;
  c2_v_y = c2_j_a * c2_h_b;
  c2_db_x = -c2_q2 + c2_q3;
  c2_eb_x = c2_db_x;
  c2_eb_x = muDoubleScalarSin(c2_eb_x);
  c2_k_a = c2_v_y;
  c2_i_b = c2_eb_x;
  c2_w_y = c2_k_a * c2_i_b;
  c2_e_A = c2_w_y;
  c2_f_B = c2_v;
  c2_fb_x = c2_e_A;
  c2_x_y = c2_f_B;
  c2_gb_x = c2_fb_x;
  c2_y_y = c2_x_y;
  c2_theta10 = c2_gb_x / c2_y_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 30);
  if (CV_EML_IF(0, 1, 0, c2_q2 == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 31);
    c2_g_B = c2_v;
    c2_ab_y = c2_g_B;
    c2_bb_y = c2_ab_y;
    c2_theta5 = 1.0 / c2_bb_y;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 33);
    c2_hb_x = c2_q2;
    c2_ib_x = c2_hb_x;
    c2_ib_x = muDoubleScalarSin(c2_ib_x);
    c2_f_A = c2_ib_x;
    c2_h_B = c2_q2;
    c2_jb_x = c2_f_A;
    c2_cb_y = c2_h_B;
    c2_kb_x = c2_jb_x;
    c2_db_y = c2_cb_y;
    c2_eb_y = c2_kb_x / c2_db_y;
    c2_g_A = c2_eb_y;
    c2_i_B = c2_v;
    c2_lb_x = c2_g_A;
    c2_fb_y = c2_i_B;
    c2_mb_x = c2_lb_x;
    c2_gb_y = c2_fb_y;
    c2_theta5 = c2_mb_x / c2_gb_y;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 36);
  if (CV_EML_IF(0, 1, 1, c2_q3 == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 37);
    c2_j_B = c2_v;
    c2_hb_y = c2_j_B;
    c2_ib_y = c2_hb_y;
    c2_theta7 = 1.0 / c2_ib_y;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 39);
    c2_nb_x = c2_q3;
    c2_ob_x = c2_nb_x;
    c2_ob_x = muDoubleScalarSin(c2_ob_x);
    c2_h_A = c2_ob_x;
    c2_k_B = c2_q3;
    c2_pb_x = c2_h_A;
    c2_jb_y = c2_k_B;
    c2_qb_x = c2_pb_x;
    c2_kb_y = c2_jb_y;
    c2_lb_y = c2_qb_x / c2_kb_y;
    c2_i_A = c2_lb_y;
    c2_l_B = c2_v;
    c2_rb_x = c2_i_A;
    c2_mb_y = c2_l_B;
    c2_sb_x = c2_rb_x;
    c2_nb_y = c2_mb_y;
    c2_theta7 = c2_sb_x / c2_nb_y;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 42);
  if (CV_EML_IF(0, 1, 2, c2_q3 == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 43);
    c2_tb_x = -c2_q2 + c2_q3;
    c2_ub_x = c2_tb_x;
    c2_ub_x = muDoubleScalarCos(c2_ub_x);
    c2_j_A = c2_ub_x;
    c2_m_B = c2_v;
    c2_vb_x = c2_j_A;
    c2_ob_y = c2_m_B;
    c2_wb_x = c2_vb_x;
    c2_pb_y = c2_ob_y;
    c2_theta8 = c2_wb_x / c2_pb_y;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 45);
    c2_xb_x = c2_q3;
    c2_yb_x = c2_xb_x;
    c2_yb_x = muDoubleScalarSin(c2_yb_x);
    c2_k_A = c2_yb_x;
    c2_n_B = c2_q3;
    c2_ac_x = c2_k_A;
    c2_qb_y = c2_n_B;
    c2_bc_x = c2_ac_x;
    c2_rb_y = c2_qb_y;
    c2_sb_y = c2_bc_x / c2_rb_y;
    c2_cc_x = -c2_q2 + c2_q3;
    c2_dc_x = c2_cc_x;
    c2_dc_x = muDoubleScalarCos(c2_dc_x);
    c2_l_a = c2_sb_y;
    c2_j_b = c2_dc_x;
    c2_tb_y = c2_l_a * c2_j_b;
    c2_l_A = c2_tb_y;
    c2_o_B = c2_v;
    c2_ec_x = c2_l_A;
    c2_ub_y = c2_o_B;
    c2_fc_x = c2_ec_x;
    c2_vb_y = c2_ub_y;
    c2_theta8 = c2_fc_x / c2_vb_y;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 48);
  if (CV_EML_IF(0, 1, 3, c2_q2 == 0.0)) {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 49);
    c2_gc_x = -c2_q2 + c2_q3;
    c2_hc_x = c2_gc_x;
    c2_hc_x = muDoubleScalarCos(c2_hc_x);
    c2_m_A = c2_hc_x;
    c2_p_B = c2_v;
    c2_ic_x = c2_m_A;
    c2_wb_y = c2_p_B;
    c2_jc_x = c2_ic_x;
    c2_xb_y = c2_wb_y;
    c2_theta9 = c2_jc_x / c2_xb_y;
  } else {
    _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 51);
    c2_kc_x = c2_q2;
    c2_lc_x = c2_kc_x;
    c2_lc_x = muDoubleScalarSin(c2_lc_x);
    c2_n_A = c2_lc_x;
    c2_q_B = c2_q2;
    c2_mc_x = c2_n_A;
    c2_yb_y = c2_q_B;
    c2_nc_x = c2_mc_x;
    c2_ac_y = c2_yb_y;
    c2_bc_y = c2_nc_x / c2_ac_y;
    c2_oc_x = -c2_q2 + c2_q3;
    c2_pc_x = c2_oc_x;
    c2_pc_x = muDoubleScalarCos(c2_pc_x);
    c2_m_a = c2_bc_y;
    c2_k_b = c2_pc_x;
    c2_cc_y = c2_m_a * c2_k_b;
    c2_o_A = c2_cc_y;
    c2_r_B = c2_v;
    c2_qc_x = c2_o_A;
    c2_dc_y = c2_r_B;
    c2_rc_x = c2_qc_x;
    c2_ec_y = c2_dc_y;
    c2_theta9 = c2_rc_x / c2_ec_y;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 54);
  c2_theta[0] = c2_theta1;
  c2_theta[1] = c2_theta2;
  c2_theta[2] = c2_theta3;
  c2_theta[3] = c2_theta4;
  c2_theta[4] = c2_theta5;
  c2_theta[5] = c2_theta6;
  c2_theta[6] = c2_theta7;
  c2_theta[7] = c2_theta8;
  c2_theta[8] = c2_theta9;
  c2_theta[9] = c2_theta10;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -54);
  sf_debug_symbol_scope_pop();
  for (c2_i5 = 0; c2_i5 < 10; c2_i5++) {
    (*c2_b_theta)[c2_i5] = c2_theta[c2_i5];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
}

static void initSimStructsc2_Robot_model_LPV_control
  (SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber)
{
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i6;
  real_T c2_b_inData[10];
  int32_T c2_i7;
  real_T c2_u[10];
  const mxArray *c2_y = NULL;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i6 = 0; c2_i6 < 10; c2_i6++) {
    c2_b_inData[c2_i6] = (*(real_T (*)[10])c2_inData)[c2_i6];
  }

  for (c2_i7 = 0; c2_i7 < 10; c2_i7++) {
    c2_u[c2_i7] = c2_b_inData[c2_i7];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 10), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_theta, const char_T *c2_identifier, real_T
  c2_y[10])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_theta), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_theta);
}

static void c2_b_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[10])
{
  real_T c2_dv1[10];
  int32_T c2_i8;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv1, 1, 0, 0U, 1, 0U, 1, 10);
  for (c2_i8 = 0; c2_i8 < 10; c2_i8++) {
    c2_y[c2_i8] = c2_dv1[c2_i8];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_theta;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[10];
  int32_T c2_i9;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_theta = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_theta), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_theta);
  for (c2_i9 = 0; c2_i9 < 10; c2_i9++) {
    (*(real_T (*)[10])c2_outData)[c2_i9] = c2_y[c2_i9];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i10;
  real_T c2_b_inData[4];
  int32_T c2_i11;
  real_T c2_u[4];
  const mxArray *c2_y = NULL;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i10 = 0; c2_i10 < 4; c2_i10++) {
    c2_b_inData[c2_i10] = (*(real_T (*)[4])c2_inData)[c2_i10];
  }

  for (c2_i11 = 0; c2_i11 < 4; c2_i11++) {
    c2_u[c2_i11] = c2_b_inData[c2_i11];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 4), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static real_T c2_c_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i12;
  real_T c2_b_inData[9];
  int32_T c2_i13;
  real_T c2_u[9];
  const mxArray *c2_y = NULL;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i12 = 0; c2_i12 < 9; c2_i12++) {
    c2_b_inData[c2_i12] = (*(real_T (*)[9])c2_inData)[c2_i12];
  }

  for (c2_i13 = 0; c2_i13 < 9; c2_i13++) {
    c2_u[c2_i13] = c2_b_inData[c2_i13];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 1, 9), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_d_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[9])
{
  real_T c2_dv2[9];
  int32_T c2_i14;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv2, 1, 0, 0U, 1, 0U, 2, 1, 9);
  for (c2_i14 = 0; c2_i14 < 9; c2_i14++) {
    c2_y[c2_i14] = c2_dv2[c2_i14];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[9];
  int32_T c2_i15;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_b = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_b);
  for (c2_i15 = 0; c2_i15 < 9; c2_i15++) {
    (*(real_T (*)[9])c2_outData)[c2_i15] = c2_y[c2_i15];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray *sf_c2_Robot_model_LPV_control_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c2_nameCaptureInfo;
  c2_ResolvedFunctionInfo c2_info[13];
  const mxArray *c2_m0 = NULL;
  int32_T c2_i16;
  c2_ResolvedFunctionInfo *c2_r0;
  c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  c2_info_helper(c2_info);
  sf_mex_assign(&c2_m0, sf_mex_createstruct("nameCaptureInfo", 1, 13), FALSE);
  for (c2_i16 = 0; c2_i16 < 13; c2_i16++) {
    c2_r0 = &c2_info[c2_i16];
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->context)), "context", "nameCaptureInfo",
                    c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c2_r0->name)), "name", "nameCaptureInfo", c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c2_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->resolved)), "resolved", "nameCaptureInfo",
                    c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c2_i16);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c2_i16);
  }

  sf_mex_assign(&c2_nameCaptureInfo, c2_m0, FALSE);
  return c2_nameCaptureInfo;
}

static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[13])
{
  c2_info[0].context = "";
  c2_info[0].name = "mtimes";
  c2_info[0].dominantType = "double";
  c2_info[0].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[0].fileTimeLo = 1289519692U;
  c2_info[0].fileTimeHi = 0U;
  c2_info[0].mFileTimeLo = 0U;
  c2_info[0].mFileTimeHi = 0U;
  c2_info[1].context = "";
  c2_info[1].name = "cos";
  c2_info[1].dominantType = "double";
  c2_info[1].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/cos.m";
  c2_info[1].fileTimeLo = 1286818706U;
  c2_info[1].fileTimeHi = 0U;
  c2_info[1].mFileTimeLo = 0U;
  c2_info[1].mFileTimeHi = 0U;
  c2_info[2].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/cos.m";
  c2_info[2].name = "eml_scalar_cos";
  c2_info[2].dominantType = "double";
  c2_info[2].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_cos.m";
  c2_info[2].fileTimeLo = 1286818722U;
  c2_info[2].fileTimeHi = 0U;
  c2_info[2].mFileTimeLo = 0U;
  c2_info[2].mFileTimeHi = 0U;
  c2_info[3].context = "";
  c2_info[3].name = "mpower";
  c2_info[3].dominantType = "double";
  c2_info[3].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c2_info[3].fileTimeLo = 1286818842U;
  c2_info[3].fileTimeHi = 0U;
  c2_info[3].mFileTimeLo = 0U;
  c2_info[3].mFileTimeHi = 0U;
  c2_info[4].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c2_info[4].name = "power";
  c2_info[4].dominantType = "double";
  c2_info[4].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c2_info[4].fileTimeLo = 1294067944U;
  c2_info[4].fileTimeHi = 0U;
  c2_info[4].mFileTimeLo = 0U;
  c2_info[4].mFileTimeHi = 0U;
  c2_info[5].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c2_info[5].name = "eml_scalar_eg";
  c2_info[5].dominantType = "double";
  c2_info[5].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[5].fileTimeLo = 1286818796U;
  c2_info[5].fileTimeHi = 0U;
  c2_info[5].mFileTimeLo = 0U;
  c2_info[5].mFileTimeHi = 0U;
  c2_info[6].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c2_info[6].name = "eml_scalexp_alloc";
  c2_info[6].dominantType = "double";
  c2_info[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c2_info[6].fileTimeLo = 1286818796U;
  c2_info[6].fileTimeHi = 0U;
  c2_info[6].mFileTimeLo = 0U;
  c2_info[6].mFileTimeHi = 0U;
  c2_info[7].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c2_info[7].name = "eml_scalar_floor";
  c2_info[7].dominantType = "double";
  c2_info[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c2_info[7].fileTimeLo = 1286818726U;
  c2_info[7].fileTimeHi = 0U;
  c2_info[7].mFileTimeLo = 0U;
  c2_info[7].mFileTimeHi = 0U;
  c2_info[8].context = "";
  c2_info[8].name = "mrdivide";
  c2_info[8].dominantType = "double";
  c2_info[8].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c2_info[8].fileTimeLo = 1310137456U;
  c2_info[8].fileTimeHi = 0U;
  c2_info[8].mFileTimeLo = 1289519692U;
  c2_info[8].mFileTimeHi = 0U;
  c2_info[9].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c2_info[9].name = "rdivide";
  c2_info[9].dominantType = "double";
  c2_info[9].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[9].fileTimeLo = 1286818844U;
  c2_info[9].fileTimeHi = 0U;
  c2_info[9].mFileTimeLo = 0U;
  c2_info[9].mFileTimeHi = 0U;
  c2_info[10].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[10].name = "eml_div";
  c2_info[10].dominantType = "double";
  c2_info[10].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c2_info[10].fileTimeLo = 1305318000U;
  c2_info[10].fileTimeHi = 0U;
  c2_info[10].mFileTimeLo = 0U;
  c2_info[10].mFileTimeHi = 0U;
  c2_info[11].context = "";
  c2_info[11].name = "sin";
  c2_info[11].dominantType = "double";
  c2_info[11].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sin.m";
  c2_info[11].fileTimeLo = 1286818750U;
  c2_info[11].fileTimeHi = 0U;
  c2_info[11].mFileTimeLo = 0U;
  c2_info[11].mFileTimeHi = 0U;
  c2_info[12].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sin.m";
  c2_info[12].name = "eml_scalar_sin";
  c2_info[12].dominantType = "double";
  c2_info[12].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sin.m";
  c2_info[12].fileTimeLo = 1286818736U;
  c2_info[12].fileTimeHi = 0U;
  c2_info[12].mFileTimeLo = 0U;
  c2_info[12].mFileTimeHi = 0U;
}

static real_T c2_mpower(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance, real_T c2_a)
{
  real_T c2_b_a;
  real_T c2_ak;
  c2_b_a = c2_a;
  c2_ak = c2_b_a;
  return muDoubleScalarPower(c2_ak, 2.0);
}

static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static int32_T c2_e_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i17;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i17, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i17;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
    chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_f_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_b_is_active_c2_Robot_model_LPV_control, const
  char_T *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_g_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_Robot_model_LPV_control), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_Robot_model_LPV_control);
  return c2_y;
}

static uint8_T c2_g_emlrt_marshallIn(SFc2_Robot_model_LPV_controlInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info(SFc2_Robot_model_LPV_controlInstanceStruct
  *chartInstance)
{
}

/* SFunction Glue Code */
void sf_c2_Robot_model_LPV_control_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(22993926U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1417147968U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3990104007U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3825895056U);
}

mxArray *sf_c2_Robot_model_LPV_control_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("Vr4Cm801KJKbbBQpRdCYjB");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(4);
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
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

static const mxArray *sf_get_sim_state_info_c2_Robot_model_LPV_control(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"theta\",},{M[8],M[0],T\"is_active_c2_Robot_model_LPV_control\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_Robot_model_LPV_control_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
    chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)
      ((ChartInfoStruct *)(ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (_Robot_model_LPV_controlMachineNumber_,
           2,
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
          init_script_number_translation(_Robot_model_LPV_controlMachineNumber_,
            chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (_Robot_model_LPV_controlMachineNumber_,chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds
            (_Robot_model_LPV_controlMachineNumber_,
             chartInstance->chartNumber,
             0,
             0,
             0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"rho");
          _SFD_SET_DATA_PROPS(1,2,0,1,"theta");
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
        _SFD_CV_INIT_EML(0,1,1,4,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,1091);
        _SFD_CV_INIT_EML_IF(0,1,0,585,595,614,649);
        _SFD_CV_INIT_EML_IF(0,1,1,651,661,680,715);
        _SFD_CV_INIT_EML_IF(0,1,2,717,727,756,803);
        _SFD_CV_INIT_EML_IF(0,1,3,805,815,844,891);
        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 4;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 10;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }

        {
          real_T (*c2_rho)[4];
          real_T (*c2_theta)[10];
          c2_theta = (real_T (*)[10])ssGetOutputPortSignal(chartInstance->S, 1);
          c2_rho = (real_T (*)[4])ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, *c2_rho);
          _SFD_SET_DATA_VALUE_PTR(1U, *c2_theta);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration
        (_Robot_model_LPV_controlMachineNumber_,chartInstance->chartNumber,
         chartInstance->instanceNumber);
    }
  }
}

static void sf_opaque_initialize_c2_Robot_model_LPV_control(void
  *chartInstanceVar)
{
  chart_debug_initialization(((SFc2_Robot_model_LPV_controlInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c2_Robot_model_LPV_control
    ((SFc2_Robot_model_LPV_controlInstanceStruct*) chartInstanceVar);
  initialize_c2_Robot_model_LPV_control
    ((SFc2_Robot_model_LPV_controlInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_Robot_model_LPV_control(void *chartInstanceVar)
{
  enable_c2_Robot_model_LPV_control((SFc2_Robot_model_LPV_controlInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c2_Robot_model_LPV_control(void *chartInstanceVar)
{
  disable_c2_Robot_model_LPV_control((SFc2_Robot_model_LPV_controlInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c2_Robot_model_LPV_control(void *chartInstanceVar)
{
  sf_c2_Robot_model_LPV_control((SFc2_Robot_model_LPV_controlInstanceStruct*)
    chartInstanceVar);
}

extern const mxArray* sf_internal_get_sim_state_c2_Robot_model_LPV_control
  (SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c2_Robot_model_LPV_control
    ((SFc2_Robot_model_LPV_controlInstanceStruct*)chartInfo->chartInstance);/* raw sim ctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c2_Robot_model_LPV_control();/* state var info */
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

extern void sf_internal_set_sim_state_c2_Robot_model_LPV_control(SimStruct* S,
  const mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c2_Robot_model_LPV_control();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c2_Robot_model_LPV_control
    ((SFc2_Robot_model_LPV_controlInstanceStruct*)chartInfo->chartInstance,
     mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray* sf_opaque_get_sim_state_c2_Robot_model_LPV_control
  (SimStruct* S)
{
  return sf_internal_get_sim_state_c2_Robot_model_LPV_control(S);
}

static void sf_opaque_set_sim_state_c2_Robot_model_LPV_control(SimStruct* S,
  const mxArray *st)
{
  sf_internal_set_sim_state_c2_Robot_model_LPV_control(S, st);
}

static void sf_opaque_terminate_c2_Robot_model_LPV_control(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_Robot_model_LPV_controlInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
    }

    finalize_c2_Robot_model_LPV_control
      ((SFc2_Robot_model_LPV_controlInstanceStruct*) chartInstanceVar);
    free((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }

  unload_Robot_model_LPV_control_optimization_info();
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_Robot_model_LPV_control
    ((SFc2_Robot_model_LPV_controlInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_Robot_model_LPV_control(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_Robot_model_LPV_control
      ((SFc2_Robot_model_LPV_controlInstanceStruct*)(((ChartInfoStruct *)
         ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_Robot_model_LPV_control(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_Robot_model_LPV_control_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,infoStruct,2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,infoStruct,2,
      "gatewayCannotBeInlinedMultipleTimes"));
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,infoStruct,2,1);
      sf_mark_chart_reusable_outputs(S,infoStruct,2,1);
    }

    sf_set_rtw_dwork_info(S,infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(462755990U));
  ssSetChecksum1(S,(2172795420U));
  ssSetChecksum2(S,(2688671049U));
  ssSetChecksum3(S,(296768003U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
}

static void mdlRTW_c2_Robot_model_LPV_control(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_Robot_model_LPV_control(SimStruct *S)
{
  SFc2_Robot_model_LPV_controlInstanceStruct *chartInstance;
  chartInstance = (SFc2_Robot_model_LPV_controlInstanceStruct *)malloc(sizeof
    (SFc2_Robot_model_LPV_controlInstanceStruct));
  memset(chartInstance, 0, sizeof(SFc2_Robot_model_LPV_controlInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.mdlStart = mdlStart_c2_Robot_model_LPV_control;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_Robot_model_LPV_control;
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

void c2_Robot_model_LPV_control_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_Robot_model_LPV_control(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_Robot_model_LPV_control(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_Robot_model_LPV_control(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_Robot_model_LPV_control_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
