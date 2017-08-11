# -*- coding: utf-8 -*-

def main2(palabra):
    #usar slice para generar una nueva palabra en orden inverso
    palabra_inversa = palabra[::-1]

    if palabra_inversa == palabra:
        return True
    else:
        return False


def main(palabra):
    letras_inversa = []

    for letras in palabra:
        letras_inversa.insert(0,letras)

        #concatenar palabras
    palabra_inversa = ''.join(letras_inversa)

    if palabra_inversa == palabra:
        return True
    else:
        return False

if __name__ == '__main__':
    palabra = str(input('Introdusca la palabra a revisar: '))
    if main2(palabra) == True:
        print ('la palabra {} es un palindromos' .format(palabra))
    else:
        print(' {} no es un palindromo' .format(palabra))
