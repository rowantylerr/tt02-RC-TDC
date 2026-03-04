module uart(input wire [7:0] din,
	    input wire wr_en,
	    input wire clk_50m,
	    input wire reset,   // Synchronous active-high reset — stops any in-flight byte
	    output wire tx,
	    output wire tx_busy
//	    input wire rx,
//	    output wire rdy,
//	    input wire rdy_clr,
//	    output wire [7:0] dout
		);

wire txclk_en;

baud_rate_gen uart_baud(.clk_50m(clk_50m),
			.reset(reset),
			.txclk_en(txclk_en));

transmitter uart_tx(.din(din),
		    .wr_en(wr_en),
		    .clk_50m(clk_50m),
		    .clken(txclk_en),
		    .reset(reset),
		    .tx(tx),
		    .tx_busy(tx_busy));

//receiver uart_rx(
//		.rx(rx),
//		 .rdy(rdy),
//		 .rdy_clr(rdy_clr),
//		 .clk_50m(clk_50m),
//		 .clken(rxclk_en),
//		 .data(dout));

endmodule
