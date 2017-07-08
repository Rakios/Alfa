.data
a: .word 0x0000FF00
bb: .word 0xFF000000
c: .word 0x000000FF
cola: .half 3
.macro COMIDA
	repite: # Si la posicion esta ocupada por un cuadrito verde
	li $v0, 41 # NUMERO ALEATOREO
	syscall    # SE GUARDARA EN $a0
	la $s2, 0($a0) # cargar la direccion en $s2
	sll $s2, $s2, 4
	andi $s2, $s2 0x00000FFF # tomar los bits que me interesan
	addi $s2, $s2, 0x10000000 #sumarle 0x10000000 para empezar en la direccion del bitmap
	lw $t7, a # color verde
	lw $t6, 0($s2) # ver que color hay en esa direccion
	beq $t6, $t7, repite # Comparar si ambos son verdes. Si la posicion esta ocupada por un cuadrito verde
	
	lw $t7, c # cuadrito morado
	sw $t7, 0($s2) # asignar color morado en esa posicion
	 
.end_macro



.text
## Hacer el mapa

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
############################################

## LEER TECLADO

############################################
li $t5, 0x000000FF
#li $s3, 0x7fffeffc
#li $s4, 0x7fffeffc
#addi $s4, $s4, -4
comenzar:  ## COMENZAR PARTIDA
#li $sp, 0x7fffeffc
COMIDA # PONER LA PRIMERA COMIDA
li $s1, 0x1000010C # INICIAR EN ESTA POSICION
#lw $t0, a
#sw $t0, ($s1)
repetir: # LEER LA SIGUIENTE TECLA
li $t0,  0xffff0000 ## INICIO DE LA POSICION DEL TECLADO
lectura: # MIENTRAS NO LEA UNA TECLA, SEGUIRE PIDIENDO
lw $v0, 0($t0) # VER SI LEI TECLA
andi $v0, 0x01 # VER SI LEI TECLA
beq $v0, $zero, lectura # VER SI LEI TECLA
lw $v0, 4($t0) # LA TECLA QUE EI ESTA EN $V0
beq $v0, 0x77, arr #######################
beq $v0, 0x61, izq#VER CUAL MOVIMIENTO LEI
beq $v0, 0x73, aba#VER CUAL MOVIMIENTO LEI
beq $v0, 0x64, der########################

arr: ## ARRIBAAA (UP)

lw $t2, a # cargar  color verde
lw $t3 bb #cargar color negro
lw $t4, -128($s1) # color del furuto movimiento
#### sw $t3, 0($s1) # poner negro tu posicion
beq $t2, $t4 , comenzar # comparar si mi posicion+1 es igual a verde
addi $s1, $s1, -128 #cambiar a la sig posicion
sw $t2, 0($s1) #poner verde la siguiente posicion
beq $t4, $t5 comer # SI LA POSICION EN LA QUE ESTOY, HAY COMIDA, ENTONCES A RESETEO DE LUGAR
j repetir # VOLVER A LEER TECLA
comer: # COMER
COMIDA# LA COMIDA
j repetir # VOLVER A LEER TECLA

izq: ## IZQUEIRDAAAAA ( LEFT ) 

lw $t2, a # cargar color verde
lw $t3 bb # cargar color negro
lw $t4, -4($s1) #color de mi furuto movimiento
sw $t3, 0($s1) # poner color negro en mi posicion ACTUAL
beq $t2, $t4 , comenzar # ver si mi furuta posicion es color VERDE
addi $s1, $s1, -4  # SINO LO ES, entonces avanzo
sw $t2, 0($s1) # GUARDO color VERDE en mi poscion actual
beq $t4, $t5 comer1 # si EXISTE una comida en esta posicion, entonces a como
j repetir # SINO, volver a leer tecla
comer1: # COMER 
COMIDA # LA COMIDA
j repetir # VOLVER A LEER TECLA

aba: # ABAJOO (DOWN)
lw $t2, a # cargar color verde
lw $t3 bb # cargar color negro
lw $t4, 128($s1) #color de mi futuro movimiento
sw $t3, ($s1) # poner mi posicion actual color NEGRO
beq $t2, $t4 , comenzar # ver si mi FURUTA POSICION es color verde, si lo es, entonces PIERDO, y vuelvo a comenzar el juego
addi $s1, $s1, 128 # AVANZAR
sw $t2, 0($s1) #PONER VERDE POSICION ACTUAL
beq $t4, $t5 comer2 # VER SI HAY COMIDA EN MI POSICION
j repetir # VOLVER A LEER TECA
comer2: # SI HA COMIDA
COMIDA # LA COMO
j repetir # VUELVO A LEER TECLA

der: # DERECHAAA ( RIGHT )
lw $t2, a #Cargar coor verde
lw $t3 bb #cargar color negro
lw $t4, 4($s1) #color de mi furuto movimiento 
sw $t3, 0($s1) # poner de color negro MI POSICION ACTUAL
beq $t2, $t4 , comenzar # comparar si mi furuto movimiento es color verde, si lo es, entonces comienzo el jeugo
addi $s1, $s1, 4  # sino, avanzo de posicion
sw $t2, 0($s1) #  pongo verde mi posicion actual
beq $t4, $t5 comer3 # si hay comida, la como
j repetir # sino salto a volver a leer tecla
comer3: # comeeeeeeeeeeer
COMIDA # la  comida
j repetir # volver a leer tecla




