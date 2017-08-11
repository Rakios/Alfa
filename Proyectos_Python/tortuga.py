# -*- coding: utf-8 -*-
import turtle

def main():
        window = turtle.Screen()
        squirtle = turtle.Turtle()

        dibujar_cuadrado(squirtle)
        turtle.mainloop()

def dibujar_cuadrado(squirtle):
    length = int(input('lenght del cuadrado: '))

    for i in range(4):
        dibujar(squirtle,length)

def dibujar(squirtle,length):
    squirtle.forward(length)
    squirtle.left(90)


if __name__ == '__main__':
    main()
