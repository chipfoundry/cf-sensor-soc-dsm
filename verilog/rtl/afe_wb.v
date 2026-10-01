`default_nettype none
/*
 * afe_wb — Wishbone CSR for the DSM sensor front end.
 *
 * analog_ctrl[206:0] is the elaborated wrapper's digital control bus.
 * HIZ, BGR, and REFBUF fields keep the same widths as cf-sensor-soc.
 * SAR and sar_refs are gone. The HIZ word drives the s8hizbuf_pumptop
 * controls. Bit 7 is gain[1].
 *
 * User space is 0x30000000. Word offsets:
 *   0 ID       RO  0xAFE00020
 *   1 CTRL     RW  modulator run / chop / reset (see bit list below)
 *   2 STATUS   RO  dout, overload, scan and test observes
 *   3 HIZ      RW  analog_ctrl[7:0]
 *               [0] pd  [1] enable_hv  [2] disable_p  [3] disable_n
 *               [4] bypass_p  [5] bypass_n  [7:6] gain
 *   4 CHOP     RW  FCHOP, qlev, NONOV, ODET_TH, bw
 *   5 SCAN     RW  scan pins
 *   6 BGR      RW  trim / mux / pd
 *   7 REFBUF   RW  pd, switchon, boost, ch_cont, finetune, en_startb
 *   8 TRIM0    RW  itrim_comp, itrim_2_3, itrim_sum, itrim_1
 *   9 TRIM1    RW  refsel[15:0]
 *  10 CAP0     RW  FCAP1..3
 *  11 CAP1     RW  IPCAP1..3
 *  12 CAP2     RW  DACCAP, RESCAP, SUMCAP1..2
 *  13 CAP3     RW  SUMCAP3, SUMCAPFB, SUMCAPIN
 *
 * CTRL bits:
 *   [0] reset_b  [1] disable_mod  [2] sleep  [3] enable_hv
 *   [4] iso  [5] phi2_buffer  [6] buf_sel  [7] EN_DEM
 *   [8] EN_ADWA  [9] EN_DWA  [10] MODINPUT  [11] MODBIT  [12] SIGN
 *   [13] CHOP_EN  [14] BUF_CHOP_EN  [15] bypass_p  [16] bypass_n
 *   [17] ODET  [18] TESTMODE
 *   [19] RESET1  [20] RESET2  [21] RESET3  [22] RESET_DEC_INPUT
 *
 * STATUS bits:
 *   [7:0] dout  [8] overload_det_zero  [9] overload_det_one
 *   [10] SCANOUTPUT  [11] test_dig_out  [12] buf_chopclk  [20:13] test
 *
 * Product firmware: release reset_b with disable_mod and sleep low,
 * then read STATUS. The ideal model copies INP onto dout[0] on wb_clk_i.
 */

module afe_wb (
`ifdef USE_POWER_PINS
    inout vccd1,
    inout vssd1,
