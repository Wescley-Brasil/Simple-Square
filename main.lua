-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene_main = composer.newScene()

--https://freesound.org/people/jalastram/sounds/442385/
local trilha_sonora = audio.loadSound( "442385__jalastram__cinematic-percussion-001.wav" )
audio.play( trilha_sonora )

local Fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth+50,display.contentHeight+50)
Fundo:setFillColor( 0,0,0 )

--Texto na tela para exibir os pontos
local texto_titulo = display.newText( "BEM VINDO", 0, 0,"Arial")

--function scene:create( event )

--end
 
local function mostar_fase()
	local options = {
	effect = "fade",
	time = 5000
	}
composer.removeScene( "main")
composer.gotoScene("fase",options )
end

--scene_main:addEventListener( "create" )

-- Define uma cor e posição para o texto de titulo
texto_titulo:setFillColor( 1,0.75,0 )
texto_titulo.x = display.contentCenterX
texto_titulo.y = display.contentCenterY-40
texto_titulo:scale( 1.5, 1.5 )

local play = display.newImage("play.png")
play.x = display.contentCenterX-60
play.y = display.contentCenterY+70


local exit = display.newImage("exit.png")
exit.x = display.contentCenterX+60
exit.y = display.contentCenterY+70

function play:tap()
	mostar_fase()
end
function exit:tap()
	native.requestExit()
end

play:addEventListener("tap", play)
exit:addEventListener("tap", exit)

return scene_main

