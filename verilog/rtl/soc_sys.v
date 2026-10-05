`default_nettype none
/*
 * soc_sys — Wishbone fabric for the sensor SoC digital island.
 *
 *   0x30000000  afe_wb CSR (DSM front end)
 *   0x30001000  CF_UART
 *   0x30002000  CF_SPI
 *   0x30003000  CF_I2C
 *   0x30004000  CF_TMR32 #0  (PWM0 on GPIO 24)
 *   0x30005000  CF_TMR32 #1  (PWM0 on GPIO 25)
 *   0x30006000  CF_TMR32 #2  (tick / PWM0 on GPIO 26)
 *   0x30007000  CAP / GPIO CSR
 *   0x30010000  CF_SRAM_1024x32 (1024 x 32-bit words)
 *
 * CAP_CTRL[0] starts a burst. Each SRAM write stores the current DSM
 * dout byte plus the two overload flags until CAP_COUNT words. The
 * modulator is clocked by wb_clk_i. Firmware must enable each CF_* GCLK
 * register (offset 0xFF10) before using that block.
 */

module soc_sys (
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

    output        sram_stb_o,
    output        sram_cyc_o,
    output        sram_we_o,
    output [3:0]  sram_sel_o,
    output [31:0] sram_adr_o,
    output [31:0] sram_dat_o,
    input         sram_ack_i,
    input  [31:0] sram_dat_i,

    input  [7:0]  adc_dout,
    input         adc_ov_zero,
    input         adc_ov_one,
    input         adc_scanout,
    input         adc_test_dig,
    input         adc_chopclk,
    input  [7:0]  adc_test,
    output [206:0] analog_ctrl,

    input  [30:0] io_in,
    output [30:0] io_out,
    output [30:0] io_oeb,
    output [2:0]  user_irq
);

    /* Ports stay zero-based: netgen renumbers a [37:7] macro port to
     * [30:0] while Magic keeps the literal LEF pin names, so a non-zero
     * base shows up as a 7-bit port shift at wrapper LVS. gpio_* carries
     * the Caravel GPIO numbering inside. */
    wire [37:7] gpio_in = io_in;
    wire [37:7] gpio_out;
    wire [37:7] gpio_oeb;

    assign io_out = gpio_out;
    assign io_oeb = gpio_oeb;

    /* Caravel gives wb_rst_i half a clock of external delay. Register it
     * at this boundary so that path ends at one flop. Assertion and
     * release inside the macro follow the pin by two wb_clk_i cycles. */
    reg rst_meta;
    reg rst_sync;
    always @(posedge wb_clk_i) begin
        rst_meta <= wb_rst_i;
        rst_sync <= rst_meta;
    end

    wire        host_valid = wbs_cyc_i & wbs_stb_i;
    wire        in_user    = (wbs_adr_i[31:20] == 12'h300);
    wire [7:0]  slot       = wbs_adr_i[19:12];

    wire afe_sel  = in_user & (slot == 8'h00);
    wire uart_sel = in_user & (slot == 8'h01);
    wire spi_sel  = in_user & (slot == 8'h02);
    wire i2c_sel  = in_user & (slot == 8'h03);
    wire tmr0_sel = in_user & (slot == 8'h04);
    wire tmr1_sel = in_user & (slot == 8'h05);
    wire tmr2_sel = in_user & (slot == 8'h06);
    wire cap_sel  = in_user & (slot == 8'h07);
    wire sram_sel = in_user & (wbs_adr_i[19:16] == 4'h1);

    wire        afe_ack, uart_ack, spi_ack, i2c_ack, tmr0_ack, tmr1_ack, tmr2_ack;
    wire [31:0] afe_dat, uart_dat, spi_dat, i2c_dat, tmr0_dat, tmr1_dat, tmr2_dat;
    wire        uart_irq, spi_irq, i2c_irq, tmr0_irq, tmr1_irq, tmr2_irq;
    wire        uart_tx, spi_mosi, spi_csb, spi_sclk;
    wire        scl_o, scl_oen, sda_o, sda_oen;
    wire        tmr0_pwm0, tmr0_pwm1, tmr1_pwm0, tmr1_pwm1, tmr2_pwm0, tmr2_pwm1;
    wire [27:0] afe_pad_oeb, afe_pad_out;

    afe_wb u_afe_wb (
        .wb_clk_i(wb_clk_i),
        .wb_rst_i(rst_sync),
        .wbs_stb_i(wbs_stb_i & afe_sel),
        .wbs_cyc_i(wbs_cyc_i & afe_sel),
        .wbs_we_i(wbs_we_i),
        .wbs_sel_i(wbs_sel_i),
        .wbs_dat_i(wbs_dat_i),
        .wbs_adr_i(wbs_adr_i),
        .wbs_ack_o(afe_ack),
        .wbs_dat_o(afe_dat),
        .adc_dout(adc_dout),
        .adc_ov_zero(adc_ov_zero),
        .adc_ov_one(adc_ov_one),
        .adc_scanout(adc_scanout),
        .adc_test_dig(adc_test_dig),
        .adc_chopclk(adc_chopclk),
        .adc_test(adc_test),
        .analog_ctrl(analog_ctrl),
        .analog_io_oeb(afe_pad_oeb),
        .analog_io_out(afe_pad_out)
`ifdef USE_POWER_PINS
        ,
        .vccd1(vccd1),
        .vssd1(vssd1)
