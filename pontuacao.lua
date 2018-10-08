-----------------------------------------------------------------------------------------
--
-- pontuacao.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()

--https://freesound.org/people/jalastram/sounds/442385/
local trilha_sonora = audio.loadSound( "442385__jalastram__cinematic-percussion-001.wav" )
audio.play( trilha_sonora )

local Fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth+50,display.contentHeight+50)
Fundo:setFillColor( 0,0,0 )

--Texto na tela para exibir os pontos
local texto_pontos = display.newText( "Pontos: 0", 0, 0,"Arial")

function scene:create( event )
    texto_pontos.text = "   GAME OVER\nSua Pontuação: "..event.params.pontos_p 
end
 
local function mostar_fase()
	local options = {
	effect = "fade",
	time = 5000
	}
composer.removeScene( "pontuacao")
composer.gotoScene("fase",options )
end

local function mostar_main()
	local options = {
	effect = "fade",
	time = 5000
	}
composer.removeScene( "pontuacao")
composer.gotoScene("main",options )
end

scene:addEventListener( "create" )

-- Define uma cor e posição para o texto de pontuação
texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-40
texto_pontos:scale( 1.5, 1.5 )

local again = display.newImage("again.png")
again.x = display.contentCenterX-60
again.y = display.contentCenterY+30

local menu = display.newImage("menu.png")
menu.x = display.contentCenterX+60
menu.y = display.contentCenterY+30

function again:tap()
	mostar_fase()
end

function menu:tap()
	mostar_main()
end

again:addEventListener("tap", again)
menu:addEventListener("tap", menu)

return scene

