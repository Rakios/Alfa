.data
a: .word 0x0000FF00
bb: .word 0xFF000000
c: .word 0x000000FF
.macro COMIDA
	repite: # Si la posicion esta ocupada por un cuadrito verde
	li $v0, 41 # NUMERO ALEATOREO
	syscall    # SE GUARDARA EN $a0
	la $s3, 0($a0) # cargar la direccion en $s2
	sll $s3, $s3, 4
	andi $s3, $s3 0x00000FFF # tomar los bits que me interesan
	addi $s3, $s3, 0x10000000 #sumarle 0x10000000 para empezar en la direccion del bitmap
	lw $t7, a # color verde
	lw $t6, 0($s3) # ver que color hay en esa direccion
	beq $t6, $t7, repite # Comparar si ambos son verdes. Si la posicion esta ocupada por un cuadrito verde
	
	lw $t7, c # cuadrito morado
	sw $t7, 0($s3) # asignar color morado en esa posicion
	 
.end_macro

.macro Cola
	repite: # mientras falten partes de la cola por mover
	


.end_macro
 
.text
## Hacer el mapa
COMIDA
la $t1, 0x10000000
lw $t0, a
aa:
sw $t0 ,0($t1)
addi $t1, $t1, 4
addi $t2, $t2, 1
bne $t2,32, aa

la $t1, 0x10000000
lw $t0, a
li $t2, 0
a1:
sw $t0 ,0($t1)
addi $t1, $t1, 128
addi $t2, $t2, 1
bne $t2,31, a1

li $t2, 0

a2:
sw $t0 ,0($t1)
addi $t1, $t1, 4
addi $t2, $t2, 1
bne $t2,32, a2

la $t1, 0x10000000
lw $t0, a
li $t2, 0
a3:
addi $t1, $t1, 124
sw $t0 ,0($t1)
addi $t2, $t2, 1
addi $t1, $t1, 4
bne $t2,64, a3

## LEER TECLADO

comenzar:
li $s1, 0x100001DC
sw $t2, 0($s1)

#lw $t0, a
#sw $t0, ($s1)
repetir:
li $t0,  0xffff0000
lectura:
lw $v0, 0($t0)
andi $v0, 0x01
beq $v0, $zero, lectura
lw $v0, 4($t0)
beq $v0, 0x77, arr
beq $v0, 0x61, izq
beq $v0, 0x73, aba
beq $v0, 0x64, der

arr:
lw $t2, a
lw $t3 bb
lw $t4, -128($s1)
sw $t3, 0($s1)
beq $t2, $t4 , comenzar
addi $s1, $s1, -128 
sw $t2, 0($s1)


j repetir

j repetir
izq:
lw $t2, a
lw $t3 bb
lw $t4, -4($s1)
sw $t3, 0($s1)
beq $t2, $t4 , comenzar
addi $s1, $s1, -4 
sw $t2, 0($s1)

j repetir
aba:
lw $t2, a
lw $t3 bb
lw $t4, 128($s1)
sw $t3, ($s1)
beq $t2, $t4 , comenzar
addi $s1, $s1, 128 

sw $t2, 0($s1)
j repetir
der:

lw $t2, a
lw $t3 bb
lw $t4, 4($s1)
sw $t3, 0($s1)
beq $t2, $t4 , comenzar
addi $s1, $s1, 4 
sw $t2, 0($s1)

j repetir




