-----------------------------------------------------------------------------------------
--
-- pontuacao.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()

--https://freesound.org/people/jalastram/sounds/442385/
audio.play( trilha_sonorax )

local Fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth+100,display.contentHeight)
Fundo.fill = {type = "image", filename = "Game Over LED.png" }
Fundo.x = display.contentCenterX
Fundo.y = display.contentCenterY




--Texto na tela para exibir os pontos
local texto_pontos = display.newText( "Pontos: 0", 0, 0,"Arial")


function scene:create( event )
    texto_pontos.text = "  Sua Pontuação: "..event.params.pontos_p
    texto_pontos.y = display.contentHeight-display.contentHeight+25
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
texto_pontos:setFillColor( 6,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-40
texto_pontos:scale( 1.5, 1.5 )

local again = display.newImage("RestartOFF.png")
again.x = display.contentCenterX-60
again.y = display.contentCenterY+65

local menu = display.newImage("ExitOFF.png")
menu.x = display.contentCenterX+60
menu.y = display.contentCenterY+65

function again:tap()
	mostar_fase()
end

function menu:tap()
	mostar_main()
end

again:addEventListener("tap", again)
menu:addEventListener("tap", menu)

return scene

