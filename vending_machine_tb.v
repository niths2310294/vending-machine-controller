
`timescale 1ns/1ps
module vending_machine_tb;

    // Inputs
    reg clk;
    reg reset;
    reg coin_5, coin_10, coin_20, coin_50;
    reg select_1, select_2, select_3;

    // Outputs
    wire dispense_1, dispense_2, dispense_3;
    wire change_5, change_10, change_20, change_50;
    wire out_of_stock;
   
    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .coin_20(coin_20),
        .coin_50(coin_50),
        .select_1(select_1),
        .select_2(select_2),
        .select_3(select_3),
        .dispense_1(dispense_1),
        .dispense_2(dispense_2),
        .dispense_3(dispense_3),
        .change_5(change_5),
        .change_10(change_10),
        .change_20(change_20),
        .change_50(change_50),
        .out_of_stock(out_of_stock)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        coin_5 = 0; coin_10 = 0; coin_20 = 0; coin_50 = 0;
        select_1 = 0; select_2 = 0; select_3 = 0;

        #20 reset = 0;

        // ******** PRODUCT 1 TEST ********
        // Insert coins: 10 + 5 = 15
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_5  = 1; #10 coin_5  = 0;

        // Select product 1 (stock=2)
        #10 select_1 = 1; #10 select_1 = 0;

        // Select product 1 again (stock=1)
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_5  = 1; #10 coin_5  = 0;
        #10 select_1 = 1; #10 select_1 = 0;

        // Select product 1 again (stock=0 -> out_of_stock LED should turn on)
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_5  = 1; #10 coin_5  = 0;
        #10 select_1 = 1; #10 select_1 = 0;

        // ******** PRODUCT 2 TEST ********
        #10 coin_20 = 1; #10 coin_20 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;  // total=30
        #10 select_2 = 1; #10 select_2 = 0;

        // ******** PRODUCT 3 TEST ********
        #10 coin_50 = 1; #10 coin_50 = 0; // total=50
        #10 select_3 = 1; #10 select_3 = 0; // dispense and change 5

        #50 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | D1=%b D2=%b D3=%b | C5=%b C10=%b C20=%b C50=%b | OutOfStock=%b | Total Stock: P1=%0d P2=%0d P3=%0d",
                 $time, dispense_1, dispense_2, dispense_3,
                 change_5, change_10, change_20, change_50,
                 out_of_stock,
                 uut.stock_1, uut.stock_2, uut.stock_3);
    end

endmodule
