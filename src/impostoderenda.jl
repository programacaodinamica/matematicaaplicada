### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ 5c31cb08-528d-4afd-97c4-f31e906c1f2f
using Plots, Formatting

# ╔═╡ 49b71206-7e39-4b10-9512-5a2686b4fbed
md"""# Programação + Matemática

Se você precisa melhorar sua base matemática, confira o projeto [Matemática Elementar para Computação](https://matematica.pgdinamica.com), em que cobrimos os fundamentos da matemática.

Para esta tarefa, um conhecimento sólido sobre **porcentagem** e frações é muito útil.
"""

# ╔═╡ e301fd00-2bed-4739-9d97-c02155f7a665
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/yfkWatbh6pg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ ba478ad2-923a-11eb-01c7-354a0ae468c6
md"""# Calculando o Imposto de Renda"""

# ╔═╡ 57fa967a-923b-11eb-13e2-2dec29fa487b
md"""De acordo com as regras estipuladas pela Receita Federal [1], no IRPF 2021, estão isentas as pessoas que tiveram rendimentos abaixo de R$ 22.847,76 em 2020 (ano-calendário). A tabela com as alíquotas do imposto devido em relação aos rendimentos mensais segue abaixo.

1.[Página da Receita Federal sobre o cálculo](https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/tributos/irpf-imposto-de-renda-pessoa-fisica#calculo_mensal_IRPF)
"""

# ╔═╡ 87f38538-923b-11eb-245c-813542bdddec
html"""
<table id="tablepress-8" class="tablepress tablepress-id-8 enhanced vBordered">
<thead>
<tr class="row-1">
	<th class="column-1">Base de cálculo (R$)</th><th class="column-2">Alíquota (%)</th><th class="column-3">Parcela a deduzir do IRPF</th>
</tr>
</thead>
<tbody>
<tr class="row-2">
	<td class="column-1">Até 1.903,98</td><td class="column-2">isento</td><td class="column-3">isento</td>
</tr>
<tr class="row-3">
	<td class="column-1">De 1.903,99 até 2.826,65</td><td class="column-2">7,5%</td><td class="column-3">R$142,80</td>
</tr>
<tr class="row-4">
	<td class="column-1">De 2.826,66 até 3.751,05</td><td class="column-2">15%</td><td class="column-3">R$354,80</td>
</tr>
<tr class="row-5">
	<td class="column-1">De 3.751,06 até 4.664,68</td><td class="column-2">22,5%</td><td class="column-3">R$636,13</td>
</tr>
<tr class="row-6">
	<td class="column-1">Acima de 4.664,68</td><td class="column-2">27,5%</td><td class="column-3">R$869,36</td>
</tr>
</tbody>
</table>
"""

# ╔═╡ 37419e62-923b-11eb-01cd-cd06444df836
md""" ## Perguntas

#### 1. Olhando pro valor de isenção anual e o mensal, o 13º salário está considerado dentro do limite de isenção? 

"""

# ╔═╡ df553db6-50cc-4a93-a73c-195374a8751b
13 * 1903.98

# ╔═╡ ff3a1d48-6aff-4587-a7b0-6cf6bcf21367
12 * 1903.98

# ╔═╡ daa7435f-1a2a-48ed-8401-ee4d629cb29d
md"""
#### 2. Quanto de imposto será retido na fonte com um determinado salário?

"""

# ╔═╡ 451b58d8-0674-403d-b132-d528de0d9644
begin 
	aliquotas = [0.0, 7.5, 15.0, 22.5, 27.5]
	deducao = [0.0, 142.80, 354.80, 636.13, 869.36]
	
	function impostoretido(rendimento)
		limites = [0.0, 1903.99, 2826.66, 3751.06, 4664.69]
		faixa = 5
		for i in 1:length(aliquotas)-1
			if limites[i] <= rendimento < limites[i+1]
				faixa = i
			end
		end
		
		rendimento * aliquotas[faixa] / 100 - deducao[faixa]		
	end
end

# ╔═╡ ed2071e8-f1b2-4030-bb55-ecf6d9e14a05
salario = 5000.00

# ╔═╡ d29f0d7e-a382-42e9-9191-df06ec8db07d
md"""
Contribuição ao Instituto Nacional do Seguro Social (INSS) - previdenciária, acidentes etc

| Salário 								| Alíquota 		|
| :-----------------------------------: | :-----------: |
| Até R\\$ 1.100						| 7,5%			|
| De R\\$ 1.100,01 até R\\$ 2.203,48	| 9% 			|
| De R\\$ 2.203,49 até R\\$ 3.305,22	| 12% 			|
| De R\\$ 3.305,23 até R\\$ 6.433,57	| 14% 			|

2. [INSS - Tabela de contribuição mensal](https://www.gov.br/inss/pt-br/saiba-mais/seus-direitos-e-deveres/calculo-da-guia-da-previdencia-social-gps/tabela-de-contribuicao-mensal)
"""

