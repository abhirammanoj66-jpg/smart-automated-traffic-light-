`timescale 1ns/1ps

module traffic_tb;

    reg clk;
    reg rst;
    reg ns_sensor;
    reg ew_sensor;

    wire [1:0] ns_light;
    wire [1:0] ew_light;

    smart_traffic_controller uut(
        .clk(clk),
        .rst(rst),
        .ns_sensor(ns_sensor),
        .ew_sensor(ew_sensor),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst = 1;
        ns_sensor = 0;
        ew_sensor = 0;

        #10 rst = 0;

        #100;

        $finish;
    end

endmodule