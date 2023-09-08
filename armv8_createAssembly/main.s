    .text
    .org 0x0000

    add x2, x0, XZR  stur x30, [x0, #240]
loop:  stur x2, [x0, #0]
    add x2,x2,x1  add x0,x0,x8
    sub x30, x30, x1  cbz x30,infLoop
    cbz XZR,loopinfLoop:  
    cbz XZR, infLoop