`endif
    );

    CF_UART_WB u_uart (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(uart_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & uart_sel),
        .stb_i(wbs_stb_i & uart_sel),
        .ack_o(uart_ack),
        .we_i(wbs_we_i),
        .IRQ(uart_irq),
        .rx(gpio_in[23]),
        .tx(uart_tx)
    );

    CF_SPI_WB u_spi (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(spi_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & spi_sel),
        .stb_i(wbs_stb_i & spi_sel),
        .ack_o(spi_ack),
        .we_i(wbs_we_i),
        .IRQ(spi_irq),
        .miso(gpio_in[18]),
        .mosi(spi_mosi),
        .csb(spi_csb),
        .sclk(spi_sclk)
    );

    CF_I2C_WB u_i2c (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(i2c_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & i2c_sel),
        .stb_i(wbs_stb_i & i2c_sel),
        .ack_o(i2c_ack),
        .we_i(wbs_we_i),
        .IRQ(i2c_irq),
        .scl_i(gpio_in[20]),
        .scl_o(scl_o),
        .scl_oen_o(scl_oen),
        .sda_i(gpio_in[21]),
        .sda_o(sda_o),
        .sda_oen_o(sda_oen)
    );

    CF_TMR32_WB u_tmr0 (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(tmr0_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & tmr0_sel),
        .stb_i(wbs_stb_i & tmr0_sel),
        .ack_o(tmr0_ack),
        .we_i(wbs_we_i),
        .IRQ(tmr0_irq),
        .pwm0(tmr0_pwm0),
        .pwm1(tmr0_pwm1),
        .pwm_fault(1'b0)
    );

    CF_TMR32_WB u_tmr1 (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(tmr1_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & tmr1_sel),
        .stb_i(wbs_stb_i & tmr1_sel),
        .ack_o(tmr1_ack),
        .we_i(wbs_we_i),
        .IRQ(tmr1_irq),
        .pwm0(tmr1_pwm0),
        .pwm1(tmr1_pwm1),
        .pwm_fault(1'b0)
    );

    CF_TMR32_WB u_tmr2 (
        .clk_i(wb_clk_i),
        .rst_i(rst_sync),
        .adr_i(wbs_adr_i),
        .dat_i(wbs_dat_i),
        .dat_o(tmr2_dat),
        .sel_i(wbs_sel_i),
        .cyc_i(wbs_cyc_i & tmr2_sel),
        .stb_i(wbs_stb_i & tmr2_sel),
        .ack_o(tmr2_ack),
        .we_i(wbs_we_i),
        .IRQ(tmr2_irq),
        .pwm0(tmr2_pwm0),
        .pwm1(tmr2_pwm1),
        .pwm_fault(1'b0)
    );

    localparam [31:0] CAP_ID_VALUE = 32'h50C0_0001;
    localparam [2:0]  ST_IDLE = 3'd0;
    localparam [2:0]  ST_RUN  = 3'd1;
    localparam [2:0]  ST_WR   = 3'd2;

    reg        cap_ack;
    reg [31:0] cap_rdata;
    reg        cap_en;
    reg [9:0]  cap_count;
    reg [9:0]  cap_ptr;
    reg        cap_busy;
    reg        cap_done;
    reg [2:0]  cap_gpio_out;
    reg [2:0]  cap_gpio_oeb;
    reg [2:0]  cap_st;

    wire cap_wr   = (cap_st == ST_WR);
    wire host_sram = sram_sel & host_valid & ~cap_wr;

    always @(posedge wb_clk_i) begin
        if (rst_sync) begin
            cap_ack     <= 1'b0;
            cap_rdata   <= 32'b0;
            cap_en      <= 1'b0;
            cap_count   <= 10'd8;
            cap_ptr     <= 10'b0;
            cap_busy    <= 1'b0;
            cap_done    <= 1'b0;
            cap_gpio_out <= 3'b0;
            cap_gpio_oeb <= 3'b111;
            cap_st      <= ST_IDLE;
        end else begin
            cap_ack <= cap_sel & host_valid & ~cap_ack;
            if (cap_sel & host_valid & wbs_we_i & ~cap_ack) begin
                case (wbs_adr_i[5:2])
                    4'd1: cap_en <= wbs_dat_i[0];
                    4'd2: cap_count <= wbs_dat_i[9:0];
                    4'd4: begin
                        cap_gpio_out <= wbs_dat_i[2:0];
                        cap_gpio_oeb <= wbs_dat_i[5:3];
                    end
                    default: ;
                endcase
            end
            if (cap_sel & host_valid & ~wbs_we_i & ~cap_ack) begin
                case (wbs_adr_i[5:2])
                    4'd0: cap_rdata <= CAP_ID_VALUE;
                    4'd1: cap_rdata <= {31'b0, cap_en};
                    4'd2: cap_rdata <= {22'b0, cap_count};
                    4'd3: cap_rdata <= {14'b0, cap_done, cap_busy, 6'b0, cap_ptr};
                    4'd4: cap_rdata <= {23'b0, gpio_in[37:35], cap_gpio_oeb, cap_gpio_out};
                    default: cap_rdata <= 32'b0;
                endcase
            end

            case (cap_st)
                ST_IDLE: begin
                    if (cap_en) begin
                        cap_en   <= 1'b0;
                        cap_busy <= 1'b1;
                        cap_done <= 1'b0;
                        cap_ptr  <= 10'b0;
                        cap_st   <= ST_RUN;
                    end
                end
                ST_RUN: begin
                    if (~host_sram)
                        cap_st <= ST_WR;
                end
                ST_WR: begin
                    if (sram_ack_i) begin
                        if (cap_ptr + 10'd1 >= cap_count) begin
                            cap_busy <= 1'b0;
                            cap_done <= 1'b1;
                            cap_ptr  <= cap_ptr + 10'd1;
                            cap_st   <= ST_IDLE;
                        end else begin
                            cap_ptr <= cap_ptr + 10'd1;
                            cap_st  <= ST_RUN;
                        end
                    end
                end
                default: cap_st <= ST_IDLE;
            endcase
        end
    end

    assign sram_cyc_o = cap_wr | (sram_sel & wbs_cyc_i);
    assign sram_stb_o = cap_wr | (sram_sel & wbs_stb_i);
    assign sram_we_o  = cap_wr | wbs_we_i;
    assign sram_sel_o = 4'hF;
    assign sram_adr_o = cap_wr ? {20'h30010, cap_ptr, 2'b00} : wbs_adr_i;
    assign sram_dat_o = cap_wr ? {22'b0, adc_ov_one, adc_ov_zero, adc_dout} : wbs_dat_i;

    assign wbs_ack_o =
        (afe_sel  & afe_ack)  |
        (uart_sel & uart_ack) |
        (spi_sel  & spi_ack)  |
        (i2c_sel  & i2c_ack)  |
        (tmr0_sel & tmr0_ack) |
        (tmr1_sel & tmr1_ack) |
        (tmr2_sel & tmr2_ack) |
        (cap_sel  & cap_ack)  |
        (sram_sel & sram_ack_i & ~cap_wr);

    assign wbs_dat_o =
        afe_sel  ? afe_dat  :
        uart_sel ? uart_dat :
        spi_sel  ? spi_dat  :
        i2c_sel  ? i2c_dat  :
        tmr0_sel ? tmr0_dat :
        tmr1_sel ? tmr1_dat :
        tmr2_sel ? tmr2_dat :
        cap_sel  ? cap_rdata :
        sram_sel ? sram_dat_i :
        32'b0;

    /* Analog GPIOs stay Hi-Z. Digital map:
     * 16 SCLK  17 MOSI  18 MISO  19 CSB
     * 20 SCL   21 SDA   22 UTx   23 URx
     * 24 T0    25 T1    26 T2    30 irq
     * 35-37 spare GPIO
     */
    genvar gi;
    generate
        for (gi = 7; gi <= 37; gi = gi + 1) begin : g_io
            if ((gi >= 7 && gi <= 15) || (gi >= 27 && gi <= 29) || (gi >= 31 && gi <= 34)) begin
                assign gpio_out[gi] = 1'b0;
                assign gpio_oeb[gi] = 1'b1;
            end
        end
    endgenerate

    assign gpio_out[16] = spi_sclk;
    assign gpio_oeb[16] = 1'b0;
    assign gpio_out[17] = spi_mosi;
    assign gpio_oeb[17] = 1'b0;
    assign gpio_out[18] = 1'b0;
    assign gpio_oeb[18] = 1'b1;
    assign gpio_out[19] = spi_csb;
    assign gpio_oeb[19] = 1'b0;
    assign gpio_out[20] = scl_o;
    assign gpio_oeb[20] = scl_oen;
    assign gpio_out[21] = sda_o;
    assign gpio_oeb[21] = sda_oen;
    assign gpio_out[22] = uart_tx;
    assign gpio_oeb[22] = 1'b0;
    assign gpio_out[23] = 1'b0;
    assign gpio_oeb[23] = 1'b1;
    assign gpio_out[24] = tmr0_pwm0;
    assign gpio_oeb[24] = 1'b0;
    assign gpio_out[25] = tmr1_pwm0;
    assign gpio_oeb[25] = 1'b0;
    assign gpio_out[26] = tmr2_pwm0;
    assign gpio_oeb[26] = 1'b0;
    assign gpio_out[30] = cap_done | uart_irq | spi_irq | i2c_irq | tmr0_irq | tmr1_irq | tmr2_irq;
    assign gpio_oeb[30] = 1'b0;
    assign gpio_out[35] = cap_gpio_out[0];
    assign gpio_oeb[35] = cap_gpio_oeb[0];
    assign gpio_out[36] = cap_gpio_out[1];
    assign gpio_oeb[36] = cap_gpio_oeb[1];
    assign gpio_out[37] = cap_gpio_out[2];
    assign gpio_oeb[37] = cap_gpio_oeb[2];

    assign user_irq[0] = uart_irq | spi_irq | i2c_irq;
    assign user_irq[1] = tmr0_irq | tmr1_irq | tmr2_irq;
    assign user_irq[2] = cap_done;

endmodule

`default_nettype wire
