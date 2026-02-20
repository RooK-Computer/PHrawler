
Colors = {
   getYellowRGBA = function(alpha)
     alpha = alpha or Constants.GRAPHIC.COLORS.YELLOW.A
     
    if alpha <=1 then r,g,b, alpha = love.math.colorToBytes(0, 0, 0, alpha) end

     return {
       love.math.colorFromBytes(
        Constants.GRAPHIC.COLORS.YELLOW.R, 
        Constants.GRAPHIC.COLORS.YELLOW.G, 
        Constants.GRAPHIC.COLORS.YELLOW.B, 
        alpha
        )
    }
   end,   
   
   getPurpleRGBA = function(alpha)
     alpha = alpha or Constants.GRAPHIC.COLORS.PURPLE.A
     
     if alpha <=1 then r,g,b, alpha = love.math.colorToBytes(0, 0, 0, alpha) end
     
     return {
       love.math.colorFromBytes(
          Constants.GRAPHIC.COLORS.PURPLE.R, 
          Constants.GRAPHIC.COLORS.PURPLE.G, 
          Constants.GRAPHIC.COLORS.PURPLE.B, 
          alpha
        )
      }
     end,
  
  }