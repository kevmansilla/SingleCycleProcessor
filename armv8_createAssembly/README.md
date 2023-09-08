## Verificacion
Antes de comenzar, verificar que los registros X0 a X30 estén inicializados con los
valores 0 a 30 respectivamente en la descripción del módulo regfile.

```
    STUR X0, [X0, #0]
    STUR X1, [X0, #8]
    STUR X2, [X0, #16]
    STUR X3, [X0, #24]
    STUR X4, [X0, #32]
    STUR X5, [X0, #40]
    STUR X6, [X0, #48]
    STUR X7, [X0, #56]
    STUR X8, [X0, #64]
    STUR X9, [X0, #72]
    STUR X10, [X0, #80]
    STUR X11, [X0, #88]
    STUR X12, [X0, #96]
    STUR X13, [X0, #104]
    STUR X14, [X0, #112]
    STUR X15, [X0, #120]
    STUR X16, [X0, #128]
    STUR X17, [X0, #136]
    STUR X18, [X0, #144]
    STUR X19, [X0, #152]
    STUR X20, [X0, #160]
    STUR X21, [X0, #168]
    STUR X22, [X0, #176]
    STUR X23, [X0, #184]
    STUR X24, [X0, #192]
    STUR X25, [X0, #200]
    STUR X26, [X0, #208]
    STUR X27, [X0, #216]
    STUR X28, [X0, #224]
    STUR X29, [X0, #232]
    STUR X30, [X0, #240]
    exitloop:
    CBZ XZR, exitloop
    ```

## Ejercicio 2a
Con la menor cantidad de registros e instrucciones, inicializar con el valor de su
índice las primeras N posiciones de memoria (comenzando en la dirección “0”).

```
    add x2, x0, XZR  stur x30, [x0, #240]
loop:  stur x2, [x0, #0]
    add x2,x2,x1  add x0,x0,x8
    sub x30, x30, x1  cbz x30,infLoop
    cbz XZR,loopinfLoop:  
    cbz XZR, infLoop
```
## Ejercicio 2b
Realizar la sumatoria de las primeras N posiciones de memoria y guardar elresultado en la posición N+1.
```
    add x2, x0, XZR  add x7, x0, XZR
    add x0, x0, x8loop:
    stur x2, [x0, #0]  add x0, x0, x8
    add x7, x7, x1  add x2, x2, x7
    sub x5, x5, x1  cbz x5, infLoop
    cbz XZR, loopinfLoop:
    cbz XZR, infLoop
    ```
## Ejercicio 2c
```  
add x2,XZR,XZR
loop: add x2, x2, x16
    sub x17, x17, x1  cbz x17, loop1
    cbz XZR, looploop1:
    stur x2, [x0, #0]infLoop:  
    cbz XZR, infLoop
```