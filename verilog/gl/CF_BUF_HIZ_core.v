// Empty blackbox stub for hierarchical integration LVS.
module CF_BUF_HIZ_core (
    out1,
    out2,
    lpwr,
    disable_p,
    disable_n,
    rail,
    rc,
    vgnd,
    vgnd1,
    vgnd_core,
    vinp1,
    vinp2,
    vnb,
    vpb,
    vpwr,
    vpwr_core,
    vpwrb,
    clk_chop,
    gain,
    iref,
    iref_casc,
    vpwrb_clk,
    enable_hv,
    pd,
    bypass_p,
    bypass_n,
    vcm,
    vpwr_acore
);
    output out1;
    output out2;
    input lpwr;
    input disable_p;
    input disable_n;
    input rail;
    input rc;
    inout vgnd;
    inout vgnd1;
    inout vgnd_core;
    input vinp1;
    input vinp2;
    inout vnb;
    inout vpb;
    inout vpwr;
    inout vpwr_core;
    inout vpwrb;
    input clk_chop;
    input [1:0] gain;
    inout iref;
    inout iref_casc;
    inout vpwrb_clk;
    input enable_hv;
    input pd;
    input bypass_p;
    input bypass_n;
    inout vcm;
    inout vpwr_acore;
endmodule
