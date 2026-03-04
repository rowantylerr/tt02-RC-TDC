module input_timer(step_set, step_input, clk, reset, timer_output, overflow, clear);

    input clk;
    input reset;
    input step_input;
    input step_set;
    input clear;

    output wire [23:0] timer_output;
    output wire overflow;

    reg [23:0] counter;
    reg timer_stop;
    reg overflow_reg;

    always @(posedge clk) begin        
        if (reset || clear) begin
            counter <= 24'd0;
            timer_stop <= 1'b0;
            overflow_reg <= 1'b0;
        end 
        
        else if (step_set && !timer_stop) begin
            counter <= counter + 1;
            if (counter == 24'hFFFFFF) begin
                counter <= 24'd0;
                overflow_reg <= 1'b1;
            end
            else if (step_input == 1'b1) begin
                timer_stop <= 1'b1;
            end
        end
    end

    assign timer_output = counter;
    assign overflow = overflow_reg;


endmodule
