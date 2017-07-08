.data
memory: .word 0x51235123, 0x00020004, 0x00070005, 0x00030001, 0x00020004,
0x000B0001, 0x03000000

PC: .half 0x0000
LO: .half 0x0000
registros: .half  0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000


.text
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
#
#
#
j listo
sumai: #funcion para sumar con un inmediato
#
#
#
j listo
resta: #funcion para restar
#
#
#
j listo
restai: #funcion para restar con un inmediato
#
#
#
j listo
andd: #aplicar and entre 2 registros
#
#
#
j listo
anddi: #aplicar and con un inmediato sobre un registro
srl $t5, $t1, 4 # Guardar etiqueta del registro RD
li $s1, 4   #para ubicarnos en el registro, cargamos 4 en un registro
mult $t5, $s1 # multiplicamos 4 por la etiqueta binaria de RD, asi nos desplazaremos
mflo $s5 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro

srl $t6, $t1, 4 #  Guardar etiqueta del registro RT
mult $t6, $s1 # multiplicamos 4 por la etiqueta binaria de RT, asi nos desplazaremos
mflo $s6 #movemos el resultado de la multiplicacion a $s5, ahora tenemos la ubicacion de nuestro registro
lw $t2, registros($s6) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RT y leemos
srl $t7, $t1, 6 #  # Guardar inmediato

and $s7, $s6, $t7 #como tenemos el inmediamo en un registro hacemos un AND normal y guardamos el resultado en $s5
sw $s7, registros($s5) #nos desplazamos la cantidad de espacios contenida en $t5 y nos ubicamos en nuestro registro RD y GUARDAMOS el resultado
#
#
#
j listo
orr: #aplicar OR entre 2 registros
#
#
#
j listo
orri:  # aplicar OR enter un registro y un inmediato
#
#
#
j listo
multi: #multiplicar entre dos registros
#
#
#
j listo
xorr: # aplicar XOR entre dos registros
#
#
#
j listo
nott: #aplicar NOT a un registro
#
#
#
j listo
lii: #carga un valorinmediato a un registro destino
#
#
#
j listo
mov: #mueve el contenido de un registro a otro
#
#
#
j listo
movlo: #mueve el contenido de LO a otro registro
#
#
#
j listo
jump: # saltar a una direccion indicada
#
#
#
j listo


listo:
beq $t4, 0x0000000f, ciclo
