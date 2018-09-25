-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Direção: Existem 4 direções, cima(1), baixo(2), direita(3), esquerda(4).
local direcao = 1

display.setStatusBar(display.HiddenStatusBar)

--Este lugar é onde são desenhadas as "setas"
local SetaCima = display.newRect(80,display.contentHeight-100,40,40)
local SetaBaixo = display.newRect(80,display.contentHeight-20,40,40)
local SetaDireita = display.newRect(120,display.contentHeight-60,40,40)
local SetaEsquerda = display.newRect(40,display.contentHeight-60,40,40)

--Joystick é um grupo que contem todas as setas, a vantagem é a manipulação de varios display Objects
local Joystick = display.newGroup()
Joystick:insert(SetaCima)
Joystick:insert(SetaBaixo)
Joystick:insert(SetaDireita)
Joystick:insert(SetaEsquerda)

--Atribuindo 30% de alpha para todos do grupo Joystick
Joystick.alpha = 0.4

--Criando Inimigo
local inimigo = display.newImage("inimigo.png")
inimigo.x = inimigo.contentHeight
inimigo.y = 0

--Criando Player
local player = display.newImage("player.png")
player.x = display.contentCenterX
player.y = display.contentCenterY

--Variavel que guarda os pontos
local pontos = 0
--Texto na tela para exibir os pontos
local texto_pontos = display.newText( "Pontos: 0", 0, 0,"Arial")

--Eventos das setas, simplesmente alteram a direção do Player
function SetaCima:tap()

	direcao = 1 
end

function SetaBaixo:tap()
	direcao = 2

end
function SetaDireita:tap()
	direcao = 3
end
function SetaEsquerda:tap()
	direcao = 4
end

--Função chamada a cada 1 segundo encrementa 1 ponto e altera o texto na tela.
function ganhaPonto()
	pontos = pontos + 1
	texto_pontos.text = "Pontos: "..pontos
end

--Função executada a 1 milisegundo, cuida da movimentação dos personagens
function persegue()

	--Calcula a distancia entre doispontos no plano cartesiano
	local distancia = math.sqrt ((player.x-inimigo.x)^2 + (player.y-inimigo.y) ^2)

			--verifica a direção e define as bordas da tela
			if (direcao == 1 and player.y > 0) then
				player.y = player.y - 2
			elseif(direcao == 2 and player.y < display.contentHeight) then
				player.y = player.y + 2		
			elseif(direcao == 3 and player.x < display.contentWidth-25) then
				player.x = player.x + 2		
			elseif(direcao == 4 and player.x > 25) then
				player.x = player.x - 2
			end		

		--Verifica se ha distancia minima para perseguir
		if (distancia > 40) then
			if(inimigo.y < player.y) then
				inimigo.y = inimigo.y + 0.75
			end
			if(inimigo.y > player.y) then
				inimigo.y = inimigo.y - 0.75
			end
			if(inimigo.x < player.x) then
				inimigo.x = inimigo.x + 0.75
			end
			if(inimigo.x > player.x) then
				inimigo.x = inimigo.x - 0.75
			end
		else
			texto_pontos.text = "Fim jogo \nSua Pontuação: "..pontos
			timer.pause(timer_pontos)
			timer.pause(timer1)
		end
end

--Cria os eventos para as setas
SetaCima:addEventListener("tap", SetaCima)
SetaBaixo:addEventListener("tap", SetaBaixo)
SetaDireita:addEventListener("tap", SetaDireita)
SetaEsquerda:addEventListener("tap", SetaEsquerda)

-- Define uma cor e posição para o texto de pontuação
texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = -15
--Timer responsavel pela movimentação dos personagens
timer1 = timer.performWithDelay(1, persegue,0)

--Timer responsavel pelos pontos
timer_pontos = timer.performWithDelay(1000, ganhaPonto,0)