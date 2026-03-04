/*
 * Hacky baud rate generator to divide a 50MHz clock into a 115200 baud
 * rx/tx pair where the rx clcken oversamples by 16x.
 */
module baud_rate_gen(input wire clk_50m,
					 input wire reset,
		     output wire txclk_en);

parameter TX_ACC_MAX = 50000000 / 115200;

parameter TX_ACC_WIDTH = $clog2(TX_ACC_MAX);

reg [TX_ACC_WIDTH - 1:0] tx_acc;
assign txclk_en = (tx_acc == 9'd0);



always @(posedge clk_50m) begin
	if (reset) begin
		tx_acc <= 0;
	end
	if (tx_acc == TX_ACC_MAX[TX_ACC_WIDTH - 1:0])
		tx_acc <= 0;
	else
		tx_acc <= tx_acc + 9'b1;
end

endmodule
