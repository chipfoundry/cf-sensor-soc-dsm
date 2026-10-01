module user_project_wrapper (user_clock2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    vssa2,
    vdda2,
    vssa1,
    vdda1,
    vssd2,
    vccd2,
    vssd1,
    vccd1,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout vssa2;
 inout vdda2;
 inout vssa1;
 inout vdda1;
 inout vssd2;
 inout vccd2;
 inout vssd1;
 inout vccd1;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire afe_chopclk;
 wire \afe_dout[0] ;
 wire \afe_dout[1] ;
 wire \afe_dout[2] ;
 wire \afe_dout[3] ;
 wire \afe_dout[4] ;
 wire \afe_dout[5] ;
 wire \afe_dout[6] ;
 wire \afe_dout[7] ;
 wire afe_ibias;
 wire afe_nbias;
 wire afe_out1;
 wire afe_ov_one;
 wire afe_ov_zero;
 wire afe_scanout;
 wire \afe_test[0] ;
 wire \afe_test[1] ;
 wire \afe_test[2] ;
 wire \afe_test[3] ;
 wire \afe_test[4] ;
 wire \afe_test[5] ;
 wire \afe_test[6] ;
 wire \afe_test[7] ;
 wire afe_test_dig;
 wire afe_vref;
 wire \analog_ctrl[0] ;
 wire \analog_ctrl[100] ;
 wire \analog_ctrl[101] ;
 wire \analog_ctrl[102] ;
 wire \analog_ctrl[103] ;
 wire \analog_ctrl[104] ;
 wire \analog_ctrl[105] ;
 wire \analog_ctrl[106] ;
 wire \analog_ctrl[107] ;
 wire \analog_ctrl[108] ;
 wire \analog_ctrl[109] ;
 wire \analog_ctrl[10] ;
 wire \analog_ctrl[110] ;
 wire \analog_ctrl[111] ;
 wire \analog_ctrl[112] ;
 wire \analog_ctrl[113] ;
 wire \analog_ctrl[114] ;
 wire \analog_ctrl[115] ;
 wire \analog_ctrl[116] ;
 wire \analog_ctrl[117] ;
 wire \analog_ctrl[118] ;
 wire \analog_ctrl[119] ;
 wire \analog_ctrl[11] ;
 wire \analog_ctrl[120] ;
 wire \analog_ctrl[121] ;
 wire \analog_ctrl[122] ;
 wire \analog_ctrl[123] ;
 wire \analog_ctrl[124] ;
 wire \analog_ctrl[125] ;
 wire \analog_ctrl[126] ;
 wire \analog_ctrl[127] ;
 wire \analog_ctrl[128] ;
 wire \analog_ctrl[129] ;
 wire \analog_ctrl[12] ;
 wire \analog_ctrl[130] ;
 wire \analog_ctrl[131] ;
 wire \analog_ctrl[132] ;
 wire \analog_ctrl[133] ;
 wire \analog_ctrl[134] ;
 wire \analog_ctrl[135] ;
 wire \analog_ctrl[136] ;
 wire \analog_ctrl[137] ;
 wire \analog_ctrl[138] ;
 wire \analog_ctrl[139] ;
 wire \analog_ctrl[13] ;
 wire \analog_ctrl[140] ;
 wire \analog_ctrl[141] ;
 wire \analog_ctrl[142] ;
 wire \analog_ctrl[143] ;
 wire \analog_ctrl[144] ;
 wire \analog_ctrl[145] ;
 wire \analog_ctrl[146] ;
 wire \analog_ctrl[147] ;
 wire \analog_ctrl[148] ;
 wire \analog_ctrl[149] ;
 wire \analog_ctrl[14] ;
 wire \analog_ctrl[150] ;
 wire \analog_ctrl[151] ;
 wire \analog_ctrl[152] ;
 wire \analog_ctrl[153] ;
 wire \analog_ctrl[154] ;
 wire \analog_ctrl[155] ;
 wire \analog_ctrl[156] ;
 wire \analog_ctrl[157] ;
 wire \analog_ctrl[158] ;
 wire \analog_ctrl[159] ;
 wire \analog_ctrl[15] ;
 wire \analog_ctrl[160] ;
 wire \analog_ctrl[161] ;
 wire \analog_ctrl[162] ;
 wire \analog_ctrl[163] ;
 wire \analog_ctrl[164] ;
 wire \analog_ctrl[165] ;
 wire \analog_ctrl[166] ;
 wire \analog_ctrl[167] ;
 wire \analog_ctrl[168] ;
 wire \analog_ctrl[169] ;
 wire \analog_ctrl[16] ;
 wire \analog_ctrl[170] ;
 wire \analog_ctrl[171] ;
 wire \analog_ctrl[172] ;
 wire \analog_ctrl[173] ;
 wire \analog_ctrl[174] ;
 wire \analog_ctrl[175] ;
 wire \analog_ctrl[176] ;
 wire \analog_ctrl[177] ;
 wire \analog_ctrl[178] ;
 wire \analog_ctrl[179] ;
 wire \analog_ctrl[17] ;
 wire \analog_ctrl[180] ;
 wire \analog_ctrl[181] ;
 wire \analog_ctrl[182] ;
 wire \analog_ctrl[183] ;
 wire \analog_ctrl[184] ;
 wire \analog_ctrl[185] ;
 wire \analog_ctrl[186] ;
 wire \analog_ctrl[187] ;
 wire \analog_ctrl[188] ;
 wire \analog_ctrl[189] ;
 wire \analog_ctrl[18] ;
 wire \analog_ctrl[190] ;
 wire \analog_ctrl[191] ;
 wire \analog_ctrl[192] ;
 wire \analog_ctrl[193] ;
 wire \analog_ctrl[194] ;
 wire \analog_ctrl[195] ;
 wire \analog_ctrl[196] ;
 wire \analog_ctrl[197] ;
 wire \analog_ctrl[198] ;
 wire \analog_ctrl[199] ;
 wire \analog_ctrl[19] ;
 wire \analog_ctrl[1] ;
 wire \analog_ctrl[200] ;
 wire \analog_ctrl[201] ;
 wire \analog_ctrl[202] ;
 wire \analog_ctrl[203] ;
 wire \analog_ctrl[204] ;
 wire \analog_ctrl[205] ;
 wire \analog_ctrl[206] ;
 wire \analog_ctrl[20] ;
 wire \analog_ctrl[21] ;
 wire \analog_ctrl[22] ;
 wire \analog_ctrl[23] ;
 wire \analog_ctrl[24] ;
 wire \analog_ctrl[25] ;
 wire \analog_ctrl[26] ;
 wire \analog_ctrl[27] ;
 wire \analog_ctrl[28] ;
 wire \analog_ctrl[29] ;
 wire \analog_ctrl[2] ;
 wire \analog_ctrl[30] ;
 wire \analog_ctrl[31] ;
 wire \analog_ctrl[32] ;
 wire \analog_ctrl[33] ;
 wire \analog_ctrl[34] ;
 wire \analog_ctrl[35] ;
 wire \analog_ctrl[36] ;
 wire \analog_ctrl[37] ;
 wire \analog_ctrl[38] ;
 wire \analog_ctrl[39] ;
 wire \analog_ctrl[3] ;
 wire \analog_ctrl[40] ;
 wire \analog_ctrl[41] ;
 wire \analog_ctrl[42] ;
 wire \analog_ctrl[43] ;
 wire \analog_ctrl[44] ;
 wire \analog_ctrl[45] ;
 wire \analog_ctrl[46] ;
 wire \analog_ctrl[47] ;
 wire \analog_ctrl[48] ;
 wire \analog_ctrl[49] ;
 wire \analog_ctrl[4] ;
 wire \analog_ctrl[50] ;
 wire \analog_ctrl[51] ;
 wire \analog_ctrl[52] ;
 wire \analog_ctrl[53] ;
 wire \analog_ctrl[54] ;
 wire \analog_ctrl[55] ;
 wire \analog_ctrl[56] ;
 wire \analog_ctrl[57] ;
 wire \analog_ctrl[58] ;
 wire \analog_ctrl[59] ;
 wire \analog_ctrl[5] ;
 wire \analog_ctrl[60] ;
 wire \analog_ctrl[61] ;
 wire \analog_ctrl[62] ;
 wire \analog_ctrl[63] ;
 wire \analog_ctrl[64] ;
 wire \analog_ctrl[65] ;
 wire \analog_ctrl[66] ;
 wire \analog_ctrl[67] ;
 wire \analog_ctrl[68] ;
 wire \analog_ctrl[69] ;
 wire \analog_ctrl[6] ;
 wire \analog_ctrl[70] ;
 wire \analog_ctrl[71] ;
 wire \analog_ctrl[72] ;
 wire \analog_ctrl[73] ;
 wire \analog_ctrl[74] ;
 wire \analog_ctrl[75] ;
 wire \analog_ctrl[76] ;
 wire \analog_ctrl[77] ;
 wire \analog_ctrl[78] ;
 wire \analog_ctrl[79] ;
 wire \analog_ctrl[7] ;
 wire \analog_ctrl[80] ;
 wire \analog_ctrl[81] ;
 wire \analog_ctrl[82] ;
 wire \analog_ctrl[83] ;
 wire \analog_ctrl[84] ;
 wire \analog_ctrl[85] ;
 wire \analog_ctrl[86] ;
 wire \analog_ctrl[87] ;
 wire \analog_ctrl[88] ;
 wire \analog_ctrl[89] ;
 wire \analog_ctrl[8] ;
 wire \analog_ctrl[90] ;
 wire \analog_ctrl[91] ;
 wire \analog_ctrl[92] ;
 wire \analog_ctrl[93] ;
 wire \analog_ctrl[94] ;
 wire \analog_ctrl[95] ;
 wire \analog_ctrl[96] ;
 wire \analog_ctrl[97] ;
 wire \analog_ctrl[98] ;
 wire \analog_ctrl[99] ;
 wire \analog_ctrl[9] ;
 wire dsm_sumn;
 wire dsm_sump;
 wire sram_ack;
 wire \sram_adr[0] ;
 wire \sram_adr[10] ;
 wire \sram_adr[11] ;
 wire \sram_adr[12] ;
 wire \sram_adr[13] ;
 wire \sram_adr[14] ;
 wire \sram_adr[15] ;
 wire \sram_adr[16] ;
 wire \sram_adr[17] ;
 wire \sram_adr[18] ;
 wire \sram_adr[19] ;
 wire \sram_adr[1] ;
 wire \sram_adr[20] ;
 wire \sram_adr[21] ;
 wire \sram_adr[22] ;
 wire \sram_adr[23] ;
 wire \sram_adr[24] ;
 wire \sram_adr[25] ;
 wire \sram_adr[26] ;
 wire \sram_adr[27] ;
 wire \sram_adr[28] ;
 wire \sram_adr[29] ;
 wire \sram_adr[2] ;
 wire \sram_adr[30] ;
 wire \sram_adr[31] ;
 wire \sram_adr[3] ;
 wire \sram_adr[4] ;
 wire \sram_adr[5] ;
 wire \sram_adr[6] ;
 wire \sram_adr[7] ;
 wire \sram_adr[8] ;
 wire \sram_adr[9] ;
 wire sram_cyc;
 wire \sram_rdat[0] ;
 wire \sram_rdat[10] ;
 wire \sram_rdat[11] ;
 wire \sram_rdat[12] ;
 wire \sram_rdat[13] ;
 wire \sram_rdat[14] ;
 wire \sram_rdat[15] ;
 wire \sram_rdat[16] ;
 wire \sram_rdat[17] ;
 wire \sram_rdat[18] ;
 wire \sram_rdat[19] ;
 wire \sram_rdat[1] ;
 wire \sram_rdat[20] ;
 wire \sram_rdat[21] ;
 wire \sram_rdat[22] ;
 wire \sram_rdat[23] ;
 wire \sram_rdat[24] ;
 wire \sram_rdat[25] ;
 wire \sram_rdat[26] ;
 wire \sram_rdat[27] ;
 wire \sram_rdat[28] ;
 wire \sram_rdat[29] ;
 wire \sram_rdat[2] ;
 wire \sram_rdat[30] ;
 wire \sram_rdat[31] ;
 wire \sram_rdat[3] ;
 wire \sram_rdat[4] ;
 wire \sram_rdat[5] ;
 wire \sram_rdat[6] ;
 wire \sram_rdat[7] ;
 wire \sram_rdat[8] ;
 wire \sram_rdat[9] ;
 wire \sram_sel[0] ;
 wire \sram_sel[1] ;
 wire \sram_sel[2] ;
 wire \sram_sel[3] ;
 wire sram_stb;
 wire \sram_wdat[0] ;
 wire \sram_wdat[10] ;
 wire \sram_wdat[11] ;
 wire \sram_wdat[12] ;
 wire \sram_wdat[13] ;
 wire \sram_wdat[14] ;
 wire \sram_wdat[15] ;
 wire \sram_wdat[16] ;
 wire \sram_wdat[17] ;
 wire \sram_wdat[18] ;
 wire \sram_wdat[19] ;
 wire \sram_wdat[1] ;
 wire \sram_wdat[20] ;
 wire \sram_wdat[21] ;
 wire \sram_wdat[22] ;
 wire \sram_wdat[23] ;
 wire \sram_wdat[24] ;
 wire \sram_wdat[25] ;
 wire \sram_wdat[26] ;
 wire \sram_wdat[27] ;
 wire \sram_wdat[28] ;
 wire \sram_wdat[29] ;
 wire \sram_wdat[2] ;
 wire \sram_wdat[30] ;
 wire \sram_wdat[31] ;
 wire \sram_wdat[3] ;
 wire \sram_wdat[4] ;
 wire \sram_wdat[5] ;
 wire \sram_wdat[6] ;
 wire \sram_wdat[7] ;
 wire \sram_wdat[8] ;
 wire \sram_wdat[9] ;
 wire sram_we;

 CF_ADC_DSM20 u_cf_adc_dsm20 (.SUMCAPFB_EN(\analog_ctrl[200] ),
    .SUMCAP3_EN(\analog_ctrl[195] ),
    .SUMCAP2_EN(\analog_ctrl[191] ),
    .SUMCAP1_EN(\analog_ctrl[187] ),
    .DACCAPEN(\analog_ctrl[179] ),
    .RESCAPEN(\analog_ctrl[183] ),
    .ODET(\analog_ctrl[25] ),
    .RESET1(\analog_ctrl[27] ),
    .RESET2(\analog_ctrl[28] ),
    .RESET3(\analog_ctrl[29] ),
    .disable_mod(\analog_ctrl[9] ),
    .CHOP_EN(\analog_ctrl[21] ),
    .clk(wb_clk_i),
    .MODBIT(\analog_ctrl[19] ),
    .SIGN(\analog_ctrl[20] ),
    .overload_det_one(afe_ov_one),
    .overload_det_zero(afe_ov_zero),
    .SCANOUTPUT(afe_scanout),
    .buf_chopclk(afe_chopclk),
    .test_dig_out(afe_test_dig),
    .SUMP_TEST(dsm_sump),
    .refout(analog_io[22]),
    .vpwr(vccd1),
    .vgnd(vssd1),
    .IPCAP1OFFSET(\analog_ctrl[164] ),
    .IPCAP3EN(\analog_ctrl[172] ),
    .IPCAP2EN(\analog_ctrl[168] ),
    .IPCAP1EN(\analog_ctrl[163] ),
    .FCAP3EN(\analog_ctrl[155] ),
    .FCAP2EN(\analog_ctrl[150] ),
    .FCAP1EN(\analog_ctrl[144] ),
    .FCAP1OFFSET(\analog_ctrl[145] ),
    .SUMCAPIN_EN(\analog_ctrl[206] ),
    .INP(afe_out1),
    .INN(analog_io[20]),
    .EN_DEM(\analog_ctrl[15] ),
    .TESTMODE(\analog_ctrl[26] ),
    .EN_DWA(\analog_ctrl[17] ),
    .SCANINPUT(\analog_ctrl[53] ),
    .SCANMODE(\analog_ctrl[54] ),
    .SCANCLK(\analog_ctrl[55] ),
    .SCANEN(\analog_ctrl[56] ),
    .reset_b(\analog_ctrl[8] ),
    .VCM(analog_io[21]),
    .vgndd_vnb(analog_io[26]),
    .VGND_DAC(analog_io[26]),
    .VREFQ(afe_vref),
    .EN_ADWA(\analog_ctrl[16] ),
    .PBUF_INP(afe_out1),
    .VREF(afe_vref),
    .PBUF_INN(analog_io[20]),
    .vgnde_vnb(analog_io[26]),
    .vgnde(analog_io[26]),
    .vpwr_ext(analog_io[25]),
    .vpwr_cp(analog_io[27]),
    .vpwr_cp_dc(analog_io[27]),
    .SUMN_TEST(dsm_sumn),
    .bypass_n(\analog_ctrl[24] ),
    .bypass_p(\analog_ctrl[23] ),
    .phi2_buffer(\analog_ctrl[13] ),
    .iso(\analog_ctrl[12] ),
    .enable_hv(\analog_ctrl[11] ),
    .COMBUF_INP(afe_out1),
    .COMBUF_INN(analog_io[20]),
    .MODINPUT(\analog_ctrl[18] ),
    .sleep(\analog_ctrl[10] ),
    .buf_sel(\analog_ctrl[14] ),
    .vpwrd_int(analog_io[25]),
    .vpwr_int(analog_io[25]),
    .iinc(afe_nbias),
    .iin(afe_ibias),
    .BUF_CHOP_EN(\analog_ctrl[22] ),
    .RESET_DEC_INPUT(\analog_ctrl[30] ),
    .BUF_FCHOP({\analog_ctrl[36] ,
    \analog_ctrl[35] ,
    \analog_ctrl[34] }),
    .DACCAP({\analog_ctrl[178] ,
    \analog_ctrl[177] ,
    \analog_ctrl[176] ,
    \analog_ctrl[175] ,
    \analog_ctrl[174] ,
    \analog_ctrl[173] }),
    .FCAP1({\analog_ctrl[143] ,
    \analog_ctrl[142] ,
    \analog_ctrl[141] ,
    \analog_ctrl[140] ,
    \analog_ctrl[139] ,
    \analog_ctrl[138] ,
    \analog_ctrl[137] }),
    .FCAP2({\analog_ctrl[149] ,
    \analog_ctrl[148] ,
    \analog_ctrl[147] ,
    \analog_ctrl[146] }),
    .FCAP3({\analog_ctrl[154] ,
    \analog_ctrl[153] ,
    \analog_ctrl[152] ,
    \analog_ctrl[151] }),
    .FCHOP({\analog_ctrl[33] ,
    \analog_ctrl[32] ,
    \analog_ctrl[31] }),
    .IPCAP1({\analog_ctrl[162] ,
    \analog_ctrl[161] ,
    \analog_ctrl[160] ,
    \analog_ctrl[159] ,
    \analog_ctrl[158] ,
    \analog_ctrl[157] ,
    \analog_ctrl[156] }),
    .IPCAP2({\analog_ctrl[167] ,
    \analog_ctrl[166] ,
    \analog_ctrl[165] }),
    .IPCAP3({\analog_ctrl[171] ,
    \analog_ctrl[170] ,
    \analog_ctrl[169] }),
    .NONOV({\analog_ctrl[40] ,
    \analog_ctrl[39] }),
    .ODET_TH({\analog_ctrl[45] ,
    \analog_ctrl[44] ,
    \analog_ctrl[43] ,
    \analog_ctrl[42] ,
    \analog_ctrl[41] }),
    .RESCAP({\analog_ctrl[182] ,
    \analog_ctrl[181] ,
    \analog_ctrl[180] }),
    .SUMCAP1({\analog_ctrl[186] ,
    \analog_ctrl[185] ,
    \analog_ctrl[184] }),
    .SUMCAP2({\analog_ctrl[190] ,
    \analog_ctrl[189] ,
    \analog_ctrl[188] }),
    .SUMCAP3({\analog_ctrl[194] ,
    \analog_ctrl[193] ,
    \analog_ctrl[192] }),
    .SUMCAPFB({\analog_ctrl[199] ,
    \analog_ctrl[198] ,
    \analog_ctrl[197] ,
    \analog_ctrl[196] }),
    .SUMCAPIN({\analog_ctrl[205] ,
    \analog_ctrl[204] ,
    \analog_ctrl[203] ,
    \analog_ctrl[202] ,
    \analog_ctrl[201] }),
    .bw({\analog_ctrl[52] ,
    \analog_ctrl[51] ,
    \analog_ctrl[50] ,
    \analog_ctrl[49] }),
    .dig_test_sel({\analog_ctrl[48] ,
    \analog_ctrl[47] ,
    \analog_ctrl[46] }),
    .dout({\afe_dout[7] ,
    \afe_dout[6] ,
    \afe_dout[5] ,
    \afe_dout[4] ,
    \afe_dout[3] ,
    \afe_dout[2] ,
    \afe_dout[1] ,
    \afe_dout[0] }),
    .itrim_1({\analog_ctrl[120] ,
    \analog_ctrl[119] ,
    \analog_ctrl[118] ,
    \analog_ctrl[117] ,
    \analog_ctrl[116] ,
    \analog_ctrl[115] ,
    \analog_ctrl[114] ,
    \analog_ctrl[113] ,
    \analog_ctrl[112] ,
    \analog_ctrl[111] }),
    .itrim_2_3({\analog_ctrl[104] ,
    \analog_ctrl[103] ,
    \analog_ctrl[102] ,
    \analog_ctrl[101] ,
    \analog_ctrl[100] ,
    \analog_ctrl[99] }),
    .itrim_comp({\analog_ctrl[98] ,
    \analog_ctrl[97] ,
    \analog_ctrl[96] ,
    \analog_ctrl[95] }),
    .itrim_sum({\analog_ctrl[110] ,
    \analog_ctrl[109] ,
    \analog_ctrl[108] ,
    \analog_ctrl[107] ,
    \analog_ctrl[106] ,
    \analog_ctrl[105] }),
    .qlev({\analog_ctrl[38] ,
    \analog_ctrl[37] }),
    .refsel({\analog_ctrl[136] ,
    \analog_ctrl[135] ,
    \analog_ctrl[134] ,
    \analog_ctrl[133] ,
    \analog_ctrl[132] ,
    \analog_ctrl[131] ,
    \analog_ctrl[130] ,
    \analog_ctrl[129] ,
    \analog_ctrl[128] ,
    \analog_ctrl[127] ,
    \analog_ctrl[126] ,
    \analog_ctrl[125] ,
    \analog_ctrl[124] ,
    \analog_ctrl[123] ,
    \analog_ctrl[122] ,
    \analog_ctrl[121] }),
    .test({\afe_test[7] ,
    \afe_test[6] ,
    \afe_test[5] ,
    \afe_test[4] ,
    \afe_test[3] ,
    \afe_test[2] ,
    \afe_test[1] ,
    \afe_test[0] }));
 CF_BGR u_cf_bgr (.finetune(\analog_ctrl[89] ),
    .en_startb(\analog_ctrl[90] ),
    .mux2sel(\analog_ctrl[85] ),
    .dft_sel(\analog_ctrl[86] ),
    .pd_ibg(\analog_ctrl[88] ),
    .pd(\analog_ctrl[87] ),
    .dft_curr_in(analog_io[24]),
    .vb2_fast(analog_io[0]),
    .Vout(afe_vref),
    .ibg_3uA(afe_nbias),
    .ibg_2p375uA(afe_ibias),
    .vgnd(vssd1),
    .vpwr(vccd1),
    .CurrAbsTrim({\analog_ctrl[75] ,
    \analog_ctrl[74] ,
    \analog_ctrl[73] ,
    \analog_ctrl[72] ,
    \analog_ctrl[71] ,
    \analog_ctrl[70] }),
    .inl_ctrl({\analog_ctrl[82] ,
    \analog_ctrl[81] ,
    \analog_ctrl[80] ,
    \analog_ctrl[79] ,
    \analog_ctrl[78] ,
    \analog_ctrl[77] ,
    \analog_ctrl[76] }),
    .mux1sel({\analog_ctrl[84] ,
    \analog_ctrl[83] }),
    .trimCurr({\analog_ctrl[69] ,
    \analog_ctrl[68] ,
    \analog_ctrl[67] ,
    \analog_ctrl[66] ,
    \analog_ctrl[65] ,
    \analog_ctrl[64] }),
    .trimTC({\analog_ctrl[63] ,
    \analog_ctrl[62] ,
    \analog_ctrl[61] ,
    \analog_ctrl[60] ,
    \analog_ctrl[59] ,
    \analog_ctrl[58] ,
    \analog_ctrl[57] }));
 CF_BUF_HIZ u_cf_buf_hiz (.bypass_n(\analog_ctrl[5] ),
    .clk_chop(io_out[15]),
    .disable_n(\analog_ctrl[3] ),
    .disable_p(\analog_ctrl[2] ),
    .enable_hv(\analog_ctrl[1] ),
    .lpwr(io_out[15]),
    .rail(io_out[15]),
    .rc(io_out[15]),
    .vgnd1(analog_io[5]),
    .vgnd_core(analog_io[6]),
    .vinp2(analog_io[2]),
    .vpwr_core(analog_io[3]),
    .vpwrb(analog_io[4]),
    .vpwrb_clk(analog_io[4]),
    .out2(analog_io[20]),
    .vinp1(analog_io[1]),
    .iref(afe_ibias),
    .vcm(analog_io[21]),
    .out1(afe_out1),
    .iref_casc(afe_nbias),
    .vpwr(vccd1),
    .vpwr_acore(analog_io[3]),
    .pd(\analog_ctrl[0] ),
    .vgnd(vssd1),
    .bypass_p(\analog_ctrl[4] ),
    .gain({\analog_ctrl[7] ,
    \analog_ctrl[6] }));
 CF_REFBUF u_cf_refbuf (.nbias(afe_nbias),
    .out(analog_io[7]),
    .ref_1v2(afe_vref),
    .vgnd(vssd1),
    .pd(\analog_ctrl[91] ),
    .ng(analog_io[8]),
    .switchon(\analog_ctrl[92] ),
    .ch_cont(\analog_ctrl[94] ),
    .boost(\analog_ctrl[93] ),
    .vpwre(analog_io[8]),
    .ch2(analog_io[7]),
    .vpwr(vccd1),
    .ch1(analog_io[7]));
 soc_sys u_soc_sys (.adc_chopclk(afe_chopclk),
    .adc_ov_one(afe_ov_one),
    .adc_ov_zero(afe_ov_zero),
    .adc_scanout(afe_scanout),
    .adc_test_dig(afe_test_dig),
    .sram_ack_i(sram_ack),
    .sram_cyc_o(sram_cyc),
    .sram_stb_o(sram_stb),
    .sram_we_o(sram_we),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .adc_dout({\afe_dout[7] ,
    \afe_dout[6] ,
    \afe_dout[5] ,
    \afe_dout[4] ,
    \afe_dout[3] ,
    \afe_dout[2] ,
    \afe_dout[1] ,
    \afe_dout[0] }),
    .adc_test({\afe_test[7] ,
    \afe_test[6] ,
    \afe_test[5] ,
    \afe_test[4] ,
    \afe_test[3] ,
    \afe_test[2] ,
    \afe_test[1] ,
    \afe_test[0] }),
    .analog_ctrl({\analog_ctrl[206] ,
    \analog_ctrl[205] ,
    \analog_ctrl[204] ,
    \analog_ctrl[203] ,
    \analog_ctrl[202] ,
    \analog_ctrl[201] ,
    \analog_ctrl[200] ,
    \analog_ctrl[199] ,
    \analog_ctrl[198] ,
    \analog_ctrl[197] ,
    \analog_ctrl[196] ,
    \analog_ctrl[195] ,
    \analog_ctrl[194] ,
    \analog_ctrl[193] ,
    \analog_ctrl[192] ,
    \analog_ctrl[191] ,
    \analog_ctrl[190] ,
    \analog_ctrl[189] ,
    \analog_ctrl[188] ,
    \analog_ctrl[187] ,
    \analog_ctrl[186] ,
    \analog_ctrl[185] ,
    \analog_ctrl[184] ,
    \analog_ctrl[183] ,
    \analog_ctrl[182] ,
    \analog_ctrl[181] ,
    \analog_ctrl[180] ,
    \analog_ctrl[179] ,
    \analog_ctrl[178] ,
    \analog_ctrl[177] ,
    \analog_ctrl[176] ,
    \analog_ctrl[175] ,
    \analog_ctrl[174] ,
    \analog_ctrl[173] ,
    \analog_ctrl[172] ,
    \analog_ctrl[171] ,
    \analog_ctrl[170] ,
    \analog_ctrl[169] ,
    \analog_ctrl[168] ,
    \analog_ctrl[167] ,
    \analog_ctrl[166] ,
    \analog_ctrl[165] ,
    \analog_ctrl[164] ,
    \analog_ctrl[163] ,
    \analog_ctrl[162] ,
    \analog_ctrl[161] ,
    \analog_ctrl[160] ,
    \analog_ctrl[159] ,
    \analog_ctrl[158] ,
    \analog_ctrl[157] ,
    \analog_ctrl[156] ,
    \analog_ctrl[155] ,
    \analog_ctrl[154] ,
    \analog_ctrl[153] ,
    \analog_ctrl[152] ,
    \analog_ctrl[151] ,
    \analog_ctrl[150] ,
    \analog_ctrl[149] ,
    \analog_ctrl[148] ,
    \analog_ctrl[147] ,
    \analog_ctrl[146] ,
    \analog_ctrl[145] ,
    \analog_ctrl[144] ,
    \analog_ctrl[143] ,
    \analog_ctrl[142] ,
    \analog_ctrl[141] ,
    \analog_ctrl[140] ,
    \analog_ctrl[139] ,
    \analog_ctrl[138] ,
    \analog_ctrl[137] ,
    \analog_ctrl[136] ,
    \analog_ctrl[135] ,
    \analog_ctrl[134] ,
    \analog_ctrl[133] ,
    \analog_ctrl[132] ,
    \analog_ctrl[131] ,
    \analog_ctrl[130] ,
    \analog_ctrl[129] ,
    \analog_ctrl[128] ,
    \analog_ctrl[127] ,
    \analog_ctrl[126] ,
    \analog_ctrl[125] ,
    \analog_ctrl[124] ,
    \analog_ctrl[123] ,
    \analog_ctrl[122] ,
    \analog_ctrl[121] ,
    \analog_ctrl[120] ,
    \analog_ctrl[119] ,
    \analog_ctrl[118] ,
    \analog_ctrl[117] ,
    \analog_ctrl[116] ,
    \analog_ctrl[115] ,
    \analog_ctrl[114] ,
    \analog_ctrl[113] ,
    \analog_ctrl[112] ,
    \analog_ctrl[111] ,
    \analog_ctrl[110] ,
    \analog_ctrl[109] ,
    \analog_ctrl[108] ,
    \analog_ctrl[107] ,
    \analog_ctrl[106] ,
    \analog_ctrl[105] ,
    \analog_ctrl[104] ,
    \analog_ctrl[103] ,
    \analog_ctrl[102] ,
    \analog_ctrl[101] ,
    \analog_ctrl[100] ,
    \analog_ctrl[99] ,
    \analog_ctrl[98] ,
    \analog_ctrl[97] ,
    \analog_ctrl[96] ,
    \analog_ctrl[95] ,
    \analog_ctrl[94] ,
    \analog_ctrl[93] ,
    \analog_ctrl[92] ,
    \analog_ctrl[91] ,
    \analog_ctrl[90] ,
    \analog_ctrl[89] ,
    \analog_ctrl[88] ,
    \analog_ctrl[87] ,
    \analog_ctrl[86] ,
    \analog_ctrl[85] ,
    \analog_ctrl[84] ,
    \analog_ctrl[83] ,
    \analog_ctrl[82] ,
    \analog_ctrl[81] ,
    \analog_ctrl[80] ,
    \analog_ctrl[79] ,
    \analog_ctrl[78] ,
    \analog_ctrl[77] ,
    \analog_ctrl[76] ,
    \analog_ctrl[75] ,
    \analog_ctrl[74] ,
    \analog_ctrl[73] ,
    \analog_ctrl[72] ,
    \analog_ctrl[71] ,
    \analog_ctrl[70] ,
    \analog_ctrl[69] ,
    \analog_ctrl[68] ,
    \analog_ctrl[67] ,
    \analog_ctrl[66] ,
    \analog_ctrl[65] ,
    \analog_ctrl[64] ,
    \analog_ctrl[63] ,
    \analog_ctrl[62] ,
    \analog_ctrl[61] ,
    \analog_ctrl[60] ,
    \analog_ctrl[59] ,
    \analog_ctrl[58] ,
    \analog_ctrl[57] ,
    \analog_ctrl[56] ,
    \analog_ctrl[55] ,
    \analog_ctrl[54] ,
    \analog_ctrl[53] ,
    \analog_ctrl[52] ,
    \analog_ctrl[51] ,
    \analog_ctrl[50] ,
    \analog_ctrl[49] ,
    \analog_ctrl[48] ,
    \analog_ctrl[47] ,
    \analog_ctrl[46] ,
    \analog_ctrl[45] ,
    \analog_ctrl[44] ,
    \analog_ctrl[43] ,
    \analog_ctrl[42] ,
    \analog_ctrl[41] ,
    \analog_ctrl[40] ,
    \analog_ctrl[39] ,
    \analog_ctrl[38] ,
    \analog_ctrl[37] ,
    \analog_ctrl[36] ,
    \analog_ctrl[35] ,
    \analog_ctrl[34] ,
    \analog_ctrl[33] ,
    \analog_ctrl[32] ,
    \analog_ctrl[31] ,
    \analog_ctrl[30] ,
    \analog_ctrl[29] ,
    \analog_ctrl[28] ,
    \analog_ctrl[27] ,
    \analog_ctrl[26] ,
    \analog_ctrl[25] ,
    \analog_ctrl[24] ,
    \analog_ctrl[23] ,
    \analog_ctrl[22] ,
    \analog_ctrl[21] ,
    \analog_ctrl[20] ,
    \analog_ctrl[19] ,
    \analog_ctrl[18] ,
    \analog_ctrl[17] ,
    \analog_ctrl[16] ,
    \analog_ctrl[15] ,
    \analog_ctrl[14] ,
    \analog_ctrl[13] ,
    \analog_ctrl[12] ,
    \analog_ctrl[11] ,
    \analog_ctrl[10] ,
    \analog_ctrl[9] ,
    \analog_ctrl[8] ,
    \analog_ctrl[7] ,
    \analog_ctrl[6] ,
    \analog_ctrl[5] ,
    \analog_ctrl[4] ,
    \analog_ctrl[3] ,
    \analog_ctrl[2] ,
    \analog_ctrl[1] ,
    \analog_ctrl[0] }),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7]}),
    .io_oeb({io_oeb[37],
    io_oeb[36],
    io_oeb[35],
    io_oeb[34],
    io_oeb[33],
    io_oeb[32],
    io_oeb[31],
    io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21],
    io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8],
    io_oeb[7]}),
    .io_out({io_out[37],
    io_out[36],
    io_out[35],
    io_out[34],
    io_out[33],
    io_out[32],
    io_out[31],
    io_out[30],
    io_out[29],
    io_out[28],
    io_out[27],
    io_out[26],
    io_out[25],
    io_out[24],
    io_out[23],
    io_out[22],
    io_out[21],
    io_out[20],
    io_out[19],
    io_out[18],
    io_out[17],
    io_out[16],
    io_out[15],
    io_out[14],
    io_out[13],
    io_out[12],
    io_out[11],
    io_out[10],
    io_out[9],
    io_out[8],
    io_out[7]}),
    .sram_adr_o({\sram_adr[31] ,
    \sram_adr[30] ,
    \sram_adr[29] ,
    \sram_adr[28] ,
    \sram_adr[27] ,
    \sram_adr[26] ,
    \sram_adr[25] ,
    \sram_adr[24] ,
    \sram_adr[23] ,
    \sram_adr[22] ,
    \sram_adr[21] ,
    \sram_adr[20] ,
    \sram_adr[19] ,
    \sram_adr[18] ,
    \sram_adr[17] ,
    \sram_adr[16] ,
    \sram_adr[15] ,
    \sram_adr[14] ,
    \sram_adr[13] ,
    \sram_adr[12] ,
    \sram_adr[11] ,
    \sram_adr[10] ,
    \sram_adr[9] ,
    \sram_adr[8] ,
    \sram_adr[7] ,
    \sram_adr[6] ,
    \sram_adr[5] ,
    \sram_adr[4] ,
    \sram_adr[3] ,
    \sram_adr[2] ,
    \sram_adr[1] ,
    \sram_adr[0] }),
    .sram_dat_i({\sram_rdat[31] ,
    \sram_rdat[30] ,
    \sram_rdat[29] ,
    \sram_rdat[28] ,
    \sram_rdat[27] ,
    \sram_rdat[26] ,
    \sram_rdat[25] ,
    \sram_rdat[24] ,
    \sram_rdat[23] ,
    \sram_rdat[22] ,
    \sram_rdat[21] ,
    \sram_rdat[20] ,
    \sram_rdat[19] ,
    \sram_rdat[18] ,
    \sram_rdat[17] ,
    \sram_rdat[16] ,
    \sram_rdat[15] ,
    \sram_rdat[14] ,
    \sram_rdat[13] ,
    \sram_rdat[12] ,
    \sram_rdat[11] ,
    \sram_rdat[10] ,
    \sram_rdat[9] ,
    \sram_rdat[8] ,
    \sram_rdat[7] ,
    \sram_rdat[6] ,
    \sram_rdat[5] ,
    \sram_rdat[4] ,
    \sram_rdat[3] ,
    \sram_rdat[2] ,
    \sram_rdat[1] ,
    \sram_rdat[0] }),
    .sram_dat_o({\sram_wdat[31] ,
    \sram_wdat[30] ,
    \sram_wdat[29] ,
    \sram_wdat[28] ,
    \sram_wdat[27] ,
    \sram_wdat[26] ,
    \sram_wdat[25] ,
    \sram_wdat[24] ,
    \sram_wdat[23] ,
    \sram_wdat[22] ,
    \sram_wdat[21] ,
    \sram_wdat[20] ,
    \sram_wdat[19] ,
    \sram_wdat[18] ,
    \sram_wdat[17] ,
    \sram_wdat[16] ,
    \sram_wdat[15] ,
    \sram_wdat[14] ,
    \sram_wdat[13] ,
    \sram_wdat[12] ,
    \sram_wdat[11] ,
    \sram_wdat[10] ,
    \sram_wdat[9] ,
    \sram_wdat[8] ,
    \sram_wdat[7] ,
    \sram_wdat[6] ,
    \sram_wdat[5] ,
    \sram_wdat[4] ,
    \sram_wdat[3] ,
    \sram_wdat[2] ,
    \sram_wdat[1] ,
    \sram_wdat[0] }),
    .sram_sel_o({\sram_sel[3] ,
    \sram_sel[2] ,
    \sram_sel[1] ,
    \sram_sel[0] }),
    .user_irq({user_irq[2],
    user_irq[1],
    user_irq[0]}),
    .wbs_adr_i({wbs_adr_i[31],
    wbs_adr_i[30],
    wbs_adr_i[29],
    wbs_adr_i[28],
    wbs_adr_i[27],
    wbs_adr_i[26],
    wbs_adr_i[25],
    wbs_adr_i[24],
    wbs_adr_i[23],
    wbs_adr_i[22],
    wbs_adr_i[21],
    wbs_adr_i[20],
    wbs_adr_i[19],
    wbs_adr_i[18],
    wbs_adr_i[17],
    wbs_adr_i[16],
    wbs_adr_i[15],
    wbs_adr_i[14],
    wbs_adr_i[13],
    wbs_adr_i[12],
    wbs_adr_i[11],
    wbs_adr_i[10],
    wbs_adr_i[9],
    wbs_adr_i[8],
    wbs_adr_i[7],
    wbs_adr_i[6],
    wbs_adr_i[5],
    wbs_adr_i[4],
    wbs_adr_i[3],
    wbs_adr_i[2],
    wbs_adr_i[1],
    wbs_adr_i[0]}),
    .wbs_dat_i({wbs_dat_i[31],
    wbs_dat_i[30],
    wbs_dat_i[29],
    wbs_dat_i[28],
    wbs_dat_i[27],
    wbs_dat_i[26],
    wbs_dat_i[25],
    wbs_dat_i[24],
    wbs_dat_i[23],
    wbs_dat_i[22],
    wbs_dat_i[21],
    wbs_dat_i[20],
    wbs_dat_i[19],
    wbs_dat_i[18],
    wbs_dat_i[17],
    wbs_dat_i[16],
    wbs_dat_i[15],
    wbs_dat_i[14],
    wbs_dat_i[13],
    wbs_dat_i[12],
    wbs_dat_i[11],
    wbs_dat_i[10],
    wbs_dat_i[9],
    wbs_dat_i[8],
    wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .wbs_dat_o({wbs_dat_o[31],
    wbs_dat_o[30],
    wbs_dat_o[29],
    wbs_dat_o[28],
    wbs_dat_o[27],
    wbs_dat_o[26],
    wbs_dat_o[25],
    wbs_dat_o[24],
    wbs_dat_o[23],
    wbs_dat_o[22],
    wbs_dat_o[21],
    wbs_dat_o[20],
    wbs_dat_o[19],
    wbs_dat_o[18],
    wbs_dat_o[17],
    wbs_dat_o[16],
    wbs_dat_o[15],
    wbs_dat_o[14],
    wbs_dat_o[13],
    wbs_dat_o[12],
    wbs_dat_o[11],
    wbs_dat_o[10],
    wbs_dat_o[9],
    wbs_dat_o[8],
    wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}),
    .wbs_sel_i({wbs_sel_i[3],
    wbs_sel_i[2],
    wbs_sel_i[1],
    wbs_sel_i[0]}));
 CF_SRAM_1024x32_wb_wrapper u_sram (.VGND(vssd1),
    .VPWR(vccd1),
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_ack_o(sram_ack),
    .wbs_cyc_i(sram_cyc),
    .wbs_stb_i(sram_stb),
    .wbs_we_i(sram_we),
    .wbs_adr_i({\sram_adr[31] ,
    \sram_adr[30] ,
    \sram_adr[29] ,
    \sram_adr[28] ,
    \sram_adr[27] ,
    \sram_adr[26] ,
    \sram_adr[25] ,
    \sram_adr[24] ,
    \sram_adr[23] ,
    \sram_adr[22] ,
    \sram_adr[21] ,
    \sram_adr[20] ,
    \sram_adr[19] ,
    \sram_adr[18] ,
    \sram_adr[17] ,
    \sram_adr[16] ,
    \sram_adr[15] ,
    \sram_adr[14] ,
    \sram_adr[13] ,
    \sram_adr[12] ,
    \sram_adr[11] ,
    \sram_adr[10] ,
    \sram_adr[9] ,
    \sram_adr[8] ,
    \sram_adr[7] ,
    \sram_adr[6] ,
    \sram_adr[5] ,
    \sram_adr[4] ,
    \sram_adr[3] ,
    \sram_adr[2] ,
    \sram_adr[1] ,
    \sram_adr[0] }),
    .wbs_dat_i({\sram_wdat[31] ,
    \sram_wdat[30] ,
    \sram_wdat[29] ,
    \sram_wdat[28] ,
    \sram_wdat[27] ,
    \sram_wdat[26] ,
    \sram_wdat[25] ,
    \sram_wdat[24] ,
    \sram_wdat[23] ,
    \sram_wdat[22] ,
    \sram_wdat[21] ,
    \sram_wdat[20] ,
    \sram_wdat[19] ,
    \sram_wdat[18] ,
    \sram_wdat[17] ,
    \sram_wdat[16] ,
    \sram_wdat[15] ,
    \sram_wdat[14] ,
    \sram_wdat[13] ,
    \sram_wdat[12] ,
    \sram_wdat[11] ,
    \sram_wdat[10] ,
    \sram_wdat[9] ,
    \sram_wdat[8] ,
    \sram_wdat[7] ,
    \sram_wdat[6] ,
    \sram_wdat[5] ,
    \sram_wdat[4] ,
    \sram_wdat[3] ,
    \sram_wdat[2] ,
    \sram_wdat[1] ,
    \sram_wdat[0] }),
    .wbs_dat_o({\sram_rdat[31] ,
    \sram_rdat[30] ,
    \sram_rdat[29] ,
    \sram_rdat[28] ,
    \sram_rdat[27] ,
    \sram_rdat[26] ,
    \sram_rdat[25] ,
    \sram_rdat[24] ,
    \sram_rdat[23] ,
    \sram_rdat[22] ,
    \sram_rdat[21] ,
    \sram_rdat[20] ,
    \sram_rdat[19] ,
    \sram_rdat[18] ,
    \sram_rdat[17] ,
    \sram_rdat[16] ,
    \sram_rdat[15] ,
    \sram_rdat[14] ,
    \sram_rdat[13] ,
    \sram_rdat[12] ,
    \sram_rdat[11] ,
    \sram_rdat[10] ,
    \sram_rdat[9] ,
    \sram_rdat[8] ,
    \sram_rdat[7] ,
    \sram_rdat[6] ,
    \sram_rdat[5] ,
    \sram_rdat[4] ,
    \sram_rdat[3] ,
    \sram_rdat[2] ,
    \sram_rdat[1] ,
    \sram_rdat[0] }),
    .wbs_sel_i({\sram_sel[3] ,
    \sram_sel[2] ,
    \sram_sel[1] ,
    \sram_sel[0] }));
endmodule
