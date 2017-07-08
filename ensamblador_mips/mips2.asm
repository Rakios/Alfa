.data
memory: .word 0x51235123, 0x00020004, 0x00070005, 0x00030001, 0x00020004,
0x000B0001, 0x03000000

PC: .half 0x0000
LO: .half 0x0000
registros: .half  0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000

.text



Pintar:                
		sw $t1, ($t0)
		addi $t0, $t0, 4
		addi $t3, $t3, 1
		blt $t3, $t2,Pintar
		nop
		
		li $t3, 0
		addi $t4, $t4, 1
		bne $t4, $t2,Pintar
		nop



ciclo:
lw $t2, memory #Leer el primer elemento
srl $t0, $t2, 16 # t0 primera instruccion
sll $t1, $t2, 16
srl $t3, $t1, 16 ## t3 segunda instruccion
# DECODIFICAR LA PRIMERA INSTRUCCION
srl $t4, $t0, 12 # VER  EL CODIGO DE OPERACION
beq $t4, 0x00000000, suma # si hay que sumar
beq $t4, 0x00000001, sumai #si hay que sumar con un inmediato
beq $t4, 0x00000002, resta #si hay que restar
beq $t4, 0x00000003, restai #si hay que restar con un inmediato
beq $t4, 0x00000004, andd #and en 2 registros
beq $t4, 0x00000005, anddi #and entre un registro y un inmediato
beq $t4, 0x00000006, orr # aplicar  OR entre dos registros
beq $t4, 0x00000007, orri # aplicar OR entre un registro y un inmediato
beq $t4, 0x00000008, multi # multiplicar entre 2 registros
beq $t4, 0x00000009, xorr # aplicar XOR entre dos registros
beq $t4, 0x0000000a, nott # aplicar NOT al registro
beq $t4, 0x0000000b, lii # carga un valor inmediato a un registro (LI)
beq $t4, 0x0000000c, mov # mueve el contenido de un registro a otro
beq $t4, 0x0000000d, movlo # mueve el contenido de LO a otro registro
beq $t4, 0x0000000e, jump # saltar a una direccion
beq $t4, 0x0000000f, listo #terminar el ciclo // salir del programa


suma: #funcion para sumar.
## esto esquivale a lw $s0, $r0 
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
srl $t7, $t1, 3 # DESPLAZAMOS 3 bits a la derecha 
andi $t7,$t7, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t7, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s7 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s4, registros($s7) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RS y leemos
add $s2, $s3, $s4
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo

sumai: #funcion para sumar con un inmediato
#
## esto esquivale a lw $s0, $r0 
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
lw $t7, $t1 # solo nesecitamos cargar la instruccion completa
andi $t7,$t7, 0x0000003f, #aplicamos un AND, para que solo queden los ultimo 0011 1111 bits PARA TOMAR EL INMEDIATO
add $s2, $s3, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado en $s5
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
#
j listo
resta: #funcion para restar
#
## esto esquivale a lw $s0, $r0 
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
srl $t7, $t1, 3 # DESPLAZAMOS 3 bits a la derecha 
andi $t7,$t7, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t7, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s7 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s4, registros($s7) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RS y leemos
sub $s2, $s3, $s4 # RESTA
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo

restai: #funcion para restar con un inmediato
#
## esto esquivale a lw $s0, $r0 
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
lw $t7, $t1 # solo nesecitamos cargar la instruccion completa
andi $t7,$t7, 0x0000003f, #aplicamos un AND, para que solo queden los ultimo 0011 1111 bits PARA TOMAR EL INMEDIATO
sub $s2, $s3, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado en $s5
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
j listo
andd: #aplicar and entre 2 registros
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
srl $t7, $t1, 3 # DESPLAZAMOS 3 bits a la derecha 
andi $t7,$t7, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t7, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s7 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s4, registros($s7) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RS y leemos
and $s2, $s3, $s4
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo

anddi: #aplicar and con un inmediato sobre un registro

srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RT y leemos

srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s6, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RT y leemos

lw $t7, $t1 # solo nesecitamos cargar la instruccion completa
andi $t7,$t7, 0x0000003f, #aplicamos un AND, para que solo queden los ultimo 0011 1111 bits PARA TOMAR EL INMEDIATO
and $s2, $s3, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado en $s5
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
#
#
j listo
orr: #aplicar OR entre 2 registros
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
srl $t7, $t1, 3 # DESPLAZAMOS 3 bits a la derecha 
andi $t7,$t7, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t7, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s7 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s4, registros($s7) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RS y leemos
or $s2, $s3, $s4
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo
orri:  # aplicar OR enter un registro y un inmediato
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RT y leemos

srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s6, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RT y leemos

lw $t7, $t1 # solo nesecitamos cargar la instruccion completa
andi $t7,$t7, 0x0000003f, #aplicamos un AND, para que solo queden los ultimo 0011 1111 bits PARA TOMAR EL INMEDIATO
or $s2, $s3, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado en $s5
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
j listo
multi: #multiplicar entre dos registros
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino

multi $s2, $s3
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
sw $s5, LO #GUARDAMOS EL RESULTADO EN NUESTRO LO
#
j listo
xorr: # aplicar XOR entre dos registros
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino
srl $t7, $t1, 3 # DESPLAZAMOS 3 bits a la derecha 
andi $t7,$t7, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t7, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s7 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s4, registros($s7) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RS y leemos
xor $s2, $s3, $s4 # OPERACION
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo
nott: #aplicar NOT a un registro
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $s5 y nos ubicamos en nuestro registro RT y leemos
#######################################
### Esto equivale a lw $s1, $r1 ####
srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
#######################################
##### Buscamos el registro de destino

not $s2, $s3
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RS y GUARDAMOS el resultado
#
j listo

lii: #carga un valorinmediato a un registro destino
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro


lw $t7, $t1 # solo nesecitamos cargar la instruccion completa
andi $t7,$t7, 0x000001ff, #aplicamos un AND, para que solo queden los ultimo 0011 1111 bits PARA TOMAR EL INMEDIATO
and $s2, $s3, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado
sw $s2, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
j listo

mov: #mueve el contenido de un registro a otro
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro


srl $t6, $t1, 6 # DESPLAZAMOS 6 bits a la derecha 
andi $t6,$t6, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $s3, registros($s6) #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
sw $s3, registros($s5) #guardamos el VAlor de registro en el registro destino
#
j listo
movlo: #mueve el contenido de LO a otro registro
#
srl $t5, $t1, 8 # DESPLAZAMOS 8 bits a la derecha 
andi $t5,$t5, 0x00000007, #aplicamos un AND, para que solo queden los ultimo 0111 bits
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro

lw $s3, LO #nos desplazamos la cantidad de espacios contenida en $s6 y nos ubicamos en nuestro registro RD y leemos
sw $s3, registros($s5) #guardamos el VAlor de registro en el registro destino
#
j listo
jump: # saltar a una direccion indicada
#
lw $t5, $t1, 
andi $t5,$t5, 0x00000fff, #aplicamos un AND, para que solo queden los ultimo 0111 bits
sw $t5, PC # guardamos la dirreccion en el contador de programa
#
j listo


listo:
beq $t4, 0x0000000f, ciclo
