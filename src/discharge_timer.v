module discharge_timer(start, clk, reset, counter, finished, clear);

    input clk;
    input reset;
    input start;
    input clear;    
    input [23:0] counter;  
    output reg finished;

    reg started;
    reg [23:0] countdown;     // Internal register for counting down

    always @(posedge clk) begin
        if (clear || reset) begin
            countdown <= 24'd0;    // Load the input counter value
            finished <= 1'b0; 
            started <= 1'b0;  
        end 

        else if (start && !finished) begin
            if (!started) begin
                countdown <= counter * 5;
                started <= 1'b1;
            end

            else begin

                countdown <= countdown - 1;
                if (countdown == 24'd0) begin
                    finished <= 1'b1;
                end

                else begin
                    finished <= 1'b0;
                end
            end
        end
        else begin
            countdown <= countdown;
            finished <= finished;
        end
    end


endmodule
