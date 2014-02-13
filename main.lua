function love.load()
	love.graphics.setBackgroundColor(235,235,235)
	image = love.graphics.newImage("mario.png")
	deathimg = love.graphics.newImage("dead.png")
	width = 18
	height = 18
	mariox = 385
	marioy = 275
	speed = 0
	topspeed = 0
	distance = 0
	newdistance = 0
	mariodied = false
	time = 0
	up = false
	down = false
	left = false
	right = false
end

function love.update(dt)
	if love.keyboard.isDown("right") and mariodied == false or love.keyboard.isDown("left") and mariodied == false or love.keyboard.isDown("up") and mariodied == false or love.keyboard.isDown("down") and mariodied == false then
		newdistance = newdistance + speed
		speed = speed + 0.1
	else
		if speed > topspeed then
			topspeed = speed
		end
		if mariodied == false then
			speed = 0
		end
		distance = newdistance + distance
		newdistance = 0
	end
	if love.keyboard.isDown("right") and left == false then
		mariox = mariox + speed
		right = true
	else
		right = false
	end
	if love.keyboard.isDown("left") and right == false then
		mariox = mariox - speed
		left = true
	else
		left = false
	end
	if love.keyboard.isDown("down") and up == false then
		marioy = marioy + speed
		down = true
	else
		down = false
	end
	if love.keyboard.isDown("up") and down == false then
		marioy = marioy - speed
		up = true
	else
		up = false
	end
	if mariodied == true then
		time = time + dt
	end
	if mariox > 800 or mariox < 0 or marioy > 600 or marioy < 0 then
		mariodied = true
	end
end

function love.mousepressed(x, y, button)
	if button == "l" and x > mariox and x < mariox + width and y > marioy and y < marioy + height then
		mariodied = true
	end
end

function love.draw()
	if mariodied == false then
		love.graphics.draw(image, math.floor(mariox), math.floor(marioy))
		if speed > topspeed then
			love.graphics.print('Top Speed: ' .. topspeed .. ' +' .. speed - topspeed .. ' (' .. speed .. ')', 10, 20)
		elseif speed > 0 then
			love.graphics.print('Top Speed: ' .. topspeed .. ' (' .. speed .. ')', 10, 20)
		else
			love.graphics.print('Top Speed: ' .. topspeed, 10, 20)
		end
		if newdistance > 0 then
			love.graphics.print('Total Distance: ' .. distance .. ' +' .. newdistance, 10, 30)
		else
			love.graphics.print('Total Distance: ' .. distance, 10, 30)
		end
	else
		love.graphics.setNewFont(30)
		if time > 1 then
			love.graphics.draw(deathimg, 63, 263)
		end
		if time > 2 then
			love.graphics.print("Let's see how well you did!", 75, 220)
		end
		if time > 3 then
			love.graphics.print('Top Speed: ' .. topspeed, 200, 259)
		end
		if time > 4 then
			love.graphics.print('Total Distance: ' .. distance, 217, 297)
		end
		if time > 6 then
			love.graphics.print('Final Score: ' .. (topspeed + distance) * (speed + 1) .. ' (x' .. math.floor(speed) + 1 .. ')', 236, 338)
			deathimg = love.graphics.newImage("medal.png")
		elseif time > 26 then
			love.graphics.print('Final Score: Why are you still here?', 236, 338)
		end
	end
end