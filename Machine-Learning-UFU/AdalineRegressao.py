from pylab import *
import matplotlib.pyplot as plt
import numpy as np
import random
from scipy import stats
from scipy.stats.stats import pearsonr  
import math  

f = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
t = [2.26, 3.80, 4.43, 5.91, 6.18, 7.26, 8.15, 9.14, 10.87, 11.58, 12.55]
correlacao = []
correlacao = pearsonr(f,t)
pearson = math.sqrt(correlacao[0])
print(pearson)
print(correlacao[0])


#Treinamento do Adaline
want = 0.5 - random.uniform(0,1) #Inicialização aleatoria dos pesos
bant = 0.5 - random.random()
wnovo = want
teta = 0 #limiar de função da ativação degrau (rede treinada)
alfa = 0.01 #taxa de aprendizagem
numciclos = 500 #numero total de ciclos de treinamento
ciclos = 0 #contador para o numero de ciclos de treinamento

#Implementação do Adaline
while (ciclos <= numciclos): #limite de treinamento
    erroquadratico = 0
    ciclos = ciclos + 1 # conta numero de ciclos de treinamento
    #Apresenta todos os 4 padrões de entrada
    for entrada in range(len(t)):
        yliquido = want * f[entrada] + bant
        #Função de ativação: Linear
        y = yliquido
        #Calculo do erro quadrático
        erroquadratico = erroquadratico + (t[entrada] - y) ** 2
        #Atualização dos pesos
        wnovo = want+alfa*(t[entrada]-y)*f[entrada]
        bnovo = bant + alfa * (t[entrada]-y)
        #Salva os novos pesos para a próxima atualização
        want = wnovo
        bant = bnovo

"""
    #Plota o Erro quadrático
    scatter(ciclos,erroquadratico, s=10 , marker='o', c='r')

fig = plt.figure()
ax = fig.add_subplot(111)
left,right = ax.get_xlim()
low,high = ax.get_ylim()
grid()
show()
"""

#Plota o Gráfico da regressão linear
x = np.array(f)
y = np.array(t)
fig = plt.figure()
ax = fig.add_subplot(111)
for abcissa in range(-60, 60, 1):
    ordenada = (abcissa/4) * wnovo + bnovo
    scatter((abcissa/4),ordenada, s=10 , marker='o', c='r')
scatter(x,y, s=30 ,marker='o', c='b') 
m, b = np.polyfit(x, y, 1)
plt.plot(x, m*x + b, c='g')
left,right = ax.get_xlim()
low,high = ax.get_ylim()
arrow( left, 0, right-left, 0, length_includes_head = True, head_width = 0 )
arrow( 0, low, 0, high-low, length_includes_head = True, head_width = 0 )
plt.axis([-1,6,-1,13])
grid()
show()


