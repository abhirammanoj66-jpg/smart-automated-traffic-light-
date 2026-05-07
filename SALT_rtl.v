module smart_traffic_controller(
    input clk,
    input rst,
    input ns_sensor,
    input ew_sensor,
    output reg [1:0] ns_light,
    output reg [1:0] ew_light
);

    parameter RED    = 2'b00;
    parameter YELLOW = 2'b01;
    parameter GREEN  = 2'b10;

    parameter NS_GREEN  = 2'b00;
    parameter NS_YELLOW = 2'b01;
    parameter EW_GREEN  = 2'b10;
    parameter EW_YELLOW = 2'b11;

    reg [1:0] state;
    reg [3:0] timer;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            state <= NS_GREEN;
            timer <= 0;
        end
        else
        begin
            timer <= timer + 1;

            case(state)

                NS_GREEN:
                begin
                    if(timer == 5)
                    begin
                        timer <= 0;
                        state <= NS_YELLOW;
                    end
                end

                NS_YELLOW:
                begin
                    if(timer == 2)
                    begin
                        timer <= 0;
                        state <= EW_GREEN;
                    end
                end

                EW_GREEN:
                begin
                    if(timer == 5)
                    begin
                        timer <= 0;
                        state <= EW_YELLOW;
                    end
                end

                EW_YELLOW:
                begin
                    if(timer == 2)
                    begin
                        timer <= 0;
                        state <= NS_GREEN;
                    end
                end

            endcase
        end
    end

    always @(*)
    begin
        case(state)

            NS_GREEN:
            begin
                ns_light = GREEN;
                ew_light = RED;
            end

            NS_YELLOW:
            begin
                ns_light = YELLOW;
                ew_light = RED;
            end

            EW_GREEN:
            begin
                ns_light = RED;
                ew_light = GREEN;
            end

            EW_YELLOW:
            begin
                ns_light = RED;
                ew_light = YELLOW;
            end

            default:
            begin
                ns_light = RED;
                ew_light = RED;
            end

        endcase
    end

endmodule