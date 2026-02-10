```verilog
module tb;

reg clk;
reg reset;
reg car_enter;
reg car_leave;

wire [3:0] free_slots;
wire [3:0] profit;
wire [6:0] seven_seg;

parking_system uut (
    .clk(clk),
    .reset(reset),
    .car_enter(car_enter),
    .car_leave(car_leave),
    .free_slots(free_slots),
    .profit(profit),
    .seven_seg(seven_seg)
);


// Clock Generation
initial begin
    clk = 0;
    forever #10 clk = !clk;
end


initial begin
    reset = 1;
    car_enter = 0;
    car_leave = 0;

    #100;
    reset = 0;

    #100;
    car_enter = 1;
    #20;
    car_enter = 0;

    #100;
    car_enter = 1;
    #20;
    car_enter = 0;

    #100;
    car_leave = 1;
    #20;
    car_leave = 0;

    #100;
    car_leave = 1;
    #20;
    car_leave = 0;

    #100;
    reset = 1;
    #50;
    res
