/* Include files */

#include "Robot_model_LPV_control_reducedSchedulingOrder_sfun.h"
#include "c3_Robot_model_LPV_control_reducedSchedulingOrder.h"
#include "c4_Robot_model_LPV_control_reducedSchedulingOrder.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
uint32_T _Robot_model_LPV_control_reducedSchedulingOrderMachineNumber_;
real_T _sfTime_;

/* Function Declarations */

/* Function Definitions */
void Robot_model_LPV_control_reducedSchedulingOrder_initializer(void)
{
}

void Robot_model_LPV_control_reducedSchedulingOrder_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_Robot_model_LPV_control_reducedSchedulingOrder_method_dispatcher
  (SimStruct *simstructPtr, unsigned int chartFileNumber, const char* specsCksum,
   int_T method, void *data)
{
  if (chartFileNumber==3) {
    c3_Robot_model_LPV_control_reducedSchedulingOrder_method_dispatcher
      (simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==4) {
    c4_Robot_model_LPV_control_reducedSchedulingOrder_method_dispatcher
      (simstructPtr, method, data);
    return 1;
  }

  return 0;
}

unsigned int
  sf_Robot_model_LPV_control_reducedSchedulingOrder_process_check_sum_call( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1887869021U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3117450928U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2226164784U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(487243795U);
    } else if (!strcmp(commandName,"exportedFcn")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0U);
    } else if (!strcmp(commandName,"makefile")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3806928196U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1946809663U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3034618894U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3471711856U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 3:
        {
          extern void
            sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_check_sum
            (mxArray *plhs[]);
          sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_check_sum
            (plhs);
          break;
        }

       case 4:
        {
          extern void
            sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_check_sum
            (mxArray *plhs[]);
          sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_check_sum
            (plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3564696471U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(678668628U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1090454852U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3896867807U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1350542070U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(258166770U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1081471754U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(616073495U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int
  sf_Robot_model_LPV_control_reducedSchedulingOrder_autoinheritance_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[32];
  char aiChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the autoinheritance_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_autoinheritance_info"))
    return 0;
  mxGetString(prhs[2], aiChksum,sizeof(aiChksum)/sizeof(char));
  aiChksum[(sizeof(aiChksum)/sizeof(char)-1)] = '\0';

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        if (strcmp(aiChksum, "Xbo5Ydnci8M9j1j5lS3RwF") == 0) {
          extern mxArray
            *sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 4:
      {
        if (strcmp(aiChksum, "bsQYN5vLmyiqBx2TfB6JfF") == 0) {
          extern mxArray
            *sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int
  sf_Robot_model_LPV_control_reducedSchedulingOrder_get_eml_resolved_functions_info
  ( int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  if (nrhs<2 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        extern const mxArray
          *sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c3_Robot_model_LPV_control_reducedSchedulingOrder_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 4:
      {
        extern const mxArray
          *sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c4_Robot_model_LPV_control_reducedSchedulingOrder_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

void Robot_model_LPV_control_reducedSchedulingOrder_debug_initialize(void)
{
  _Robot_model_LPV_control_reducedSchedulingOrderMachineNumber_ =
    sf_debug_initialize_machine("Robot_model_LPV_control_reducedSchedulingOrder",
    "sfun",0,2,0,0,0);
  sf_debug_set_machine_event_thresholds
    (_Robot_model_LPV_control_reducedSchedulingOrderMachineNumber_,0,0);
  sf_debug_set_machine_data_thresholds
    (_Robot_model_LPV_control_reducedSchedulingOrderMachineNumber_,0);
}

void Robot_model_LPV_control_reducedSchedulingOrder_register_exported_symbols
  (SimStruct* S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
mxArray* load_Robot_model_LPV_control_reducedSchedulingOrder_optimization_info
  (void)
{
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info(
      "Robot_model_LPV_control_reducedSchedulingOrder",
      "Robot_model_LPV_control_reducedSchedulingOrder");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_Robot_model_LPV_control_reducedSchedulingOrder_optimization_info
  (void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
