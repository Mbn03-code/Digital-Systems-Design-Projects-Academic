module PRNG_controller(
    input wire clk,
    input wire reset,
    input wire start,
    input wire count_done,

    output reg load_reg,
    output reg count_enable,
    output reg done
);

    reg [1:0] p_state;
    reg [1:0] n_state;

    parameter S_IDLE  = 2'b00;
    parameter S_LOAD  = 2'b01;
    parameter S_SHIFT = 2'b10;
    parameter S_DONE  = 2'b11;

    
    always @(posedge clk or posedge reset) begin
        if (reset)
            p_state <= S_IDLE;
        else
            p_state <= n_state;
    end

 
    always @(*) begin
        n_state = p_state;
        load_reg = 1'b0;
        count_enable = 1'b0;
        done =1'b0;
        case (p_state)
            S_IDLE: begin
                if (start) 
                    n_state = S_LOAD;
            end
            
            S_LOAD: begin
                load_reg = 1'b1;
                n_state = S_SHIFT;
            end
            
            S_SHIFT: begin
                count_enable = 1'b1;
                if (count_done)
                    n_state = S_DONE;
            end
            
            S_DONE: begin
                done = 1'b1;
                if (!start)
                    n_state = S_IDLE;
            end
        endcase
    end

endmodule
