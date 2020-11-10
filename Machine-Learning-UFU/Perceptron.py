"""
Dados de Treinamento
Tabela Verdade
X1 X2
"""
from pylab import *
import matplotlib.pyplot as plt
import numpy as np

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

want = [0, 0]
bant = 0
wnovo = want
bnovo = bant
teta = 0 #inicialização do limiar
alfa = 1 #taxa de aprendizagem
trocou = 1 #sinaliza mudança dos pesos
ciclos = 0 #contador para o numero de ciclos de treinamento

##
while (trocou == 1):
    trocou = 0
    ciclos = ciclos + 1 # número de vezes que a tabela verdade foi usada
    print('Ciclo: ',ciclos,' -> ', end = '')
    #Apresenta todos os 4 padrões de entrada
    for entrada in range(len(t)):
        yliquido = want[0] * s[entrada][0] + want[1] * s[entrada][1] + bant
        #Aplicação da função de ativação: degrau
        #Calcula a resposta y da rede neural
        if yliquido >= teta: #limitar teta = 0
            y = 1
        else:
            y = -1
        #Atualiza pesos se rede neural errou
        if y != t[entrada]:
            trocou = 1 #sinaliza que a rede neural errou
            wnovo[0] = want[0] + alfa * s[entrada][0] * t[entrada]
            wnovo[1] = want[1] + alfa * s[entrada][1] * t[entrada]
            bnovo = bant + alfa * t[entrada]
            #Salva os novos pesos
            want = wnovo
            bant = bnovo
    print('Wnovo: ',wnovo,' Bnovo: ',bnovo)

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
    