# ╔═╡ 9dd8d374-18f5-4667-8348-8f00b3118b4e
function contribINSS(rendimento)
	limites = [0.0, 1100.01, 2203.46, 3305.23, 6433.58]
	alqtINSS = [7.5, 9.0, 12.0, 14.0] / 100
	
	desconto = 0.0
	base = min(rendimento, limites[end] - 0.01)
	for i in 1:length(limites)-1
		if base > limites[i]
			desconto += min(base - limites[i], 
							limites[i+1] - limites[i]) * alqtINSS[i]
		end
	end
	desconto
end

# ╔═╡ ee7a5da5-0142-4e1e-a326-5670a932abd3
begin
	desconto_inss = contribINSS(salario)
	desconto_irpf = impostoretido(salario - desconto_inss)
	salariof = fmt(".2f", salario)	
	continssf = fmt(".2f", desconto_inss) 
	impostof = fmt(".2f", desconto_irpf)
	liquidof = fmt(".2f", salario - desconto_inss - desconto_irpf)

	
	md"""
	| Salário bruto | Contribuição ao INSS  | IR retido na fonte |
	| :-----------: | :-------------------: | :----------------: |
	| R$ $salariof 	| R$ $continssf 		| R$ $impostof   	 |
	
	**O salário líquido, portanto, seria de R$ $(liquidof)**
	"""
end

# ╔═╡ 7a173210-c864-4f8c-9c77-607b5b2b7b74
md"""
#### 3. Se eu ganhar um pouquinho a mais e cruzar o limite da próxima alíquota, posso acabar pagando muito mais imposto e receber menos do que eu recebia antes?

"""

# ╔═╡ e59d4f5a-bee7-4708-a888-55148688c550
begin 
	x = 0:1:10000
	prev = contribINSS.(x)
	ir = impostoretido.(x - prev)
	plot(x, [ir, prev], title="Imposto de Renda e INSS", xlabel="renda", label=["IR" "INSS"], size = (700, 400), lw=3)
end

# ╔═╡ ac2c9f10-04ba-4525-b6e3-561fb928bd02
begin
	plot(x, x - prev - ir, title="Salário Líquido", xlabel="bruto", label="liquido", lw=3)
end

# ╔═╡ 3d8e3700-b19e-4c43-8b2d-41da1ce6a566
function ir2(rendimento)
	aliquotas = [7.5, 15.0, 22.5, 27.5] / 100
	limites = [1903.98, 2826.65, 3751.05, 4664.68, 100000000000]
	imposto = 0.0

	if rendimento < limites[1]
		return imposto
	else
		for i in 1:4
			if rendimento > limites[i]
				imposto += min(limites[i+1] - limites[i], 
								rendimento - limites[i]) * aliquotas[i]
			end
		end
	end
	imposto
end

# ╔═╡ Cell order:
# ╟─49b71206-7e39-4b10-9512-5a2686b4fbed
# ╟─e301fd00-2bed-4739-9d97-c02155f7a665
# ╟─ba478ad2-923a-11eb-01c7-354a0ae468c6
# ╟─57fa967a-923b-11eb-13e2-2dec29fa487b
# ╟─87f38538-923b-11eb-245c-813542bdddec
# ╟─5c31cb08-528d-4afd-97c4-f31e906c1f2f
# ╟─37419e62-923b-11eb-01cd-cd06444df836
# ╠═df553db6-50cc-4a93-a73c-195374a8751b
# ╠═ff3a1d48-6aff-4587-a7b0-6cf6bcf21367
# ╟─daa7435f-1a2a-48ed-8401-ee4d629cb29d
# ╠═451b58d8-0674-403d-b132-d528de0d9644
# ╠═ed2071e8-f1b2-4030-bb55-ecf6d9e14a05
# ╟─d29f0d7e-a382-42e9-9191-df06ec8db07d
# ╠═9dd8d374-18f5-4667-8348-8f00b3118b4e
# ╟─ee7a5da5-0142-4e1e-a326-5670a932abd3
# ╟─7a173210-c864-4f8c-9c77-607b5b2b7b74
# ╟─e59d4f5a-bee7-4708-a888-55148688c550
# ╟─ac2c9f10-04ba-4525-b6e3-561fb928bd02
# ╟─3d8e3700-b19e-4c43-8b2d-41da1ce6a566
