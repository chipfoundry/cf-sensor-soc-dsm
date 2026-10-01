// Structural PG wrapper. Analog leaf is CF_BUF_HIZ_core.
// Customer rails are vpwr/vgnd; well taps vpb/vnb/vpbe are tied inside.
module CF_BUF_HIZ (
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
    input vgnd;
    inout vgnd1;
    inout vgnd_core;
    input vinp1;
    input vinp2;
    input vpwr;
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
    CF_BUF_HIZ_core u_core (
        .out1(out1),
        .out2(out2),
        .lpwr(lpwr),
        .disable_p(disable_p),
        .disable_n(disable_n),
        .rail(rail),
        .rc(rc),
        .vgnd(vgnd),
        .vgnd1(vgnd1),
        .vgnd_core(vgnd_core),
        .vinp1(vinp1),
        .vinp2(vinp2),
        .vnb(vgnd),
        .vpb(vpwr),
        .vpwr(vpwr),
        .vpwr_core(vpwr_core),
        .vpwrb(vpwrb),
        .clk_chop(clk_chop),
        .gain(gain),
        .iref(iref),
        .iref_casc(iref_casc),
        .vpwrb_clk(vpwrb_clk),
        .enable_hv(enable_hv),
        .pd(pd),
        .bypass_p(bypass_p),
        .bypass_n(bypass_n),
        .vcm(vcm),
        .vpwr_acore(vpwr_acore)
    );
endmodule
