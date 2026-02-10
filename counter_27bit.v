```verilog
module counter_27bit(
input clk, reset,
output reg [26:0] q
);

always @(posedge clk) begin
    if(reset)
        q = 27'd0;
    else
        q = q + 27'd1;
end

endmodule


module parking_system(
input clk,
input reset,
input car_enter,
input car_leave,
output reg [3:0] free_slots,
output reg [6:0] seven_seg
);

wire [26:0] clk_1;
counter_27bit c1(clk, reset, clk_1);

reg car_enter_reg1, car_enter_reg2;
reg car_leave_reg1, car_leave_reg2;

parameter TOTAL_SLOTS = 9;


// 7-Segment Display Decoder
always @(free_slots) begin
case(free_slots)

4'd0: seven_seg = 7'b0000001;
4'd1: seven_seg = 7'b1001111;
4'd2: seven_seg = 7'b0010010;
4'd3: seven_seg = 7'b0000110;
4'd4: seven_seg = 7'b1001100;
4'd5: seven_seg = 7'b0100100;
4'd6: seven_seg = 7'b0100000;
4'd7: seven_seg = 7'b0001111;
4'd8: seven_seg = 7'b0000000;
4'd9: seven_seg = 7'b0000100;

default: seven_seg = 7'b1111111;

endcase
end


// Debouncing and Edge Detection Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        car_enter_reg1 <= 0;
        car_enter_reg2 <= 0;
        car_leave_reg1 <= 0;
        car_leave_reg2 <= 0;
    end
    else begin
        car_enter_reg1 <= car_enter;
        car_enter_reg2 <= car_enter_reg1;
        car_leave_reg1 <= car_leave;
        car_leave_reg2 <= car_leave_reg1;
    end
end


// Free Slot Counter Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        free_slots <= TOTAL_SLOTS;
    end
    else begin
        if (!car_enter_reg2 && car_enter_reg1 && free_slots > 0)
            free_slots <= free_slots - 1;

        else if (!car_leave_reg2 && car_leave_reg1 && free_slots < TOTAL_SLOTS)
            free_slots <= free_slots + 1;
    end
end

endmodule
```
