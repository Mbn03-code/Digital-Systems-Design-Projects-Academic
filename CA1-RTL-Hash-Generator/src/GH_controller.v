module GH_controller(
input  wire       clk,
input  wire       reset,
input  wire       start,
input  wire       prng_done,
input  wire [5:0] count,

output reg        start_prng,
output reg        stage_load,
output reg [2:0]  stage_sel,
output reg        load_init,   
output reg        count_enable,
output reg        done
);

typedef enum logic [3:0] {
IDLE = 0,
LOAD_INIT_STATE = 1,
START_PRNG = 2,
WAIT_PRNG = 3,
SAVE_PRNG = 4,
ADDER1 = 5,
ROTATE = 6,
ADDER2 = 7,
CHECK_DONE = 8,
FINALIZE = 9
} state_t;

state_t state, next;
reg finalize; 


always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        finalize <= 0;
    end 
    else begin
        state <= next;

        
        if (state == FINALIZE)
            finalize <= 1'b1;
       
        else if (done)
            finalize <= 1'b0;
    end
end

always @(*) begin
    start_prng = 0;
    stage_load = 0;
    load_init  = 0;
    stage_sel  = 0;
    count_enable = 0;
    done = 0;
    next = state;

    case(state)
        IDLE: if (start) next = LOAD_INIT_STATE;

        LOAD_INIT_STATE: begin
            load_init = 1;
            next = START_PRNG;
        end

        START_PRNG: begin
            start_prng = 1;
            next = WAIT_PRNG;
        end

        WAIT_PRNG: if (prng_done) next = SAVE_PRNG;

        SAVE_PRNG: begin
            stage_load = 1; stage_sel = 0;
            next = ADDER1;
        end

        ADDER1: begin
            stage_load = 1; stage_sel = 1;
            next = ROTATE;
        end

        ROTATE: begin
            stage_load = 1; stage_sel = 2;
            next = ADDER2;
        end

        ADDER2: begin
            stage_load = 1; stage_sel = 3;
            count_enable = 1;
            next = CHECK_DONE;
        end

        CHECK_DONE: begin
            if (finalize) begin
                done = 1'b1;   
                next = IDLE;   
            end 
            else if (count == 6'd63)
                next = FINALIZE; 
            else
                next = START_PRNG;
        end

        FINALIZE: begin
            next = START_PRNG;   
        end

        default: next = IDLE;
    endcase
end
endmodule
