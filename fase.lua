-----------------------------------------------------------------------------------------
--
-- fase.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--local Fundo_ = display.newImage( "cenario.jpg",display.contentWidth, display.contentheight )

--Fundo_.width = display.contentWidth/2;
--Fundo_.height = display.contentHeight/2;


display.setDefault("textureWrapX", "mirroredRepeat")

audio.reserveChannels( 1 )
audio.setVolume( 0.5, { channel=1 } )

local background = display.newRect(display.contentCenterX, display.contentCenterY, 1063, 591)
background.fill = {type = "image", filename = "cenario.jpg" }

local velocidade_p = 2
local velocidade_inimigo = 1.1
local lentidao = 0
local player_vel = 0
local enemy_vel = 0

local function aumentaSpeed()
	player_vel = player_vel + 0.6
	enemy_vel = enemy_vel + 0.3
end

local sheetOptions =
{
    width = 69,
    height = 85,
    numFrames = 4
}

local sheetOptionsSaida =
{
    width = 77,
    height = 77,
    numFrames = 4
}
local sheetOptionsInimigo =
{
    width = 51,
    height = 51,
    numFrames = 8
}

-- sequences table
local sequences_runningCat = {
    -- consecutive frames sequence
    {
        name = "normalRun",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}


local sequences_runningCa_t = {
    -- consecutive frames sequence
    {
        name = "normalRun",
        start = 1,
        count = 4,
        time = 1800,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local sheet_runningCat = graphics.newImageSheet( "Portal_Entrada.png", sheetOptions )
local Portal_Entrada = display.newSprite( sheet_runningCat, sequences_runningCat )

local seet_portal_running = graphics.newImageSheet( "Saida.png", sheetOptionsSaida )
local portal_running = display.newSprite( seet_portal_running, sequences_runningCat )

Portal_Entrada.x = 5
Portal_Entrada.y = 50

portal_running.x = display.contentWidth-5
portal_running.y = display.contentHeight -50

Portal_Entrada:play()
portal_running:play()


--https://freesound.org/people/Greek555/sounds/442399/
--local trilha_sonora = audio.loadSound( "442399__greek555__sample.mp3" )
--local canal = audio.play( trilha_sonora, {channel=1, loops=-1 })

--https://freesound.org/people/ProjectsU012/sounds/341695/
local moeda = audio.loadSound( "341695__projectsu012__coins-1.wav" )


--Direção: Existem 4 direções, cima(1), baixo(2), direita(3), esquerda(4).
local direcao = 2

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

SetaCima:setFillColor(0,0,0 )
SetaBaixo:setFillColor(0,0,0 )
SetaDireita:setFillColor(0,0,0 )
SetaEsquerda:setFillColor(0,0,0 )


--Atribuindo 30% de alpha para todos do grupo Joystick
Joystick.alpha = 0.3

--Criando "Mais dez" aumenta em pontuação 10 se for pego
local mais_dez = display.newImage("mais_dez.png")
mais_dez.x = display.contentCenterX-100
mais_dez.y = display.contentCenterY-40


local PowerUP = display.newImage("Speed.png")
PowerUP.x = display.contentCenterX-80
PowerUP.y = display.contentCenterY+90

local Congela = display.newImage("Freezer.png")
Congela.x = display.contentCenterX-150
Congela.y = display.contentCenterY-100

--Criando Inimigo
--local inimigo = display.newImage("inimigo.png")

local seet_inimigo_animado_running = graphics.newImageSheet( "inimigo_animado.png", sheetOptionsInimigo )
local inimigo = display.newSprite( seet_inimigo_animado_running, sequences_runningCa_t )

inimigo.x = inimigo.contentHeight
inimigo.y = 30

inimigo:play()

--Criando Player
local player = display.newImage("player.png")
player.x = display.contentCenterX+50
player.y = display.contentCenterY+80

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
	if(pontos % 8 == 0) then
		aumentaSpeed()
	end

end



function muda_local()
			--Muda a lcalização do item "mais dez"
			mais_dez.x = math.random(0,display.contentWidth-15)
			mais_dez.y = math.random(0,display.contentHeight-15)
end

function velocidade_normal()
			velocidade_p = 2
			player:setFillColor( 9,9,9 )
end

function velocidade_normal_i()
			lentidao = 0
			inimigo:setFillColor( 9,9,9 )
end

function muda_local_p()

		if(math.random(0,1) == 1) then
			PowerUP.x = math.random(0,display.contentWidth-15)
			PowerUP.y = math.random(0,display.contentHeight-20)
		else
			PowerUP.x = -4000
			PowerUP.x = -4000
		end			--Muda a localização do item "mais dez"
			
end

function muda_local_i()

		if(math.random(0,1) == 1) then
			Congela.x = math.random(0,display.contentWidth-15)
			Congela.y = math.random(0,display.contentHeight-20)
		else
			Congela.x = -4000
			Congela.x = -4000
		end			--Muda a lcalização do item "mais dez"
			
end

--Função executada a 1 milisegundo, cuida da movimentação dos personagens
function persegue()

	--Calcula a distancia entre doispontos no plano cartesiano
	local distancia = math.sqrt ((player.x-inimigo.x)^2 + (player.y-inimigo.y) ^2)

	local Portal_Entrada_distancia = math.sqrt ((player.x-Portal_Entrada.x)^2 + (player.y-Portal_Entrada.y) ^2)

	local distancia_mais_dez = math.sqrt ((player.x-mais_dez.x)^2 + (player.y-mais_dez.y) ^2)

	local distancia_power_up = math.sqrt ((player.x-PowerUP.x)^2 + (player.y-PowerUP.y) ^2)
	local distancia_congela = math.sqrt ((player.x-Congela.x)^2 + (player.y-Congela.y) ^2)

			--verifica a direção e define as bordas da tela
			if (direcao == 1 and player.y > 25) then
				player.y = player.y - velocidade_p - player_vel
			elseif(direcao == 2 and player.y < display.contentHeight-25) then
				player.y = player.y + velocidade_p	+ player_vel
			elseif(direcao == 3 and player.x < display.contentWidth) then
				player.x = player.x + velocidade_p	 + player_vel
			elseif(direcao == 4 and player.x > 0) then
				player.x = player.x - velocidade_p - player_vel
			end		

		--Verifica se ha distancia minima para perseguir
		if (distancia > 45) then
			if(inimigo.y < player.y) then
				inimigo.y = inimigo.y + velocidade_inimigo + enemy_vel - lentidao
			end
			if(inimigo.y > player.y) then
				inimigo.y = inimigo.y - velocidade_inimigo - enemy_vel + lentidao
			end
			if(inimigo.x < player.x) then
				inimigo.x = inimigo.x + velocidade_inimigo + enemy_vel - lentidao
			end
			if(inimigo.x > player.x) then
				inimigo.x = inimigo.x - velocidade_inimigo - enemy_vel + lentidao
			end

		else
			timer.pause(timer_pontos)
			timer.pause(timer1)

			local Parametros = {
			    pontos_p = pontos
			}

			audio.pause( minha_trilha_sonora)
			--audio.stop(minha_trilha_sonora)
			audio.dispose(minha_trilha_sonora)
			--audio.pause(canal)
			composer.removeScene( "fase")
			audio.stop( 1 )
			--audio.stop(canal)

			--audio.pause( trilha_sonora)

			composer.hideOverlay( "fase", 400 )
			composer.gotoScene( "pontuacao",{ effect="fade", time=800, params=Parametros })
		end


		--Verifica se ha distancia minima para ganhar ponto
		if (distancia_mais_dez < 40) then

			--Muda a lcalização do item "mais dez"
			audio.play( moeda)
			muda_local()

			--Incrementa 9 pontos e chama fução "ganhaPonto" assim atrubi um novo ponto e atualiza o placar
			pontos = pontos

			audio.play( moeda)

		
			ganhaPonto()
		end

		if(Portal_Entrada_distancia < 40) then
			player.x = portal_running.x
			player.y = portal_running.y
		end


		if(distancia_power_up < 45) then
			player:setFillColor( 5,5,0 )

			velocidade_p = 3;
			timer.performWithDelay(5000, velocidade_normal,1)
			muda_local_p()
		end

		if(distancia_congela < 45) then
			inimigo:setFillColor( 0,5,5 )

			lentidao = enemy_vel+velocidade_inimigo;

			timer.performWithDelay(4000, velocidade_normal_i,1)
			muda_local_i()
		end
end

--Cria os eventos para as setas
SetaCima:addEventListener("tap", SetaCima)
SetaBaixo:addEventListener("tap", SetaBaixo)
SetaDireita:addEventListener("tap", SetaDireita)
SetaEsquerda:addEventListener("tap", SetaEsquerda)

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


function iniciar_som()
	local minha_trilha_sonora = audio.loadStream( "442399__greek555__sample.mp3" )
	audio.play(minha_trilha_sonora,{loops=-1})
	audio.setVolume( 0.5 ,{{ channel=0 }})
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
timer_pontos = timer.performWithDelay(1000, ganhaPonto,1)



iniciar_som()
audio.setVolume( 0.5 ,{{ channel=0 }})
timer_muda_local = timer.performWithDelay(10000, muda_local_i,0)

timer_muda_local_p = timer.performWithDelay(13000, muda_local_p,0)

return scene
