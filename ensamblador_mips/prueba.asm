.data
$r0: .word 0x0003 ## registro fuente 1
$r1: .word 0x0002 ## registro fuente 2
$r3: .word 0x0000 ## registro destino
$LO: .word 0xa000 ## Registro LO
pc: .word 0x000d ## Registro PC
.text

## Operacion Suma 0000
lw $s0, $r0
lw $s1, $r1
add $s2, $s1, $s0
sw $s2, $r3
##  Operacion Suma con un inmediato 0001
lw $s0, $r0
add $s2, $s0, $t5 # $t5 se encuentra el inmediato
sw $s2, $r3
## Operacion de resta 0010
lw $s0, $r0
lw $s1, $r1
sub $s2, $s0, $s1
sw $s2, $r3
## Operacion de resta con un inmediato 0011
lw $s0, $r0
sub $s2, $s0, $t5 ## $t5 se encuentra el inmediato
sw $s2, $r3
## Operacion AND con 2 registros 0100
lw $s0, $r0
lw $s1, $r1
and $s2,$s1,$s0
sw $s2, $r3
## Operacion ANDi con un inmediato 0101
lw $s0, $r0
and $s2,$s1,$t5 ## Siendo $t5 el registro q contenga el inmediato
sw $s2, $r3
## Operacion OR con 2 registros 0110
lw $s0, $r0
lw $s1, $r1
or $s2, $s0, $s1
sw $s2, $r3
## Operacion ORi con un inmediato 0111
lw $s0, $r0
or $s2, $s0, $t5 ## Siendo $t5 el registro que contenga el inmediato
sw $s2, $r3
## Operacion MULT con 2 registros 1000
lw $s0, $r0
lw $s1, $r1
mult $s0, $s1
sw $s2, $r3  ## NESECITOUSAR EL REGISTRO  " lo "
## Operacion XOR con 2 registros 1001
lw $s0, $r0
lw $s1, $r1
xor $s2, $s0, $s1
sw $s2, $r3
## Operacion NOR con 1 registro 1010
lw $s0, $r0
not $s2, $s0
sw $s2, $r3
## Operacion LI 1011
sw $t5, $r3 ## Siendo $t5 el registro que contenga el inmediato
## Operacion MOV 1100
lw $s0, $r0
move $s2, $s0
sw $s2, $r3
## Operacion MOVLO 1101
lw $s0, $LO
move $s2, $s0
sw $s2, $r3
## Operacion JUMP 1110
move $t4, $t5 ## $t5 contiene la direccion del JUMP
sw $t4, pc

