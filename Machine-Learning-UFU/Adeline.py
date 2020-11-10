"""
Dados de Treinamento
Tabela Verdade
X1 X2
"""
from pylab import *
import matplotlib.pyplot as plt
import numpy as np
import random

#entradas: Tabela Verdade
s = [[1.0, 1.0],
    [1.1, 1.5],
    [2.5, 1.7],
    [1.0, 2.0],
    [0.3, 1.4],
    [2.8, 1.0],
    [0.8, 1.5],
    [2.5, 0.5],
    [2.3, 1.0],
    [0.5, 1.1],
    [1.9, 1.3],
    [2.0, 0.9],
    [0.5, 1.8],
    [2.1, 0.6]]
#saidas
t = [1, 1, -1, 1, 1, -1, 1, -1, -1, 1, -1, -1, 1, -1]

#inicializa as variaveis
# etapa de treinamento
# inicialização dos pesos

want = [0.5 - random.uniform(0,1), 0.5 - random.uniform(0,1)] #Inicialização aleatoria dos pesos
bant = 0.5 - random.random()
wnovo = want
teta = 0 #limiar de função da ativação degrau (rede treinada)
alfa = 1 #taxa de aprendizagem
numciclos = 300 #numero total de ciclos de treinamento
ciclos = 0 #contador para o numero de ciclos de treinamento

while (ciclos <= numciclos): #limite de treinamento
    erroquadratico = 0
    ciclos = ciclos + 1 # conta numero de ciclos de treinamento
    print('Ciclo: ',ciclos,' -> ', end = '')
    #Apresenta todos os 4 padrões de entrada
    for entrada in range(len(t)):
        yliquido = want[0] * s[entrada][0] + want[1] * s[entrada][1] + bant
        #Função de ativação: Linear
        y = yliquido
        #Calculo do erro quadrático
        erroquadratico = erroquadratico + (t[entrada] - y) ** 2
        #Atualização dos pesos
        wnovo[0] = want[0]+alfa*(t[entrada]-y)*s[entrada][0]
        wnovo[1] = want[1]+alfa*(t[entrada]-y)*s[entrada][1]
        bnovo = bant + alfa * (t[entrada]-y)
        #Salva os novos pesos para a próxima atualização
        want = wnovo
        bant = bnovo
    print('Wnovo: ',wnovo,' Bnovo: ',bnovo)
    #Plota o Erro quadrático
    scatter(ciclos,erroquadratico, s=10 , marker='o', c='r')

fig = plt.figure()
ax = fig.add_subplot(111)
left,right = ax.get_xlim()
low,high = ax.get_ylim()
grid()
show()

#Teste da Rede Treinada
print('Teste da Rede Treinada')
#Apresenta todos os 4 padrões de entrada
for entrada in range(len(t)):
    yliquido = wnovo[0]*s[entrada][0]+wnovo[1]*s[entrada][1]+bnovo
    #Aplicação da função de ativação: degrau
    if yliquido >= teta: #limitar teta = 0
        y = 1
    else:
        y = -1
    print('t(', entrada, ')= ', t[entrada], ' y(', entrada, ')= ', y)




#Gerar grafico dos pontos (x1,x2)
x = [row[0] for row in s]
y = [row[1] for row in s]
auxcolor = [] 
for numbercolor in range(len(t)):
    if t[numbercolor] == 1:
        auxcolor.append('b')
    if t[numbercolor] == -1:
        auxcolor.append('r')
color=auxcolor
fig = plt.figure()
ax = fig.add_subplot(111)
scatter(x,y, s=30 ,marker='o', c=color)
#Plota a fronteira de separação
auxcolor2 = ['g']
for i in range(-30, 31, 1):
    abcissa = (i/10.0)
    ordenada = (-abcissa * wnovo[0] - bnovo) / wnovo[1]
    scatter(abcissa,ordenada, s=10 , marker='o', c=auxcolor2)
left,right = ax.get_xlim()
low,high = ax.get_ylim()
arrow( left, 0, right-left, 0, length_includes_head = True, head_width = 0 )
arrow( 0, low, 0, high-low, length_includes_head = True, head_width = 0 )
plt.axis([-3,3,-3,3])
grid()
show()



