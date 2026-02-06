`timescale 1ns/1ps
module vending_machine(
    input clk,
    input reset,
    input coin_5,    
    input coin_10,  
    input coin_20,  
    input coin_50,  
    input select_1,  
    input select_2,  
    input select_3,  
   
    output reg dispense_1,
    output reg dispense_2,
    output reg dispense_3,
    output reg change_5,  
    output reg change_10,  
    output reg change_20,  
    output reg change_50,  
    output reg out_of_stock   // Single LED for out of stock
);

    reg [7:0] total;
    reg [1:0] stock_1, stock_2, stock_3;  // 2-bit stock counters

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            total <= 0;
            dispense_1 <= 0; dispense_2 <= 0; dispense_3 <= 0;
            change_5 <= 0; change_10 <= 0; change_20 <= 0; change_50 <= 0;
            stock_1 <= 2; stock_2 <= 2; stock_3 <= 2;
            out_of_stock <= 0;
        end else begin
            dispense_1 <= 0; dispense_2 <= 0; dispense_3 <= 0;
            change_5 <= 0; change_10 <= 0; change_20 <= 0; change_50 <= 0;
            out_of_stock <= 0;  // default off

            // Add coins to total
            if (coin_5)  total <= total + 5;
            if (coin_10) total <= total + 10;
            if (coin_20) total <= total + 20;
            if (coin_50) total <= total + 50;

            // Product 1 costs 15
            if (select_1) begin
                if (stock_1 > 0 && total >= 15) begin
                    dispense_1 <= 1;
                    stock_1 <= stock_1 - 1;
                    if (total > 15) begin
                        if (total - 15 >= 10) change_10 <= 1;
                        else if (total - 15 >= 5) change_5 <= 1;
                    end
                    total <= 0;
                end else if (stock_1 == 0) begin
                    out_of_stock <= 1;  // indicate out of stock
                end
            end

            // Product 2 costs 25
            if (select_2) begin
                if (stock_2 > 0 && total >= 25) begin
                    dispense_2 <= 1;
                    stock_2 <= stock_2 - 1;
                    if (total > 25) begin
                        if (total - 25 >= 10) change_10 <= 1;
                        else if (total - 25 >= 5) change_5 <= 1;
                    end
                    total <= 0;
                end else if (stock_2 == 0) begin
                    out_of_stock <= 1;
                end
            end

            // Product 3 costs 45
            if (select_3) begin
                if (stock_3 > 0 && total >= 45) begin
                    dispense_3 <= 1;
                    stock_3 <= stock_3 - 1;
                    if (total > 45) begin
                        if (total - 45 >= 50) change_50 <= 1;
                        else if (total - 45 >= 20) change_20 <= 1;
                        else if (total - 45 >= 10) change_10 <= 1;
                        else if (total - 45 >= 5) change_5 <= 1;
                    end
                    total <= 0;
                end else if (stock_3 == 0) begin
                    out_of_stock <= 1;
                end
            end
        end
    end

endmodule
