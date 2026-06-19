module GH_controller (
    input  wire clk,
    input  wire reset,
    input  wire start,
    input  wire prng_done,
    input  wire count_done,

    output reg start_prng,
    output reg stage_load,
    output reg load_init,
    output reg count_enable,
    output reg done
);

    reg flag;
    reg [1:0] state, next_state;

    localparam SIDLE       = 2'b00;
    localparam SLOAD_INIT  = 2'b01;
    localparam SPRNG       = 2'b10;
    localparam SCHECKDONE  = 2'b11;

    //=====================
    // State Register + Flag
    //=====================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SIDLE;
            flag  <= 1'b0;
        end else begin
            state <= next_state;
            if (state == SPRNG  && count_done)
                flag <= 1'b1;
            else if (state == SIDLE)
                flag <= 1'b0;
        end
    end

    //=====================
    // Next-State Logic
    //=====================
    always @(*) begin
        next_state = state;

        case (state)
            SIDLE: begin
                if (start)
                    next_state = SLOAD_INIT;
            end

            SLOAD_INIT: begin
                next_state = SPRNG;
            end

            SPRNG: begin
                if (prng_done)
                    next_state = SCHECKDONE;
            end

            SCHECKDONE: begin
                if (flag)
                    next_state = SIDLE;
                else
                    next_state = SPRNG;
            end

            default: next_state = SIDLE;
        endcase
    end

    //=====================
    // Output Logic (Moore)
    //=====================
    always @(*) begin
        start_prng   = 1'b0;
        load_init    = 1'b0;
        count_enable = 1'b0;
        stage_load   = 1'b0;
        done         = 1'b0;

        case (state)
            SLOAD_INIT: load_init    = 1'b1;
            SPRNG:      start_prng   = 1'b1;
            SCHECKDONE: begin
                count_enable = 1'b1;
                stage_load   = 1'b1;
                if (flag)
                    done = 1'b1;
            end
        endcase
    end

endmodule
