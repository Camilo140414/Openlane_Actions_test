`timescale 1ns / 1ps

 module Cafe(
    input S2,
    input S1,
    input S0,
    input P,
    input clk,
    output reg [1:0] M,
    output reg G,
    output reg C
    );
    
//parametros de la maquina de estado

    parameter [2:0] A0 = 3'b000;
    parameter [2:0] A1 = 3'b001;
    parameter [2:0] A2 = 3'b010;
    parameter [2:0] A3 = 3'b011;
    parameter [2:0] A4 = 3'b100;
    parameter [2:0] A5 = 3'b101; 
    parameter [2:0] A6 = 3'b110;
    parameter [2:0] A7 = 3'b111;
    
    reg [2:0] presente = A0;
    reg [2:0] futuro;
         
// FSM (logica de salida)
always @(presente)
        case(presente)
            A0: 
                begin 
                M <=2'b00;
                G <=1'b0;
                C <=1'b0;
                end
            A1: 
                begin 
                M <=2'b01;
                G <=1'b0;
                C <=1'b0;
                end
            A2: 
                begin 
                M <=2'b00;
                G <=1'b1;
                C <=1'b0;
                end  
            A3: 
                begin 
                M <=2'b01;
                G <=1'b1;
                C <=1'b0;
                end     
            A4: 
                begin 
                M <=2'b00;
                G <=1'b1;
                C <=1'b1;
                end
            A5: 
                begin 
                M <=2'b00;
                G <=1'b1;
                C <=1'b1;
                end
            default: 
                begin 
                M <=2'b10;
                G <=1'b1;
                C <=1'b0;
                end  
    
           endcase 
//FSM (Lógica del estado siguiente)
    always @(posedge clk)
        presente <= futuro;
        
//FSM (logica del estado siguiente)
always@(presente,S2,S1,S0,P)
    case(presente)
    A0: if(P)
            futuro <= A1;
            else
           if(S2)
                futuro <= A1;
                 else
                futuro <= A0;
    A1: futuro<= A2;
    A2: if(S1)
             futuro <= A3;
        else 
             futuro <= A2;
    A3: futuro <= A4;
    A4: if(S0)
            futuro <= A5;
        else
            futuro <= A4;
    A5: if(S0)
            futuro <= A6;
        else
            futuro <= A5;
    default: futuro <= A0;  
    endcase       
endmodule
