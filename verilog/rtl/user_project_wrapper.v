`default_nettype none
/*
 * user_project_wrapper — DSM sensor SoC
 *
 * Fork of cf-sensor-soc. CF_ADC_SAR12 and sar_refs are replaced by
 * CF_ADC_DSM20. HIZ, BGR, and REFBUF stay. The modulator clock is
 * wb_clk_i so dout and the capture engine share one domain.
 *
 * Analog controls come from soc_sys (afe_wb inside). Caravel LA unused.
 * Elaborate-only: structural instance wiring, no assign.
 * JsonHeader applies USE_POWER_PINS for PDN.
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,
    inout vdda2,
    inout vssa1,
    inout vssa2,
    inout vccd1,
    inout vccd2,
    inout vssd1,
    inout vssd2,
`endif

    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    inout [`MPRJ_IO_PADS-10:0] analog_io,

    input   user_clock2,

    output [2:0] user_irq
);

    wire afe_out1;
    wire afe_ibias;
    wire afe_vref;
    wire afe_nbias;
    wire [206:0] analog_ctrl;
    wire [7:0] afe_dout;
    wire [7:0] afe_test;
    wire afe_ov_zero;
    wire afe_ov_one;
    wire afe_scanout;
    wire afe_test_dig;
    wire afe_chopclk;
    wire dsm_sumn;
    wire dsm_sump;
    wire sram_stb, sram_cyc, sram_we, sram_ack;
    wire [3:0] sram_sel;
    wire [31:0] sram_adr, sram_wdat, sram_rdat;

soc_sys u_soc_sys (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_o(wbs_dat_o),
    .sram_stb_o(sram_stb),
    .sram_cyc_o(sram_cyc),
    .sram_we_o(sram_we),
    .sram_sel_o(sram_sel),
    .sram_adr_o(sram_adr),
    .sram_dat_o(sram_wdat),
    .sram_ack_i(sram_ack),
    .sram_dat_i(sram_rdat),
    .adc_dout(afe_dout),
    .adc_ov_zero(afe_ov_zero),
    .adc_ov_one(afe_ov_one),
    .adc_scanout(afe_scanout),
    .adc_test_dig(afe_test_dig),
    .adc_chopclk(afe_chopclk),
    .adc_test(afe_test),
    .analog_ctrl(analog_ctrl),
    .io_in(io_in[37:7]),
    .io_out(io_out[37:7]),
    .io_oeb(io_oeb[37:7]),
    .user_irq(user_irq)
`ifdef USE_POWER_PINS
    ,
    .vccd1(vccd1),
    .vssd1(vssd1)
`endif
);

CF_SRAM_1024x32_wb_wrapper u_sram (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_stb_i(sram_stb),
    .wbs_cyc_i(sram_cyc),
    .wbs_we_i(sram_we),
    .wbs_sel_i(sram_sel),
    .wbs_dat_i(sram_wdat),
    .wbs_adr_i(sram_adr),
    .wbs_ack_o(sram_ack),
    .wbs_dat_o(sram_rdat)
`ifdef USE_POWER_PINS
    ,
    .VPWR(vccd1),
    .VGND(vssd1)
`endif
);

CF_BUF_HIZ u_cf_buf_hiz (
    .out1(afe_out1),
    .out2(analog_io[20]),
    .vinp1(analog_io[1]),
    .vinp2(analog_io[2]),
    .vcm(analog_io[21]),
    .iref(afe_ibias),
    .iref_casc(afe_nbias),
    .vpwr_core(analog_io[3]),
    .vpwr_acore(analog_io[3]),
    .vpwrb(analog_io[4]),
    .vpwrb_clk(analog_io[4]),
    .vgnd1(analog_io[5]),
    .vgnd_core(analog_io[6]),

    .pd(analog_ctrl[0]),
    .enable_hv(analog_ctrl[1]),
    .disable_p(analog_ctrl[2]),
    .disable_n(analog_ctrl[3]),
    .bypass_p(analog_ctrl[4]),
    .bypass_n(analog_ctrl[5]),
    .gain(analog_ctrl[7:6]),
    // This wrapper has no stdcell rails, so a 1'b0 tie cell would be
    // unpowered. GPIO 15 is analog; soc_sys holds io_out[15] at 0.
    .clk_chop(io_out[15]),
    .lpwr(io_out[15]),
    .rail(io_out[15]),
    .rc(io_out[15]),

`ifdef USE_POWER_PINS
    .vgnd(vssd1),
    .vpwr(vccd1)
`endif
);

CF_ADC_DSM20 u_cf_adc_dsm20 (
    .VREF(afe_vref),
    .VREFQ(afe_vref),
    .VCM(analog_io[21]),
    .INP(afe_out1),
    .INN(analog_io[20]),
    .COMBUF_INP(afe_out1),
    .COMBUF_INN(analog_io[20]),
    .PBUF_INP(afe_out1),
    .PBUF_INN(analog_io[20]),
    .iin(afe_ibias),
    .iinc(afe_nbias),
    // 0.2.1 analog rails share the existing supply pads. They are signals, not chip PDN.
    .vpwr_ext(analog_io[25]),
    .vpwr_int(analog_io[25]),
    .vpwrd_int(analog_io[25]),
    .vgnde(analog_io[26]),
    .VGND_DAC(analog_io[26]),
    .vgnde_vnb(analog_io[26]),
    .vgndd_vnb(analog_io[26]),
    .vpwr_cp(analog_io[27]),
    .vpwr_cp_dc(analog_io[27]),
    .refout(analog_io[22]),
    .SUMP_TEST(dsm_sump),
    .SUMN_TEST(dsm_sumn),

    .clk(wb_clk_i),
    .reset_b(analog_ctrl[8]),
    .disable_mod(analog_ctrl[9]),
    .sleep(analog_ctrl[10]),
    .enable_hv(analog_ctrl[11]),
    .iso(analog_ctrl[12]),
    .phi2_buffer(analog_ctrl[13]),
    .buf_sel(analog_ctrl[14]),
    .EN_DEM(analog_ctrl[15]),
    .EN_ADWA(analog_ctrl[16]),
    .EN_DWA(analog_ctrl[17]),
    .MODINPUT(analog_ctrl[18]),
    .MODBIT(analog_ctrl[19]),
    .SIGN(analog_ctrl[20]),
    .CHOP_EN(analog_ctrl[21]),
    .BUF_CHOP_EN(analog_ctrl[22]),
    .bypass_p(analog_ctrl[23]),
    .bypass_n(analog_ctrl[24]),
    .ODET(analog_ctrl[25]),
    .TESTMODE(analog_ctrl[26]),
    .RESET1(analog_ctrl[27]),
    .RESET2(analog_ctrl[28]),
    .RESET3(analog_ctrl[29]),
    .RESET_DEC_INPUT(analog_ctrl[30]),
    .FCHOP(analog_ctrl[33:31]),
    .BUF_FCHOP(analog_ctrl[36:34]),
    .qlev(analog_ctrl[38:37]),
    .NONOV(analog_ctrl[40:39]),
    .ODET_TH(analog_ctrl[45:41]),
    .dig_test_sel(analog_ctrl[48:46]),
    .bw(analog_ctrl[52:49]),
    .SCANINPUT(analog_ctrl[53]),
    .SCANMODE(analog_ctrl[54]),
    .SCANCLK(analog_ctrl[55]),
    .SCANEN(analog_ctrl[56]),
    .itrim_comp(analog_ctrl[98:95]),
    .itrim_2_3(analog_ctrl[104:99]),
    .itrim_sum(analog_ctrl[110:105]),
    .itrim_1(analog_ctrl[120:111]),
    .refsel(analog_ctrl[136:121]),
    .FCAP1(analog_ctrl[143:137]),
    .FCAP1EN(analog_ctrl[144]),
    .FCAP1OFFSET(analog_ctrl[145]),
    .FCAP2(analog_ctrl[149:146]),
    .FCAP2EN(analog_ctrl[150]),
    .FCAP3(analog_ctrl[154:151]),
    .FCAP3EN(analog_ctrl[155]),
    .IPCAP1(analog_ctrl[162:156]),
    .IPCAP1EN(analog_ctrl[163]),
    .IPCAP1OFFSET(analog_ctrl[164]),
    .IPCAP2(analog_ctrl[167:165]),
    .IPCAP2EN(analog_ctrl[168]),
    .IPCAP3(analog_ctrl[171:169]),
    .IPCAP3EN(analog_ctrl[172]),
    .DACCAP(analog_ctrl[178:173]),
    .DACCAPEN(analog_ctrl[179]),
    .RESCAP(analog_ctrl[182:180]),
    .RESCAPEN(analog_ctrl[183]),
    .SUMCAP1(analog_ctrl[186:184]),
    .SUMCAP1_EN(analog_ctrl[187]),
    .SUMCAP2(analog_ctrl[190:188]),
    .SUMCAP2_EN(analog_ctrl[191]),
    .SUMCAP3(analog_ctrl[194:192]),
    .SUMCAP3_EN(analog_ctrl[195]),
    .SUMCAPFB(analog_ctrl[199:196]),
    .SUMCAPFB_EN(analog_ctrl[200]),
    .SUMCAPIN(analog_ctrl[205:201]),
    .SUMCAPIN_EN(analog_ctrl[206]),

    .dout(afe_dout),
    .test(afe_test),
    .overload_det_zero(afe_ov_zero),
    .overload_det_one(afe_ov_one),
    .SCANOUTPUT(afe_scanout),
    .test_dig_out(afe_test_dig),
    .buf_chopclk(afe_chopclk),

`ifdef USE_POWER_PINS
    .vgnd(vssd1),
    .vpwr(vccd1)
`endif
);

CF_BGR u_cf_bgr (
    .ibg_2p375uA(afe_ibias),
    .ibg_3uA(afe_nbias),
    .Vout(afe_vref),
    .vb2_fast(analog_io[0]),
    .dft_curr_in(analog_io[24]),

    .trimTC(analog_ctrl[63:57]),
    .trimCurr(analog_ctrl[69:64]),
    .CurrAbsTrim(analog_ctrl[75:70]),
    .inl_ctrl(analog_ctrl[82:76]),
    .mux1sel(analog_ctrl[84:83]),
    .mux2sel(analog_ctrl[85]),
    .dft_sel(analog_ctrl[86]),
    .pd(analog_ctrl[87]),
    .pd_ibg(analog_ctrl[88]),
    .finetune(analog_ctrl[89]),
    .en_startb(analog_ctrl[90]),

`ifdef USE_POWER_PINS
    .vgnd(vssd1),
    .vpwr(vccd1)
`endif
);

CF_REFBUF u_cf_refbuf (
    .out(analog_io[7]),
    .ch1(analog_io[7]),
    .ch2(analog_io[7]),
    .ref_1v2(afe_vref),
    .nbias(afe_nbias),
    .ng(analog_io[8]),
    .vpwre(analog_io[8]),

    .pd(analog_ctrl[91]),
    .switchon(analog_ctrl[92]),
    .boost(analog_ctrl[93]),
    .ch_cont(analog_ctrl[94]),

`ifdef USE_POWER_PINS
    .vgnd(vssd1),
    .vpwr(vccd1)
`endif
);

endmodule

`default_nettype wire
