-----------------------------------------------------------------------------------------
--
-- pontuacao.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()

local Fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,display.contentHeight)
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
composer.gotoScene("main",options )
end

--timer.performWithDelay(1000, mostar_fase)

scene:addEventListener( "create" )

-- Define uma cor e posição para o texto de pontuação
texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-20
texto_pontos:scale( 1.5, 1.5 )

return scene

