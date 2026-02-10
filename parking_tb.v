## 🧪 Testbench – Car Parking FSM

```verilog
module parking_tb;

reg clk;
reg reset;
reg entrance_sensor;
reg exit_sensor;
reg [1:0] password_user1;
reg [1:0] password_user2;

wire green_light;
wire red_light;
wire [6:0] hex1;


Car_Parking_System uut (
    .clk(clk),
    .reset(reset),
    .entrance_sensor(entrance_sensor),
    .exit_sensor(exit_sensor),
    .password_user1(password_user1),
    .password_user2(password_user2),
    .green_light(green_light),
    .red_light(red_light),
    .hex1(hex1)
);


// Clock Generation
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end


initial begin

    reset = 0;
    entrance_sensor = 0;
    exit_sensor = 0;
    password_user1 = 0;
    password_user2 = 0;

    #50;
    reset = 1;


    // Scenario 1: Correct password and entrance triggered
    #50;
    entrance_sensor = 1;
    password_user1 = 2'b01;
    password_user2 = 2'b10;
    #100;
    entrance_sensor = 0;


    // Scenario 2: Wrong password check
    #200;
    entrance_sensor = 1;
    password_user1 = 2'b01;
    password_user2 = 2'b11;
    #100;
    entrance_sensor = 0;

    #100;
    entrance_sensor = 1;
    exit_sensor = 1;
    password_user1 = 2'b01;
    password_user2 = 2'b10;
    #100;
    entrance_sensor = 0;
    exit_sensor = 0;

    #100;
    entrance_sensor = 1;
    password_user1 = 2'b10;
    password_user2 = 2'b00;
    #100;
    entrance_sensor = 0;

    #100;
    $finish;

end

endmodule
```
