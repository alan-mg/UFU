#entradas: Tabela Verdade
s = [[1, 1],
 [-1, 1],
 [1, -1],
 [-1, -1]]
#saidas
t = [1, 1, 1, -1]
#inicializa as variaveis
# etapa de treinamento
# inicialização dos pesos
wanterior = [0, 0]
banterior = 0
wnovo = [0, 0]
limiar = 0 #inicialização do limiar
for entrada in range(4):
 y = t[entrada]
 wnovo[0] = wanterior[0] + s[entrada][0] * y
 wnovo[1] = wanterior[1] + s[entrada][1] * y
 bnovo = banterior + y
 wanterior = wnovo
 banterior = bnovo
# teste da rede neural treinada
for entrada in range(4):
 yliquido = wnovo[0] * s[entrada][0] + wnovo[1] * s[entrada][1] + bnovo
 if yliquido >= limiar:
 y = 1
 else:
 y = -1
 print(s[entrada][0], s[entrada][1], y)
