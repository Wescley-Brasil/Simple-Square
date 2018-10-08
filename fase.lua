-----------------------------------------------------------------------------------------
--
-- fase.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local Fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth+50,display.contentHeight+50)
Fundo:setFillColor( 0,0,0)



--https://freesound.org/people/Greek555/sounds/442399/
local trilha_sonora = audio.loadSound( "442399__greek555__sample.mp3" )
local canal = audio.play( trilha_sonora, { loops=-1 })

--https://freesound.org/people/ProjectsU012/sounds/341695/
local moeda = audio.loadSound( "341695__projectsu012__coins-1.wav" )


--Direção: Existem 4 direções, cima(1), baixo(2), direita(3), esquerda(4).
local direcao = 1

--Este lugar é onde são desenhadas as "setas"
--[[
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
Joystick.alpha = 0.3
--]]
--Criando "Mais dez" aumenta em pontuação 10 se for pego
local mais_dez = display.newImage("mais_dez.png")
mais_dez.x = display.contentCenterX-100
mais_dez.y = display.contentCenterY-40

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

--[[
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
--]]
--Função chamada a cada 1 segundo encrementa 1 ponto e altera o texto na tela.
function ganhaPonto()
	pontos = pontos + 1
	texto_pontos.text = "Pontos: "..pontos
end

--Função executada a 1 milisegundo, cuida da movimentação dos personagens
function persegue()

	--Calcula a distancia entre doispontos no plano cartesiano
	local distancia = math.sqrt ((player.x-inimigo.x)^2 + (player.y-inimigo.y) ^2)

	local distancia_mais_dez = math.sqrt ((player.x-mais_dez.x)^2 + (player.y-mais_dez.y) ^2)

			--verifica a direção e define as bordas da tela
			if (direcao == 1 and player.y > 25) then
				player.y = player.y - 2
			elseif(direcao == 2 and player.y < display.contentHeight-25) then
				player.y = player.y + 2		
			elseif(direcao == 3 and player.x < display.contentWidth) then
				player.x = player.x + 2		
			elseif(direcao == 4 and player.x > 0) then
				player.x = player.x - 2
			end		

		--Verifica se ha distancia minima para perseguir
		if (distancia > 50) then
			if(inimigo.y < player.y) then
				inimigo.y = inimigo.y + 1
			end
			if(inimigo.y > player.y) then
				inimigo.y = inimigo.y - 1
			end
			if(inimigo.x < player.x) then
				inimigo.x = inimigo.x + 1
			end
			if(inimigo.x > player.x) then
				inimigo.x = inimigo.x - 1
			end

		else
			timer.pause(timer_pontos)
			timer.pause(timer1)

			local Parametros = {
			    pontos_p = pontos
			}

			composer.removeScene( "fase")
			audio.stop(canal)

			composer.hideOverlay( "fase", 400 )
			composer.gotoScene( "pontuacao",{ effect="fade", time=800, params=Parametros })
		end


		--Verifica se ha distancia minima para ganhar ponto
		if (distancia_mais_dez < 45) then

			--Muda a lcalização do item "mais dez"
			mais_dez.x = math.random(0,display.contentWidth-15)
			mais_dez.y = math.random(0,display.contentHeight-15)

			--Incrementa 9 pontos e chama fução "ganhaPonto" assim atrubi um novo ponto e atualiza o placar
			pontos = pontos + 9
			audio.play( moeda )
			ganhaPonto()
		end
end

--Cria os eventos para as setas
--[[
SetaCima:addEventListener("tap", SetaCima)
SetaBaixo:addEventListener("tap", SetaBaixo)
SetaDireita:addEventListener("tap", SetaDireita)
SetaEsquerda:addEventListener("tap", SetaEsquerda)
--]]
--Função para detectar o teclado
local function onKeyEvent( event )
 
 --Verificando as setas e atribuindo a direção correspondente
    if(event.keyName == "up") then
    	direcao = 1
    end
    if(event.keyName == "down") then
    	direcao = 2
    end
    if(event.keyName == "right") then
    	direcao = 3
    end
    if(event.keyName == "left") then
    	direcao = 4
    end
 
    return false
end

--Cria evento para as teclas
Runtime:addEventListener( "key", onKeyEvent )

-- Define uma cor e posição para o texto de pontuação
texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = 17
--Timer responsavel pela movimentação dos personagens
timer1 = timer.performWithDelay(1, persegue,0)

--Timer responsavel pelos pontos
timer_pontos = timer.performWithDelay(1000, ganhaPonto,0)
return scene
