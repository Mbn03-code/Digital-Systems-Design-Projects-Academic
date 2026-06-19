module constant_rom (
    input  wire [5:0] addr,
    output reg  [7:0] data
);

    always @(*) begin
        case (addr)
            6'd0  : data = 8'h78;
            6'd1  : data = 8'h56;
            6'd2  : data = 8'hDB;
            6'd3  : data = 8'hEE;
            6'd4  : data = 8'hAF;
            6'd5  : data = 8'h2A;
            6'd6  : data = 8'h13;
            6'd7  : data = 8'h01;
            6'd8  : data = 8'hD8;
            6'd9  : data = 8'hAF;
            6'd10 : data = 8'hB1;
            6'd11 : data = 8'hBE;
            6'd12 : data = 8'h22;
            6'd13 : data = 8'h93;
            6'd14 : data = 8'h8E;
            6'd15 : data = 8'h21;
            6'd16 : data = 8'h62;
            6'd17 : data = 8'h40;
            6'd18 : data = 8'h51;
            6'd19 : data = 8'hAA;
            6'd20 : data = 8'h5D;
            6'd21 : data = 8'h53;
            6'd22 : data = 8'h81;
            6'd23 : data = 8'hC8;
            6'd24 : data = 8'hE6;
            6'd25 : data = 8'hD6;
            6'd26 : data = 8'h87;
            6'd27 : data = 8'hED;
            6'd28 : data = 8'h05;
            6'd29 : data = 8'hF8;
            6'd30 : data = 8'hD9;
            6'd31 : data = 8'h8A;
            6'd32 : data = 8'h42;
            6'd33 : data = 8'h81;
            6'd34 : data = 8'h22;
            6'd35 : data = 8'h0C;
            6'd36 : data = 8'h44;
            6'd37 : data = 8'hA9;
            6'd38 : data = 8'h60;
            6'd39 : data = 8'h70;
            6'd40 : data = 8'hC6;
            6'd41 : data = 8'hFA;
            6'd42 : data = 8'h85;
            6'd43 : data = 8'h05;
            6'd44 : data = 8'h39;
            6'd45 : data = 8'hE5;
            6'd46 : data = 8'hF8;
            6'd47 : data = 8'h65;
            6'd48 : data = 8'h44;
            6'd49 : data = 8'h97;
            6'd50 : data = 8'hA7;
            6'd51 : data = 8'h39;
            6'd52 : data = 8'hC3;
            6'd53 : data = 8'h92;
            6'd54 : data = 8'h7D;
            6'd55 : data = 8'hD1;
            6'd56 : data = 8'h4F;
            6'd57 : data = 8'hE0;
            6'd58 : data = 8'h14;
            6'd59 : data = 8'hA1;
            6'd60 : data = 8'h82;
            6'd61 : data = 8'h35;
            6'd62 : data = 8'hBB;
            6'd63 : data = 8'h91;
            default: data = 8'h00;
        endcase
    end

endmodule
