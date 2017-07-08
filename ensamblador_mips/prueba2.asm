.data
pc: .word 0x000d ## Registro PC
PCVALOR: .asciiz "PC: " 
.text
la $a0, PCVALOR ## IMPRIMIR EL  << "PC:">>
li $v0,4
syscall

lw $a0, pc ## IMPRIME EL VALOR EN HEXADECIMAL DE PC
li $v0,34
syscall