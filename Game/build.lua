return {
  
  -- basic settings:
  name = 'PHrawler', -- name of the game for your executable
  developer = 'Einspieler', -- dev name used in metadata of the file
  output = 'dist', -- output location for your game, defaults to $SAVE_DIRECTORY
  version = '0.1', -- 'version' of your game, used to name the folder in output
  love = '11.5', -- version of LÖVE to use, must match github releases
  ignore = {'dist', '.DS_Store'}, -- folders/files to ignore in your project
  icon = 'assets/images/rook_logo.png', -- 256x256px PNG icon for game, will be converted for you
  
  -- optional settings:
  identifier = 'computer.rook.phrawler', -- macos team identifier, defaults to game.developer.name
  platforms = {'macos', 'linux'} -- set if you only want to build for a specific platform
  
} 