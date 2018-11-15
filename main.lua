-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene_main = composer.newScene()

--https://freesound.org/people/jalastram/sounds/442385/

local trilha_sonora = audio.loadStream( "AI_2.mp3" )



display.setDefault("textureWrapX", "mirroredRepeat")

local background = display.newRect(display.contentCenterX, display.contentCenterY, 666, 666)
background.fill = {type = "image", filename = "Menu_t.png" }

--Texto na tela para exibir os pontos
--local texto_titulo = display.newText( "BEM VINDO", 0, 0,"Arial")

--function scene:create( event )

--end
 
local function iniciarSom(trilha_sonora)
	audio.play( trilha_sonora)
end

local function mostar_fase()

	local options = {
	effect = "fade",
	time = 5000
	}

composer.removeScene( "main")
composer.gotoScene("fase",options )
end

local function removerSom(trilha_sonora)
 	audio.pause(trilha_sonora)
 	mostar_fase()

end



local play = display.newImage("360_Start_Alt.png")
play.x = display.contentCenterX-5
play.y = display.contentCenterY+60


local exit = display.newImage("360_Back_Alt.png")
exit.x = display.contentCenterX-5
exit.y = display.contentCenterY+105
transition.to(exit, {time=2500,alpha=1, iterations=-1, onRepeat= function(exit) transition.to(exit,{time=2500,alpha=0.7}) end })
transition.to(play, {time=2500,alpha=1, iterations=-1, onRepeat= function(play) transition.to(play,{time=1000,alpha=0.7}) end })

function play:tap()
	audio.pause(trilha_sonora)
	removerSom(trilha_sonora)
end

function exit:tap()
	native.requestExit()
end







play:addEventListener("tap", play)
exit:addEventListener("tap", exit)
iniciarSom(trilha_sonora)
return scene_main

