// Empty blackbox stub for hierarchical integration LVS.
module CF_ADC_DSM20_core (
    VREF,
    EN_ADWA,
    EN_DWA,
    MODINPUT,
    sleep,
    COMBUF_INN,
    COMBUF_INP,
    PBUF_INN,
    PBUF_INP,
    buf_sel,
    enable_hv,
    VREFQ,
    disable_mod,
    iso,
    phi2_buffer,
    bypass_p,
    bypass_n,
    vpwr_cp_dc,
    VGND_DAC,
    vgnde_vnb,
    SUMN_TEST,
    vpb,
    vnb,
    vpwr_cp,
    vgnde,
    vgndd,
    vpwrd,
    vgnd,
    vpwr,
    vpwr_ext,
    refout,
    SUMP_TEST,
    test_dig_out,
    buf_chopclk,
    SCANOUTPUT,
    overload_det_zero,
    overload_det_one,
    SIGN,
    MODBIT,
    INN,
    NONOV,
    INP,
    clk,
    CHOP_EN,
    qlev,
    dig_test_sel,
    RESET3,
    RESET2,
    RESET1,
    ODET_TH,
    ODET,
    FCHOP,
    RESET_DEC_INPUT,
    BUF_FCHOP,
    BUF_CHOP_EN,
    itrim_comp,
    FCAP1EN,
    FCAP1OFFSET,
    FCAP2EN,
    FCAP3EN,
    IPCAP1EN,
    RESCAP,
    IPCAP2EN,
    IPCAP3EN,
    IPCAP1OFFSET,
    RESCAPEN,
    FCAP1,
    IPCAP1,
    DACCAP,
    DACCAPEN,
    FCAP2,
    FCAP3,
    IPCAP2,
    IPCAP3,
    SUMCAP1,
    SUMCAP1_EN,
    SUMCAP2,
    SUMCAP2_EN,
    refsel,
    SUMCAP3_EN,
    SUMCAP3,
    SUMCAPFB,
    SUMCAPFB_EN,
    SUMCAPIN,
    bw,
    SUMCAPIN_EN,
    itrim_2_3,
    itrim_sum,
    itrim_1,
    iin,
    iinc,
    dout,
    SCANINPUT,
    SCANMODE,
    SCANCLK,
    SCANEN,
    reset_b,
    EN_DEM,
    test,
    TESTMODE,
    VCM,
    vgndd_vnb,
    vpwr_int,
    vpwrd_int
);
    input VREF;
    input EN_ADWA;
    input EN_DWA;
    input MODINPUT;
    inout sleep;
    input COMBUF_INN;
    input COMBUF_INP;
    input PBUF_INN;
    input PBUF_INP;
    input buf_sel;
    inout enable_hv;
    input VREFQ;
    input disable_mod;
    inout iso;
    inout phi2_buffer;
    input bypass_p;
    input bypass_n;
    inout vpwr_cp_dc;
    input VGND_DAC;
    input vgnde_vnb;
    output SUMN_TEST;
    input vpb;
    input vnb;
    input vpwr_cp;
    input vgnde;
    input vgndd;
    input vpwrd;
    input vgnd;
    input vpwr;
    input vpwr_ext;
    output refout;
    output SUMP_TEST;
    output test_dig_out;
    output buf_chopclk;
    output SCANOUTPUT;
    output overload_det_zero;
    output overload_det_one;
    input SIGN;
    input MODBIT;
    input INN;
    input [1:0] NONOV;
    input INP;
    input clk;
    input CHOP_EN;
    input [1:0] qlev;
    inout [2:0] dig_test_sel;
    input RESET3;
    input RESET2;
    input RESET1;
    input [4:0] ODET_TH;
    input ODET;
    input [2:0] FCHOP;
    input RESET_DEC_INPUT;
    input [2:0] BUF_FCHOP;
    input BUF_CHOP_EN;
    input [3:0] itrim_comp;
    input FCAP1EN;
    input FCAP1OFFSET;
    input FCAP2EN;
    input FCAP3EN;
    input IPCAP1EN;
    input [2:0] RESCAP;
    input IPCAP2EN;
    input IPCAP3EN;
    input IPCAP1OFFSET;
    input RESCAPEN;
    input [6:0] FCAP1;
    input [6:0] IPCAP1;
    input [5:0] DACCAP;
    input DACCAPEN;
    inout [3:0] FCAP2;
    inout [3:0] FCAP3;
    input [2:0] IPCAP2;
    input [2:0] IPCAP3;
    input [2:0] SUMCAP1;
    input SUMCAP1_EN;
    input [2:0] SUMCAP2;
    input SUMCAP2_EN;
    input [15:0] refsel;
    input SUMCAP3_EN;
    input [2:0] SUMCAP3;
    input [3:0] SUMCAPFB;
    input SUMCAPFB_EN;
    input [4:0] SUMCAPIN;
    input [3:0] bw;
    input SUMCAPIN_EN;
    input [5:0] itrim_2_3;
    input [5:0] itrim_sum;
    input [9:0] itrim_1;
    input iin;
    input iinc;
    inout [7:0] dout;
    input SCANINPUT;
    input SCANMODE;
    input SCANCLK;
    input SCANEN;
    input reset_b;
    input EN_DEM;
    inout [7:0] test;
    input TESTMODE;
    input VCM;
    inout vgndd_vnb;
    inout vpwr_int;
    inout vpwrd_int;
endmodule