`endif
    input         wb_clk_i,
    input         wb_rst_i,
    input         wbs_stb_i,
    input         wbs_cyc_i,
    input         wbs_we_i,
    input  [3:0]  wbs_sel_i,
    input  [31:0] wbs_dat_i,
    input  [31:0] wbs_adr_i,
    output        wbs_ack_o,
    output [31:0] wbs_dat_o,

    input  [7:0]  adc_dout,
    input         adc_ov_zero,
    input         adc_ov_one,
    input         adc_scanout,
    input         adc_test_dig,
    input         adc_chopclk,
    input  [7:0]  adc_test,
    output [206:0] analog_ctrl,
    output [27:0] analog_io_oeb,
    output [27:0] analog_io_out
);

    localparam [31:0] ID_VALUE = 32'hAFE0_0020;

    wire        valid = wbs_cyc_i & wbs_stb_i;
    wire [3:0]  waddr = wbs_adr_i[5:2];
    wire        wr    = valid & wbs_we_i;

    reg        ack;
    reg [31:0] rdata;
    reg [31:0] ctrl;
    reg [31:0] hiz;
    reg [31:0] chop;
    reg [31:0] scan;
    reg [31:0] bgr;
    reg [31:0] refbuf;
    reg [31:0] trim0;
    reg [31:0] trim1;
    reg [31:0] cap0;
    reg [31:0] cap1;
    reg [31:0] cap2;
    reg [31:0] cap3;
    reg [206:0] csr_ctrl;

    assign wbs_ack_o      = ack;
    assign wbs_dat_o      = rdata;
    assign analog_ctrl    = csr_ctrl;
    assign analog_io_oeb  = {28{1'b1}};
    assign analog_io_out  = {28{1'b0}};

    always @(*) begin
        csr_ctrl = 207'b0;
        csr_ctrl[7:0]     = hiz[7:0];
        csr_ctrl[8]       = ctrl[0];
        csr_ctrl[9]       = ctrl[1];
        csr_ctrl[10]      = ctrl[2];
        csr_ctrl[11]      = ctrl[3];
        csr_ctrl[12]      = ctrl[4];
        csr_ctrl[13]      = ctrl[5];
        csr_ctrl[14]      = ctrl[6];
        csr_ctrl[15]      = ctrl[7];
        csr_ctrl[16]      = ctrl[8];
        csr_ctrl[17]      = ctrl[9];
        csr_ctrl[18]      = ctrl[10];
        csr_ctrl[19]      = ctrl[11];
        csr_ctrl[20]      = ctrl[12];
        csr_ctrl[21]      = ctrl[13];
        csr_ctrl[22]      = ctrl[14];
        csr_ctrl[23]      = ctrl[15];
        csr_ctrl[24]      = ctrl[16];
        csr_ctrl[25]      = ctrl[17];
        csr_ctrl[26]      = ctrl[18];
        csr_ctrl[27]      = ctrl[19];
        csr_ctrl[28]      = ctrl[20];
        csr_ctrl[29]      = ctrl[21];
        csr_ctrl[30]      = ctrl[22];
        csr_ctrl[33:31]   = chop[2:0];
        csr_ctrl[36:34]   = chop[5:3];
        csr_ctrl[38:37]   = chop[7:6];
        csr_ctrl[40:39]   = chop[9:8];
        csr_ctrl[45:41]   = chop[14:10];
        csr_ctrl[48:46]   = chop[17:15];
        csr_ctrl[52:49]   = chop[21:18];
        csr_ctrl[56:53]   = scan[3:0];
        csr_ctrl[63:57]   = bgr[6:0];
        csr_ctrl[69:64]   = bgr[12:7];
        csr_ctrl[75:70]   = bgr[18:13];
        csr_ctrl[82:76]   = bgr[25:19];
        csr_ctrl[84:83]   = bgr[27:26];
        csr_ctrl[85]      = bgr[28];
        csr_ctrl[86]      = bgr[29];
        csr_ctrl[87]      = bgr[30];
        csr_ctrl[88]      = bgr[31];
        csr_ctrl[89]      = refbuf[4];
        csr_ctrl[90]      = refbuf[5];
        csr_ctrl[91]      = refbuf[0];
        csr_ctrl[92]      = refbuf[1];
        csr_ctrl[93]      = refbuf[2];
        csr_ctrl[94]      = refbuf[3];
        csr_ctrl[98:95]   = trim0[3:0];
        csr_ctrl[104:99]  = trim0[9:4];
        csr_ctrl[110:105] = trim0[15:10];
        csr_ctrl[120:111] = trim0[25:16];
        csr_ctrl[136:121] = trim1[15:0];
        csr_ctrl[143:137] = cap0[6:0];
        csr_ctrl[144]     = cap0[7];
        csr_ctrl[145]     = cap0[8];
        csr_ctrl[149:146] = cap0[12:9];
        csr_ctrl[150]     = cap0[13];
        csr_ctrl[154:151] = cap0[17:14];
        csr_ctrl[155]     = cap0[18];
        csr_ctrl[162:156] = cap1[6:0];
        csr_ctrl[163]     = cap1[7];
        csr_ctrl[164]     = cap1[8];
        csr_ctrl[167:165] = cap1[11:9];
        csr_ctrl[168]     = cap1[12];
        csr_ctrl[171:169] = cap1[14:12];
        csr_ctrl[172]     = cap1[15];
        csr_ctrl[178:173] = cap2[5:0];
        csr_ctrl[179]     = cap2[6];
        csr_ctrl[182:180] = cap2[9:7];
        csr_ctrl[183]     = cap2[10];
        csr_ctrl[186:184] = cap2[13:11];
        csr_ctrl[187]     = cap2[14];
        csr_ctrl[190:188] = cap2[17:15];
        csr_ctrl[191]     = cap2[18];
        csr_ctrl[194:192] = cap3[2:0];
        csr_ctrl[195]     = cap3[3];
        csr_ctrl[199:196] = cap3[7:4];
        csr_ctrl[200]     = cap3[8];
        csr_ctrl[205:201] = cap3[13:9];
        csr_ctrl[206]     = cap3[14];
    end

    always @(posedge wb_clk_i) begin
        if (wb_rst_i) begin
            ack     <= 1'b0;
            rdata   <= 32'b0;
            ctrl    <= 32'b0;
            hiz     <= 32'b0;
            chop    <= 32'b0;
            scan    <= 32'b0;
            bgr     <= 32'b0;
            refbuf  <= 32'b0;
            trim0   <= 32'b0;
            trim1   <= 32'b0;
            cap0    <= 32'b0;
            cap1    <= 32'b0;
            cap2    <= 32'b0;
            cap3    <= 32'b0;
        end else begin
            ack <= valid & ~ack;
            if (wr & ~ack) begin
                case (waddr)
                    4'd1:  ctrl   <= wbs_dat_i;
                    4'd3:  hiz    <= wbs_dat_i;
                    4'd4:  chop   <= wbs_dat_i;
                    4'd5:  scan   <= wbs_dat_i;
                    4'd6:  bgr    <= wbs_dat_i;
                    4'd7:  refbuf <= wbs_dat_i;
                    4'd8:  trim0  <= wbs_dat_i;
                    4'd9:  trim1  <= wbs_dat_i;
                    4'd10: cap0   <= wbs_dat_i;
                    4'd11: cap1   <= wbs_dat_i;
                    4'd12: cap2   <= wbs_dat_i;
                    4'd13: cap3   <= wbs_dat_i;
                    default: ;
                endcase
            end
            if (valid & ~wbs_we_i & ~ack) begin
                case (waddr)
                    4'd0:  rdata <= ID_VALUE;
                    4'd1:  rdata <= ctrl;
                    4'd2:  rdata <= {11'b0, adc_test, adc_chopclk, adc_test_dig,
                                     adc_scanout, adc_ov_one, adc_ov_zero, adc_dout};
                    4'd3:  rdata <= hiz;
                    4'd4:  rdata <= chop;
                    4'd5:  rdata <= scan;
                    4'd6:  rdata <= bgr;
                    4'd7:  rdata <= refbuf;
                    4'd8:  rdata <= trim0;
                    4'd9:  rdata <= trim1;
                    4'd10: rdata <= cap0;
                    4'd11: rdata <= cap1;
                    4'd12: rdata <= cap2;
                    4'd13: rdata <= cap3;
                    default: rdata <= 32'b0;
                endcase
            end
        end
    end

endmodule

`default_nettype wire
