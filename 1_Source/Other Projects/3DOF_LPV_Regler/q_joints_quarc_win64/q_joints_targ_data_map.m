  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 6;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (q_joints_P)
    ;%
      section.nData     = 24;
      section.data(24)  = dumData; %prealloc
      
	  ;% q_joints_P.Kd
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.Kp
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 6;
	
	  ;% q_joints_P.con_gain
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 12;
	
	  ;% q_joints_P.HILInitialize_analog_input_maxi
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 13;
	
	  ;% q_joints_P.HILInitialize_analog_input_mini
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 14;
	
	  ;% q_joints_P.HILInitialize_analog_output_max
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 15;
	
	  ;% q_joints_P.HILInitialize_analog_output_min
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 16;
	
	  ;% q_joints_P.CompareToConstant_const
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 17;
	
	  ;% q_joints_P.CompareToConstant_const_h
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 18;
	
	  ;% q_joints_P.CompareToConstant_const_o
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 19;
	
	  ;% q_joints_P.CompareToConstant1_const
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 20;
	
	  ;% q_joints_P.HILInitialize_encoder_filter_fr
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 21;
	
	  ;% q_joints_P.HILInitialize_final_analog_outp
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 22;
	
	  ;% q_joints_P.HILInitialize_final_pwm_outputs
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 30;
	
	  ;% q_joints_P.HILInitialize_initial_analog_ou
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 31;
	
	  ;% q_joints_P.HILInitialize_initial_pwm_outpu
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 39;
	
	  ;% q_joints_P.HILInitialize_pwm_frequency
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 40;
	
	  ;% q_joints_P.HILInitialize_set_other_outputs
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 41;
	
	  ;% q_joints_P.HILInitialize_set_other_outpu_k
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 42;
	
	  ;% q_joints_P.HILInitialize_set_other_outpu_b
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 43;
	
	  ;% q_joints_P.HILInitialize_set_other_outpu_n
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 44;
	
	  ;% q_joints_P.HILInitialize_watchdog_analog_o
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 45;
	
	  ;% q_joints_P.HILInitialize_watchdog_other_ou
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 46;
	
	  ;% q_joints_P.HILInitialize_watchdog_pwm_outp
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 47;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
      section.nData     = 7;
      section.data(7)  = dumData; %prealloc
      
	  ;% q_joints_P.HILReadEncoderTimebase1_clock
	  section.data(1).logicalSrcIdx = 24;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.HILInitialize_clock_modes
	  section.data(2).logicalSrcIdx = 25;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_P.HILSetEncoderCounts_counts
	  section.data(3).logicalSrcIdx = 26;
	  section.data(3).dtTransOffset = 3;
	
	  ;% q_joints_P.HILInitialize_hardware_clocks
	  section.data(4).logicalSrcIdx = 27;
	  section.data(4).dtTransOffset = 9;
	
	  ;% q_joints_P.HILInitialize_initial_encoder_c
	  section.data(5).logicalSrcIdx = 28;
	  section.data(5).dtTransOffset = 11;
	
	  ;% q_joints_P.HILInitialize_pwm_modes
	  section.data(6).logicalSrcIdx = 29;
	  section.data(6).dtTransOffset = 12;
	
	  ;% q_joints_P.HILInitialize_watchdog_digital_
	  section.data(7).logicalSrcIdx = 30;
	  section.data(7).dtTransOffset = 13;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(2) = section;
      clear section
      
      section.nData     = 16;
      section.data(16)  = dumData; %prealloc
      
	  ;% q_joints_P.HILInitialize_analog_input_chan
	  section.data(1).logicalSrcIdx = 31;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.HILInitialize_analog_output_cha
	  section.data(2).logicalSrcIdx = 32;
	  section.data(2).dtTransOffset = 8;
	
	  ;% q_joints_P.HILSetEncoderCounts_channels
	  section.data(3).logicalSrcIdx = 33;
	  section.data(3).dtTransOffset = 16;
	
	  ;% q_joints_P.HILReadEncoderTimebase1_channel
	  section.data(4).logicalSrcIdx = 34;
	  section.data(4).dtTransOffset = 22;
	
	  ;% q_joints_P.Takover_channels
	  section.data(5).logicalSrcIdx = 35;
	  section.data(5).dtTransOffset = 28;
	
	  ;% q_joints_P.EnableAmps_channels
	  section.data(6).logicalSrcIdx = 36;
	  section.data(6).dtTransOffset = 29;
	
	  ;% q_joints_P.HILWriteAnalog_channels
	  section.data(7).logicalSrcIdx = 37;
	  section.data(7).dtTransOffset = 30;
	
	  ;% q_joints_P.HILWriteAnalog1_channels
	  section.data(8).logicalSrcIdx = 38;
	  section.data(8).dtTransOffset = 31;
	
	  ;% q_joints_P.HILWriteAnalog_channels_l
	  section.data(9).logicalSrcIdx = 39;
	  section.data(9).dtTransOffset = 32;
	
	  ;% q_joints_P.HILWriteAnalog_channels_h
	  section.data(10).logicalSrcIdx = 40;
	  section.data(10).dtTransOffset = 33;
	
	  ;% q_joints_P.HILWriteAnalog_channels_f
	  section.data(11).logicalSrcIdx = 41;
	  section.data(11).dtTransOffset = 34;
	
	  ;% q_joints_P.HILWriteAnalog_channels_lh
	  section.data(12).logicalSrcIdx = 42;
	  section.data(12).dtTransOffset = 35;
	
	  ;% q_joints_P.HILInitialize_digital_output_ch
	  section.data(13).logicalSrcIdx = 43;
	  section.data(13).dtTransOffset = 36;
	
	  ;% q_joints_P.HILInitialize_encoder_channels
	  section.data(14).logicalSrcIdx = 44;
	  section.data(14).dtTransOffset = 37;
	
	  ;% q_joints_P.HILInitialize_quadrature
	  section.data(15).logicalSrcIdx = 45;
	  section.data(15).dtTransOffset = 45;
	
	  ;% q_joints_P.HILReadEncoderTimebase1_samples
	  section.data(16).logicalSrcIdx = 46;
	  section.data(16).dtTransOffset = 46;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(3) = section;
      clear section
      
      section.nData     = 35;
      section.data(35)  = dumData; %prealloc
      
	  ;% q_joints_P.HILInitialize_active
	  section.data(1).logicalSrcIdx = 47;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.HILInitialize_final_digital_out
	  section.data(2).logicalSrcIdx = 48;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_P.HILInitialize_initial_digital_o
	  section.data(3).logicalSrcIdx = 49;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_P.HILInitialize_set_analog_input_
	  section.data(4).logicalSrcIdx = 50;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_P.HILInitialize_set_analog_inpu_c
	  section.data(5).logicalSrcIdx = 51;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_P.HILInitialize_set_analog_output
	  section.data(6).logicalSrcIdx = 52;
	  section.data(6).dtTransOffset = 5;
	
	  ;% q_joints_P.HILInitialize_set_analog_outp_j
	  section.data(7).logicalSrcIdx = 53;
	  section.data(7).dtTransOffset = 6;
	
	  ;% q_joints_P.HILInitialize_set_analog_outp_i
	  section.data(8).logicalSrcIdx = 54;
	  section.data(8).dtTransOffset = 7;
	
	  ;% q_joints_P.HILInitialize_set_analog_outp_l
	  section.data(9).logicalSrcIdx = 55;
	  section.data(9).dtTransOffset = 8;
	
	  ;% q_joints_P.HILInitialize_set_analog_out_lc
	  section.data(10).logicalSrcIdx = 56;
	  section.data(10).dtTransOffset = 9;
	
	  ;% q_joints_P.HILInitialize_set_analog_outp_a
	  section.data(11).logicalSrcIdx = 57;
	  section.data(11).dtTransOffset = 10;
	
	  ;% q_joints_P.HILInitialize_set_analog_outp_p
	  section.data(12).logicalSrcIdx = 58;
	  section.data(12).dtTransOffset = 11;
	
	  ;% q_joints_P.HILInitialize_set_clock_frequen
	  section.data(13).logicalSrcIdx = 59;
	  section.data(13).dtTransOffset = 12;
	
	  ;% q_joints_P.HILInitialize_set_clock_frequ_p
	  section.data(14).logicalSrcIdx = 60;
	  section.data(14).dtTransOffset = 13;
	
	  ;% q_joints_P.HILInitialize_set_clock_params_
	  section.data(15).logicalSrcIdx = 61;
	  section.data(15).dtTransOffset = 14;
	
	  ;% q_joints_P.HILInitialize_set_clock_param_b
	  section.data(16).logicalSrcIdx = 62;
	  section.data(16).dtTransOffset = 15;
	
	  ;% q_joints_P.HILInitialize_set_digital_outpu
	  section.data(17).logicalSrcIdx = 63;
	  section.data(17).dtTransOffset = 16;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_f
	  section.data(18).logicalSrcIdx = 64;
	  section.data(18).dtTransOffset = 17;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_e
	  section.data(19).logicalSrcIdx = 65;
	  section.data(19).dtTransOffset = 18;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_m
	  section.data(20).logicalSrcIdx = 66;
	  section.data(20).dtTransOffset = 19;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_g
	  section.data(21).logicalSrcIdx = 67;
	  section.data(21).dtTransOffset = 20;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_l
	  section.data(22).logicalSrcIdx = 68;
	  section.data(22).dtTransOffset = 21;
	
	  ;% q_joints_P.HILInitialize_set_digital_out_d
	  section.data(23).logicalSrcIdx = 69;
	  section.data(23).dtTransOffset = 22;
	
	  ;% q_joints_P.HILInitialize_set_encoder_count
	  section.data(24).logicalSrcIdx = 70;
	  section.data(24).dtTransOffset = 23;
	
	  ;% q_joints_P.HILInitialize_set_encoder_cou_n
	  section.data(25).logicalSrcIdx = 71;
	  section.data(25).dtTransOffset = 24;
	
	  ;% q_joints_P.HILInitialize_set_encoder_param
	  section.data(26).logicalSrcIdx = 72;
	  section.data(26).dtTransOffset = 25;
	
	  ;% q_joints_P.HILInitialize_set_encoder_par_e
	  section.data(27).logicalSrcIdx = 73;
	  section.data(27).dtTransOffset = 26;
	
	  ;% q_joints_P.HILInitialize_set_other_outpu_g
	  section.data(28).logicalSrcIdx = 74;
	  section.data(28).dtTransOffset = 27;
	
	  ;% q_joints_P.HILInitialize_set_pwm_outputs_a
	  section.data(29).logicalSrcIdx = 75;
	  section.data(29).dtTransOffset = 28;
	
	  ;% q_joints_P.HILInitialize_set_pwm_outputs_h
	  section.data(30).logicalSrcIdx = 76;
	  section.data(30).dtTransOffset = 29;
	
	  ;% q_joints_P.HILInitialize_set_pwm_outputs_k
	  section.data(31).logicalSrcIdx = 77;
	  section.data(31).dtTransOffset = 30;
	
	  ;% q_joints_P.HILInitialize_set_pwm_output_aa
	  section.data(32).logicalSrcIdx = 78;
	  section.data(32).dtTransOffset = 31;
	
	  ;% q_joints_P.HILInitialize_set_pwm_outputs_o
	  section.data(33).logicalSrcIdx = 79;
	  section.data(33).dtTransOffset = 32;
	
	  ;% q_joints_P.HILInitialize_set_pwm_params_at
	  section.data(34).logicalSrcIdx = 80;
	  section.data(34).dtTransOffset = 33;
	
	  ;% q_joints_P.HILInitialize_set_pwm_params__k
	  section.data(35).logicalSrcIdx = 81;
	  section.data(35).dtTransOffset = 34;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(4) = section;
      clear section
      
      section.nData     = 63;
      section.data(63)  = dumData; %prealloc
      
	  ;% q_joints_P.Mode_Value
	  section.data(1).logicalSrcIdx = 82;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.Constant_Value
	  section.data(2).logicalSrcIdx = 83;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_P.Gain1_Gain
	  section.data(3).logicalSrcIdx = 84;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_P.Gain2_Gain
	  section.data(4).logicalSrcIdx = 85;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_P.Gain3_Gain
	  section.data(5).logicalSrcIdx = 86;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_P.Gain4_Gain
	  section.data(6).logicalSrcIdx = 87;
	  section.data(6).dtTransOffset = 5;
	
	  ;% q_joints_P.Gain5_Gain
	  section.data(7).logicalSrcIdx = 88;
	  section.data(7).dtTransOffset = 6;
	
	  ;% q_joints_P.Gain6_Gain
	  section.data(8).logicalSrcIdx = 89;
	  section.data(8).dtTransOffset = 7;
	
	  ;% q_joints_P.Gain_Gain
	  section.data(9).logicalSrcIdx = 90;
	  section.data(9).dtTransOffset = 8;
	
	  ;% q_joints_P.Saturation1_UpperSat
	  section.data(10).logicalSrcIdx = 91;
	  section.data(10).dtTransOffset = 9;
	
	  ;% q_joints_P.Saturation1_LowerSat
	  section.data(11).logicalSrcIdx = 92;
	  section.data(11).dtTransOffset = 10;
	
	  ;% q_joints_P.Degrees_Gain
	  section.data(12).logicalSrcIdx = 93;
	  section.data(12).dtTransOffset = 11;
	
	  ;% q_joints_P.TransferFcn_A
	  section.data(13).logicalSrcIdx = 94;
	  section.data(13).dtTransOffset = 12;
	
	  ;% q_joints_P.TransferFcn_C
	  section.data(14).logicalSrcIdx = 95;
	  section.data(14).dtTransOffset = 13;
	
	  ;% q_joints_P.TransferFcn_D
	  section.data(15).logicalSrcIdx = 96;
	  section.data(15).dtTransOffset = 14;
	
	  ;% q_joints_P.Saturation_UpperSat
	  section.data(16).logicalSrcIdx = 97;
	  section.data(16).dtTransOffset = 15;
	
	  ;% q_joints_P.Saturation_LowerSat
	  section.data(17).logicalSrcIdx = 98;
	  section.data(17).dtTransOffset = 16;
	
	  ;% q_joints_P.Saturation2_UpperSat
	  section.data(18).logicalSrcIdx = 99;
	  section.data(18).dtTransOffset = 17;
	
	  ;% q_joints_P.Saturation2_LowerSat
	  section.data(19).logicalSrcIdx = 100;
	  section.data(19).dtTransOffset = 18;
	
	  ;% q_joints_P.Degrees1_Gain
	  section.data(20).logicalSrcIdx = 101;
	  section.data(20).dtTransOffset = 19;
	
	  ;% q_joints_P.TransferFcn1_A
	  section.data(21).logicalSrcIdx = 102;
	  section.data(21).dtTransOffset = 20;
	
	  ;% q_joints_P.TransferFcn1_C
	  section.data(22).logicalSrcIdx = 103;
	  section.data(22).dtTransOffset = 21;
	
	  ;% q_joints_P.TransferFcn1_D
	  section.data(23).logicalSrcIdx = 104;
	  section.data(23).dtTransOffset = 22;
	
	  ;% q_joints_P.Saturation1_UpperSat_j
	  section.data(24).logicalSrcIdx = 105;
	  section.data(24).dtTransOffset = 23;
	
	  ;% q_joints_P.Saturation1_LowerSat_c
	  section.data(25).logicalSrcIdx = 106;
	  section.data(25).dtTransOffset = 24;
	
	  ;% q_joints_P.Saturation3_UpperSat
	  section.data(26).logicalSrcIdx = 107;
	  section.data(26).dtTransOffset = 25;
	
	  ;% q_joints_P.Saturation3_LowerSat
	  section.data(27).logicalSrcIdx = 108;
	  section.data(27).dtTransOffset = 26;
	
	  ;% q_joints_P.Degrees_Gain_o
	  section.data(28).logicalSrcIdx = 109;
	  section.data(28).dtTransOffset = 27;
	
	  ;% q_joints_P.TransferFcn_A_a
	  section.data(29).logicalSrcIdx = 110;
	  section.data(29).dtTransOffset = 28;
	
	  ;% q_joints_P.TransferFcn_C_k
	  section.data(30).logicalSrcIdx = 111;
	  section.data(30).dtTransOffset = 29;
	
	  ;% q_joints_P.TransferFcn_D_m
	  section.data(31).logicalSrcIdx = 112;
	  section.data(31).dtTransOffset = 30;
	
	  ;% q_joints_P.Saturation_UpperSat_l
	  section.data(32).logicalSrcIdx = 113;
	  section.data(32).dtTransOffset = 31;
	
	  ;% q_joints_P.Saturation_LowerSat_e
	  section.data(33).logicalSrcIdx = 114;
	  section.data(33).dtTransOffset = 32;
	
	  ;% q_joints_P.Saturation4_UpperSat
	  section.data(34).logicalSrcIdx = 115;
	  section.data(34).dtTransOffset = 33;
	
	  ;% q_joints_P.Saturation4_LowerSat
	  section.data(35).logicalSrcIdx = 116;
	  section.data(35).dtTransOffset = 34;
	
	  ;% q_joints_P.Degrees_Gain_d
	  section.data(36).logicalSrcIdx = 117;
	  section.data(36).dtTransOffset = 35;
	
	  ;% q_joints_P.TransferFcn_A_g
	  section.data(37).logicalSrcIdx = 118;
	  section.data(37).dtTransOffset = 36;
	
	  ;% q_joints_P.TransferFcn_C_a
	  section.data(38).logicalSrcIdx = 119;
	  section.data(38).dtTransOffset = 37;
	
	  ;% q_joints_P.TransferFcn_D_j
	  section.data(39).logicalSrcIdx = 120;
	  section.data(39).dtTransOffset = 38;
	
	  ;% q_joints_P.Saturation_UpperSat_k
	  section.data(40).logicalSrcIdx = 121;
	  section.data(40).dtTransOffset = 39;
	
	  ;% q_joints_P.Saturation_LowerSat_l
	  section.data(41).logicalSrcIdx = 122;
	  section.data(41).dtTransOffset = 40;
	
	  ;% q_joints_P.Saturation5_UpperSat
	  section.data(42).logicalSrcIdx = 123;
	  section.data(42).dtTransOffset = 41;
	
	  ;% q_joints_P.Saturation5_LowerSat
	  section.data(43).logicalSrcIdx = 124;
	  section.data(43).dtTransOffset = 42;
	
	  ;% q_joints_P.Degrees_Gain_k
	  section.data(44).logicalSrcIdx = 125;
	  section.data(44).dtTransOffset = 43;
	
	  ;% q_joints_P.TransferFcn_A_m
	  section.data(45).logicalSrcIdx = 126;
	  section.data(45).dtTransOffset = 44;
	
	  ;% q_joints_P.TransferFcn_C_l
	  section.data(46).logicalSrcIdx = 127;
	  section.data(46).dtTransOffset = 45;
	
	  ;% q_joints_P.TransferFcn_D_k
	  section.data(47).logicalSrcIdx = 128;
	  section.data(47).dtTransOffset = 46;
	
	  ;% q_joints_P.Saturation_UpperSat_b
	  section.data(48).logicalSrcIdx = 129;
	  section.data(48).dtTransOffset = 47;
	
	  ;% q_joints_P.Saturation_LowerSat_i
	  section.data(49).logicalSrcIdx = 130;
	  section.data(49).dtTransOffset = 48;
	
	  ;% q_joints_P.Saturation6_UpperSat
	  section.data(50).logicalSrcIdx = 131;
	  section.data(50).dtTransOffset = 49;
	
	  ;% q_joints_P.Saturation6_LowerSat
	  section.data(51).logicalSrcIdx = 132;
	  section.data(51).dtTransOffset = 50;
	
	  ;% q_joints_P.Degrees_Gain_kt
	  section.data(52).logicalSrcIdx = 133;
	  section.data(52).dtTransOffset = 51;
	
	  ;% q_joints_P.TransferFcn_A_p
	  section.data(53).logicalSrcIdx = 134;
	  section.data(53).dtTransOffset = 52;
	
	  ;% q_joints_P.TransferFcn_C_kh
	  section.data(54).logicalSrcIdx = 135;
	  section.data(54).dtTransOffset = 53;
	
	  ;% q_joints_P.TransferFcn_D_d
	  section.data(55).logicalSrcIdx = 136;
	  section.data(55).dtTransOffset = 54;
	
	  ;% q_joints_P.Saturation_UpperSat_n
	  section.data(56).logicalSrcIdx = 137;
	  section.data(56).dtTransOffset = 55;
	
	  ;% q_joints_P.Saturation_LowerSat_f
	  section.data(57).logicalSrcIdx = 138;
	  section.data(57).dtTransOffset = 56;
	
	  ;% q_joints_P.Sign1_Gain
	  section.data(58).logicalSrcIdx = 139;
	  section.data(58).dtTransOffset = 57;
	
	  ;% q_joints_P.Sign5_Gain
	  section.data(59).logicalSrcIdx = 140;
	  section.data(59).dtTransOffset = 58;
	
	  ;% q_joints_P.Sign1_Gain_m
	  section.data(60).logicalSrcIdx = 141;
	  section.data(60).dtTransOffset = 59;
	
	  ;% q_joints_P.Sign1_Gain_i
	  section.data(61).logicalSrcIdx = 142;
	  section.data(61).dtTransOffset = 60;
	
	  ;% q_joints_P.Sign1_Gain_h
	  section.data(62).logicalSrcIdx = 143;
	  section.data(62).dtTransOffset = 61;
	
	  ;% q_joints_P.Sign1_Gain_p
	  section.data(63).logicalSrcIdx = 144;
	  section.data(63).dtTransOffset = 62;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(5) = section;
      clear section
      
      section.nData     = 10;
      section.data(10)  = dumData; %prealloc
      
	  ;% q_joints_P.HILSetEncoderCounts_Active
	  section.data(1).logicalSrcIdx = 145;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_P.HILReadEncoderTimebase1_Active
	  section.data(2).logicalSrcIdx = 146;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_P.Takover_Active
	  section.data(3).logicalSrcIdx = 147;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_P.EnableAmps_Active
	  section.data(4).logicalSrcIdx = 148;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_P.HILWriteAnalog_Active
	  section.data(5).logicalSrcIdx = 149;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_P.HILWriteAnalog1_Active
	  section.data(6).logicalSrcIdx = 150;
	  section.data(6).dtTransOffset = 5;
	
	  ;% q_joints_P.HILWriteAnalog_Active_p
	  section.data(7).logicalSrcIdx = 151;
	  section.data(7).dtTransOffset = 6;
	
	  ;% q_joints_P.HILWriteAnalog_Active_j
	  section.data(8).logicalSrcIdx = 152;
	  section.data(8).dtTransOffset = 7;
	
	  ;% q_joints_P.HILWriteAnalog_Active_f
	  section.data(9).logicalSrcIdx = 153;
	  section.data(9).dtTransOffset = 8;
	
	  ;% q_joints_P.HILWriteAnalog_Active_p2
	  section.data(10).logicalSrcIdx = 154;
	  section.data(10).dtTransOffset = 9;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(6) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (q_joints_B)
    ;%
      section.nData     = 37;
      section.data(37)  = dumData; %prealloc
      
	  ;% q_joints_B.Clock
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_B.Saturation1
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_B.q1
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_B.Sum
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_B.Kp
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_B.Saturation
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% q_joints_B.Saturation2
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% q_joints_B.q2
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 7;
	
	  ;% q_joints_B.Sum3
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 8;
	
	  ;% q_joints_B.Kp1
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 9;
	
	  ;% q_joints_B.Saturation1_g
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 10;
	
	  ;% q_joints_B.Saturation3
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 11;
	
	  ;% q_joints_B.q3
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 12;
	
	  ;% q_joints_B.Sum_p
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 13;
	
	  ;% q_joints_B.Kp_f
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 14;
	
	  ;% q_joints_B.Saturation_i
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 15;
	
	  ;% q_joints_B.Saturation4
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 16;
	
	  ;% q_joints_B.q4
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 17;
	
	  ;% q_joints_B.Sum_d
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 18;
	
	  ;% q_joints_B.Kp_d
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 19;
	
	  ;% q_joints_B.Saturation_j
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 20;
	
	  ;% q_joints_B.Saturation5
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 21;
	
	  ;% q_joints_B.q5
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 22;
	
	  ;% q_joints_B.Sum_m
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 23;
	
	  ;% q_joints_B.Kp_i
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 24;
	
	  ;% q_joints_B.Saturation_l
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 25;
	
	  ;% q_joints_B.Saturation6
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 26;
	
	  ;% q_joints_B.q1_c
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 27;
	
	  ;% q_joints_B.Sum_pq
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 28;
	
	  ;% q_joints_B.Kp_o
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 29;
	
	  ;% q_joints_B.Saturation_p
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 30;
	
	  ;% q_joints_B.Sign1
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 31;
	
	  ;% q_joints_B.Sign5
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 32;
	
	  ;% q_joints_B.Sign1_n
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 33;
	
	  ;% q_joints_B.Sign1_l
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 34;
	
	  ;% q_joints_B.Sign1_f
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 35;
	
	  ;% q_joints_B.Sign1_e
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 36;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 8;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (q_joints_DW)
    ;%
      section.nData     = 6;
      section.data(6)  = dumData; %prealloc
      
	  ;% q_joints_DW.HILInitialize_AIMinimums
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_DW.HILInitialize_AIMaximums
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 8;
	
	  ;% q_joints_DW.HILInitialize_AOMinimums
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 16;
	
	  ;% q_joints_DW.HILInitialize_AOMaximums
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 24;
	
	  ;% q_joints_DW.HILInitialize_AOVoltages
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 32;
	
	  ;% q_joints_DW.HILInitialize_FilterFrequency
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 40;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% q_joints_DW.HILInitialize_Card
	  section.data(1).logicalSrcIdx = 6;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% q_joints_DW.HILReadEncoderTimebase1_Task
	  section.data(1).logicalSrcIdx = 7;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 63;
      section.data(63)  = dumData; %prealloc
      
	  ;% q_joints_DW.Takover_PWORK
	  section.data(1).logicalSrcIdx = 8;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_DW.EnableAmps_PWORK
	  section.data(2).logicalSrcIdx = 9;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_DW.ToWorkspace24_PWORK.LoggedData
	  section.data(3).logicalSrcIdx = 10;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_DW.FromWorkspac1_PWORK.TimePtr
	  section.data(4).logicalSrcIdx = 11;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_DW.FromWorkspac2_PWORK.TimePtr
	  section.data(5).logicalSrcIdx = 12;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_DW.FromWorkspac3_PWORK.TimePtr
	  section.data(6).logicalSrcIdx = 13;
	  section.data(6).dtTransOffset = 5;
	
	  ;% q_joints_DW.FromWorkspac4_PWORK.TimePtr
	  section.data(7).logicalSrcIdx = 14;
	  section.data(7).dtTransOffset = 6;
	
	  ;% q_joints_DW.FromWorkspac5_PWORK.TimePtr
	  section.data(8).logicalSrcIdx = 15;
	  section.data(8).dtTransOffset = 7;
	
	  ;% q_joints_DW.FromWorkspac6_PWORK.TimePtr
	  section.data(9).logicalSrcIdx = 16;
	  section.data(9).dtTransOffset = 8;
	
	  ;% q_joints_DW.Ta1_PWORK.LoggedData
	  section.data(10).logicalSrcIdx = 17;
	  section.data(10).dtTransOffset = 9;
	
	  ;% q_joints_DW.Ta2_PWORK.LoggedData
	  section.data(11).logicalSrcIdx = 18;
	  section.data(11).dtTransOffset = 10;
	
	  ;% q_joints_DW.Ta3_PWORK.LoggedData
	  section.data(12).logicalSrcIdx = 19;
	  section.data(12).dtTransOffset = 11;
	
	  ;% q_joints_DW.Ta4_PWORK.LoggedData
	  section.data(13).logicalSrcIdx = 20;
	  section.data(13).dtTransOffset = 12;
	
	  ;% q_joints_DW.Ta5_PWORK.LoggedData
	  section.data(14).logicalSrcIdx = 21;
	  section.data(14).dtTransOffset = 13;
	
	  ;% q_joints_DW.Ta6_PWORK.LoggedData
	  section.data(15).logicalSrcIdx = 22;
	  section.data(15).dtTransOffset = 14;
	
	  ;% q_joints_DW.ToWorkspace_PWORK.LoggedData
	  section.data(16).logicalSrcIdx = 23;
	  section.data(16).dtTransOffset = 15;
	
	  ;% q_joints_DW.ToWorkspace1_PWORK.LoggedData
	  section.data(17).logicalSrcIdx = 24;
	  section.data(17).dtTransOffset = 16;
	
	  ;% q_joints_DW.ToWorkspace10_PWORK.LoggedData
	  section.data(18).logicalSrcIdx = 25;
	  section.data(18).dtTransOffset = 17;
	
	  ;% q_joints_DW.ToWorkspace11_PWORK.LoggedData
	  section.data(19).logicalSrcIdx = 26;
	  section.data(19).dtTransOffset = 18;
	
	  ;% q_joints_DW.ToWorkspace13_PWORK.LoggedData
	  section.data(20).logicalSrcIdx = 27;
	  section.data(20).dtTransOffset = 19;
	
	  ;% q_joints_DW.ToWorkspace14_PWORK.LoggedData
	  section.data(21).logicalSrcIdx = 28;
	  section.data(21).dtTransOffset = 20;
	
	  ;% q_joints_DW.ToWorkspace15_PWORK.LoggedData
	  section.data(22).logicalSrcIdx = 29;
	  section.data(22).dtTransOffset = 21;
	
	  ;% q_joints_DW.ToWorkspace16_PWORK.LoggedData
	  section.data(23).logicalSrcIdx = 30;
	  section.data(23).dtTransOffset = 22;
	
	  ;% q_joints_DW.ToWorkspace17_PWORK.LoggedData
	  section.data(24).logicalSrcIdx = 31;
	  section.data(24).dtTransOffset = 23;
	
	  ;% q_joints_DW.ToWorkspace18_PWORK.LoggedData
	  section.data(25).logicalSrcIdx = 32;
	  section.data(25).dtTransOffset = 24;
	
	  ;% q_joints_DW.ToWorkspace2_PWORK.LoggedData
	  section.data(26).logicalSrcIdx = 33;
	  section.data(26).dtTransOffset = 25;
	
	  ;% q_joints_DW.ToWorkspace3_PWORK.LoggedData
	  section.data(27).logicalSrcIdx = 34;
	  section.data(27).dtTransOffset = 26;
	
	  ;% q_joints_DW.ToWorkspace4_PWORK.LoggedData
	  section.data(28).logicalSrcIdx = 35;
	  section.data(28).dtTransOffset = 27;
	
	  ;% q_joints_DW.ToWorkspace5_PWORK.LoggedData
	  section.data(29).logicalSrcIdx = 36;
	  section.data(29).dtTransOffset = 28;
	
	  ;% q_joints_DW.ToWorkspace6_PWORK.LoggedData
	  section.data(30).logicalSrcIdx = 37;
	  section.data(30).dtTransOffset = 29;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK.LoggedData
	  section.data(31).logicalSrcIdx = 38;
	  section.data(31).dtTransOffset = 30;
	
	  ;% q_joints_DW.ToWorkspace8_PWORK.LoggedData
	  section.data(32).logicalSrcIdx = 39;
	  section.data(32).dtTransOffset = 31;
	
	  ;% q_joints_DW.ToWorkspace9_PWORK.LoggedData
	  section.data(33).logicalSrcIdx = 40;
	  section.data(33).dtTransOffset = 32;
	
	  ;% q_joints_DW.q1_PWORK.LoggedData
	  section.data(34).logicalSrcIdx = 41;
	  section.data(34).dtTransOffset = 33;
	
	  ;% q_joints_DW.q2_PWORK.LoggedData
	  section.data(35).logicalSrcIdx = 42;
	  section.data(35).dtTransOffset = 34;
	
	  ;% q_joints_DW.q3_PWORK.LoggedData
	  section.data(36).logicalSrcIdx = 43;
	  section.data(36).dtTransOffset = 35;
	
	  ;% q_joints_DW.q4_PWORK.LoggedData
	  section.data(37).logicalSrcIdx = 44;
	  section.data(37).dtTransOffset = 36;
	
	  ;% q_joints_DW.q5_PWORK.LoggedData
	  section.data(38).logicalSrcIdx = 45;
	  section.data(38).dtTransOffset = 37;
	
	  ;% q_joints_DW.q6_PWORK.LoggedData
	  section.data(39).logicalSrcIdx = 46;
	  section.data(39).dtTransOffset = 38;
	
	  ;% q_joints_DW.HILWriteAnalog_PWORK
	  section.data(40).logicalSrcIdx = 47;
	  section.data(40).dtTransOffset = 39;
	
	  ;% q_joints_DW.Tafd1_PWORK.LoggedData
	  section.data(41).logicalSrcIdx = 48;
	  section.data(41).dtTransOffset = 40;
	
	  ;% q_joints_DW.ToWorkspace1_PWORK_k.LoggedData
	  section.data(42).logicalSrcIdx = 49;
	  section.data(42).dtTransOffset = 41;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK_l.LoggedData
	  section.data(43).logicalSrcIdx = 50;
	  section.data(43).dtTransOffset = 42;
	
	  ;% q_joints_DW.check_PWORK.LoggedData
	  section.data(44).logicalSrcIdx = 51;
	  section.data(44).dtTransOffset = 43;
	
	  ;% q_joints_DW.check1_PWORK.LoggedData
	  section.data(45).logicalSrcIdx = 52;
	  section.data(45).dtTransOffset = 44;
	
	  ;% q_joints_DW.HILWriteAnalog1_PWORK
	  section.data(46).logicalSrcIdx = 53;
	  section.data(46).dtTransOffset = 45;
	
	  ;% q_joints_DW.Tafd2_PWORK.LoggedData
	  section.data(47).logicalSrcIdx = 54;
	  section.data(47).dtTransOffset = 46;
	
	  ;% q_joints_DW.ToWorkspace1_PWORK_b.LoggedData
	  section.data(48).logicalSrcIdx = 55;
	  section.data(48).dtTransOffset = 47;
	
	  ;% q_joints_DW.ToWorkspace2_PWORK_d.LoggedData
	  section.data(49).logicalSrcIdx = 56;
	  section.data(49).dtTransOffset = 48;
	
	  ;% q_joints_DW.HILWriteAnalog_PWORK_i
	  section.data(50).logicalSrcIdx = 57;
	  section.data(50).dtTransOffset = 49;
	
	  ;% q_joints_DW.Tafd3_PWORK.LoggedData
	  section.data(51).logicalSrcIdx = 58;
	  section.data(51).dtTransOffset = 50;
	
	  ;% q_joints_DW.ToWorkspace1_PWORK_f.LoggedData
	  section.data(52).logicalSrcIdx = 59;
	  section.data(52).dtTransOffset = 51;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK_n.LoggedData
	  section.data(53).logicalSrcIdx = 60;
	  section.data(53).dtTransOffset = 52;
	
	  ;% q_joints_DW.HILWriteAnalog_PWORK_j
	  section.data(54).logicalSrcIdx = 61;
	  section.data(54).dtTransOffset = 53;
	
	  ;% q_joints_DW.Tafd4_PWORK.LoggedData
	  section.data(55).logicalSrcIdx = 62;
	  section.data(55).dtTransOffset = 54;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK_h.LoggedData
	  section.data(56).logicalSrcIdx = 63;
	  section.data(56).dtTransOffset = 55;
	
	  ;% q_joints_DW.HILWriteAnalog_PWORK_b
	  section.data(57).logicalSrcIdx = 64;
	  section.data(57).dtTransOffset = 56;
	
	  ;% q_joints_DW.Tafd5_PWORK.LoggedData
	  section.data(58).logicalSrcIdx = 65;
	  section.data(58).dtTransOffset = 57;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK_o.LoggedData
	  section.data(59).logicalSrcIdx = 66;
	  section.data(59).dtTransOffset = 58;
	
	  ;% q_joints_DW.HILWriteAnalog_PWORK_c
	  section.data(60).logicalSrcIdx = 67;
	  section.data(60).dtTransOffset = 59;
	
	  ;% q_joints_DW.Tafd6_PWORK.LoggedData
	  section.data(61).logicalSrcIdx = 68;
	  section.data(61).dtTransOffset = 60;
	
	  ;% q_joints_DW.ToWorkspace7_PWORK_b.LoggedData
	  section.data(62).logicalSrcIdx = 69;
	  section.data(62).dtTransOffset = 61;
	
	  ;% q_joints_DW.HILSetEncoderCounts_PWORK
	  section.data(63).logicalSrcIdx = 70;
	  section.data(63).dtTransOffset = 62;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
      section.nData     = 4;
      section.data(4)  = dumData; %prealloc
      
	  ;% q_joints_DW.HILInitialize_DOStates
	  section.data(1).logicalSrcIdx = 71;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_DW.HILInitialize_QuadratureModes
	  section.data(2).logicalSrcIdx = 72;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_DW.HILInitialize_InitialEICounts
	  section.data(3).logicalSrcIdx = 73;
	  section.data(3).dtTransOffset = 9;
	
	  ;% q_joints_DW.HILReadEncoderTimebase1_Buffer
	  section.data(4).logicalSrcIdx = 74;
	  section.data(4).dtTransOffset = 17;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(5) = section;
      clear section
      
      section.nData     = 6;
      section.data(6)  = dumData; %prealloc
      
	  ;% q_joints_DW.FromWorkspac1_IWORK.PrevIndex
	  section.data(1).logicalSrcIdx = 75;
	  section.data(1).dtTransOffset = 0;
	
	  ;% q_joints_DW.FromWorkspac2_IWORK.PrevIndex
	  section.data(2).logicalSrcIdx = 76;
	  section.data(2).dtTransOffset = 1;
	
	  ;% q_joints_DW.FromWorkspac3_IWORK.PrevIndex
	  section.data(3).logicalSrcIdx = 77;
	  section.data(3).dtTransOffset = 2;
	
	  ;% q_joints_DW.FromWorkspac4_IWORK.PrevIndex
	  section.data(4).logicalSrcIdx = 78;
	  section.data(4).dtTransOffset = 3;
	
	  ;% q_joints_DW.FromWorkspac5_IWORK.PrevIndex
	  section.data(5).logicalSrcIdx = 79;
	  section.data(5).dtTransOffset = 4;
	
	  ;% q_joints_DW.FromWorkspac6_IWORK.PrevIndex
	  section.data(6).logicalSrcIdx = 80;
	  section.data(6).dtTransOffset = 5;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(6) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% q_joints_DW.EncoderReset_SubsysRanBC
	  section.data(1).logicalSrcIdx = 81;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(7) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% q_joints_DW.Takover_Buffer
	  section.data(1).logicalSrcIdx = 82;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(8) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 138330670;
  targMap.checksum1 = 3277116915;
  targMap.checksum2 = 3117980348;
  targMap.checksum3 = 1046218565;

