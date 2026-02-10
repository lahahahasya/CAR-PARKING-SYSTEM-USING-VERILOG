## 🚗 Car Parking System (Verilog FSM)

```verilog
module Car_Parking_System(
input clk, reset,
input entrance_sensor, exit_sensor,
input [1:0] password_user1, password_user2,
output wire green_light, red_light,
output reg [6:0] hex1
);

/*
There are 5 states of the FSM:

- IDLE_STATE: Initial state of the system that waits sensor inputs
- PASSWORD_WAITING_STATE: When the entrance sensor is activated
- WRONG_PASSWORD_STATE: If the entered password of the user is wrong
- CORRECT_PASSWORD_STATE: If the entered password of the user is correct
- WAIT_STATE: If the entrance and the exit sensors are activated at the same time
*/

parameter IDLE_STATE = 3'b000,
          PASSWORD_WAITING_STATE = 3'b001,
          WRONG_PASSWORD_STATE = 3'b010,
          CORRECT_PASSWORD_STATE = 3'b011,
          WAIT_STATE = 3'b100;

reg [2:0] current_state, next_state;
reg [31:0] counter;
reg green_light_tmp, red_light_tmp;

always @(posedge clk or negedge reset)
begin
    if(~reset)
        current_state = IDLE_STATE;
    else
        current_state = next_state;
end

always @(posedge clk or negedge reset)
begin
    if(~reset)
        counter <= 0;
    else if(current_state == PASSWORD_WAITING_STATE)
        counter <= counter + 1;
    else
        counter <= 0;
end

always @(*)
begin
case(current_state)

IDLE_STATE:
begin
    if (entrance_sensor == 1)
        next_state = PASSWORD_WAITING_STATE;
    else
        next_state = IDLE_STATE;
end

PASSWORD_WAITING_STATE:
begin
    if (counter <= 3)
        next_state = PASSWORD_WAITING_STATE;
    else
    begin
        if((password_user1 == 2'b01) && (password_user2 == 2'b11))
            next_state = CORRECT_PASSWORD_STATE;
        else
            next_state = WRONG_PASSWORD_STATE;
    end
end

WRONG_PASSWORD_STATE:
begin
    if((password_user1 == 2'b01) && (password_user2 == 2'b11))
        next_state = CORRECT_PASSWORD_STATE;
    else
        next_state = WRONG_PASSWORD_STATE;
end

CORRECT_PASSWORD_STATE:
begin
    if(entrance_sensor == 1 && exit_sensor == 1)
        next_state = WAIT_STATE;
    else if(exit_sensor == 1)
        next_state = IDLE_STATE;
    else
        next_state = CORRECT_PASSWORD_STATE;
end

WAIT_STATE:
begin
    if((password_user1 == 2'b01) && (password_user2 == 2'b11))
        next_state = CORRECT_PASSWORD_STATE;
    else
        next_state = WAIT_STATE;
end

default: next_state = IDLE_STATE;

endcase
end

always @(posedge clk)
begin
case(current_state)

IDLE_STATE:
begin
    green_light_tmp = 1'b0;
    red_light_tmp   = 1'b0;
    hex1 = 7'b111_1111;
end

PASSWORD_WAITING_STATE:
begin
    green_light_tmp = 1'b0;
    red_light_tmp   = 1'b1;
    hex1 = 7'b011_0000;
end

WRONG_PASSWORD_STATE:
begin
    green_light_tmp = 1'b0;
    red_light_tmp   = 1'b1;
    hex1 = 7'b011_1000;
end

CORRECT_PASSWORD_STATE:
begin
    green_light_tmp = 1'b1;
    red_light_tmp   = 1'b0;
    hex1 = 7'b011_0001;
end

WAIT_STATE:
begin
    green_light_tmp = 1'b0;
    red_light_tmp   = 1'b1;
    hex1 = 7'b010_0100;
end

endcase
end

assign green_light = green_light_tmp;
assign red_light   = red_light_tmp;

endmodule
```
