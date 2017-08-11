# -*- coding: utf-8 -*-
#programa para saber si un numero es primo
def es_primo(numero):

    if numero == 2 or (numero < 2 and numero > 0) or numero == 3 :
        return True
    elif numero % 2 == 0 and numero > 2:
        return False
    elif numero > 3:
        for i in range(3,numero):
            if numero % i == 0:
                return False
    return True

def run():
    numero = int(input('Introdusca un numero: '))
    if es_primo(numero) == True:
        print('El numero es primo')
    else:
        print('el numero no es primo')


if __name__ == '__main__':
    run()
