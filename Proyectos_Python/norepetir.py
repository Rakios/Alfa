# -*- coding: utf-8 -*-

def revisar(palabra,letra):
    cont = 0
    for letra2 in palabra:
        if letra == letra2:
            cont += 1
    if cont == 1:
        return letra
    else:
        return '_'

def main(palabra):

    for letra in palabra:
        resultado = revisar(palabra,letra)
        if resultado != '_':
            return resultado

    return resultado

if __name__ == '__main__':
    palabra = str(input('Introdusca una palabra: '))
    result = main(palabra)

    if result == '_':
        print('Todas las letras se repiten')
    else:
        print('La primera letra que solo aparece una vez es {}' .format(result))
