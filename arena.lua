PLUGIN.Title = "Arena"
PLUGIN.Description = "Based on the 'Arena' Plugin. This just adds spawn locations and option to depoloy weapons (to be added later)"
PLUGIN.Version = "1.0a"

function PLUGIN:Init()
   self.Arena = "off"
   self.arenaArmed = "no"
   self:AddChatCommand( "arenaon", self.arenaON )
   self:AddChatCommand( "arenaoff", self.arenaOFF )
   self:AddChatCommand( "arena", self.arenaPort )
   self:AddChatCommand( "arenat1", self.start1 )
   self:AddChatCommand( "arenat2", self.start2 )
   self:AddChatCommand( "coord", self.Coord )
   self:AddChatCommand( "ahelp", self.ahelp )
   self:AddChatCommand( "tower", self.tower )
   
   -- Load in the co-ordinates for OpenTop (For now it's only OpenTop)
   self:cmdDataCoordinates()

end

function PLUGIN:tower( netuser )
	rust.SendChatToUser( netuser, "Loading coordinates..." )		
	self:cmdDataCoordinates()
	rust.SendChatToUser( netuser, "Coordinates loaded." )		
end

function PLUGIN:arenaArm( netuser )
	if( arenaArmed == "no" ) then
		-- Do something here
		else
		-- Do something here
		end
end

function PLUGIN:arenaON( netuser, cmd )
   if ( not(netuser:CanAdmin()) ) then
  rust.Notice( netuser, "Only admins can do this!" )
  return
  end
   self.Arena = "on"
   message = "Arena is Open! Clear Inventory! /ahelp for Spawn Options"
   rust.RunServerCommand("notice.popupall \"" .. message .. "\"")
   return
end

function PLUGIN:arenaOFF( netuser, cmd )
   if ( not(netuser:CanAdmin()) ) then
  rust.Notice( netuser, "Only admins can do this!" )
  return
  end
   self.Arena = "off"
   message = "Arena is closed!"
   rust.RunServerCommand("notice.popupall \"" .. message .. "\"")
   return
end

-- Team 1 Spawn Location - Bottom Level
function PLUGIN:start1( netuser, cmd )
   if (self.Arena == "on") then
     local coords = netuser.playerClient.lastKnownPosition
	 rust.Notice( netuser, "Spawning on Bottom Floor" )
     coords.x = 5156.21972656 --Xcoordinates arena
     coords.y = 423.2848815918 --Ycoordinates arena
     coords.z = -4084.0363769531 --Zcoordinates arena
     rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
   else
     rust.Notice(netuser, "Arena is closed!")
   end
   return
end

-- Team 2 Spawn Location
function PLUGIN:start2( netuser, cmd )
   if (self.Arena == "on") then
     local coords = netuser.playerClient.lastKnownPosition
	 rust.Notice( netuser, "Spawning on Rooftop corner" )
     coords.x = 5145.6708984375 --Xcoordinates arena
     coords.y = 445.2848815918 --Ycoordinates arena
     coords.z = -4031.2954101563 --Zcoordinates arena
     rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
   else
     rust.Notice(netuser, "Arena is closed!")
   end
   return
end

-- For Normal Free For All Gameplay - Ground Floor
function PLUGIN:arenaPort( netuser, cmd, args )
	self.arenaStatusOpenTop = self.data["Arena"]["Status"]["OpenTop"]
	self.arenaStatusFloating = self.data["Arena"]["Status"]["Floating"]
	
	if (self.Arena == "on") then
	local coords = netuser.playerClient.lastKnownPosition
		if(args[1] == nil ) then		
			rust.Notice( netuser, "Spawning on Rooftop" )
			coords.x = 5150 --Xcoordinates arena
			coords.y = 445 --Ycoordinates arena
			coords.z = -4062 --Zcoordinates arena
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		end
		if((args[1] == "floating") and (args[2] == "1")) then -- Main Arena Bottom Floor
			rust.Notice( netuser, "Spawning on Bottom Floor" )
			coords.x = 5156.21972656 
			coords.y = 424.2848815918
			coords.z = -4084.0363769531
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)	
		end
		if( (args[1] == "opentop") and (args[2] == "1") ) then -- Take user to new Arena
			rust.Notice( netuser, "OpenTop: PAD 1" )
			coords.x = 5716
			coords.y = 333
			coords.z = -5182
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		elseif( ( args[1] == "opentop" ) and ( args[2] == "2" ) ) then
			rust.Notice( netuser, "OpenTop: PAD 2" )
			coords.x = 5728
			coords.y = 333
			coords.z = -5140
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		elseif( ( args[1] == "opentop" ) and ( args[2] == "3" ) ) then
			rust.Notice( netuser, "OpenTop: PAD 3" )
			coords.x = 5681
			coords.y = 333
			coords.z = -5126
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		elseif( ( args[1] == "opentop" ) and ( args[2] == "4" ) ) then
			rust.Notice( netuser, "OpenTop: PAD 4" )
			coords.x = 5670
			coords.y = 333
			coords.z = -5171
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		elseif( ( args[1] == "opentop" ) and ( args[2] == nil ) ) then
			randomSpawnPointNumber = math.random(4)
			x = self.data["Arena"]["OpenTop"]["Pad"][randomSpawnPointNumber]["x"]
			coords.x = self.data["Arena"]["OpenTop"]["Pad"][randomSpawnPointNumber]["x"]
			coords.y = self.data["Arena"]["OpenTop"]["Pad"][randomSpawnPointNumber]["y"]
			coords.z = self.data["Arena"]["OpenTop"]["Pad"][randomSpawnPointNumber]["z"]
			rust.Notice( netuser, "Spawning at PAD: " ..  randomSpawnPointNumber )
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)

		end	

	else
		rust.Notice(netuser, "Arena is closed!")
	end
   return
end

function PLUGIN:cmdDataCoordinates()
	print("arena: cmdDataCoordinates was called.")
	self.data = {} -- Create an empty table to hold our coords
	
	self.data["Arena"] = {}
	self.data["Arena"]["OpenTop"] = {}
	self.data["Arena"]["OpenTop"]["Pad"] = {}
	
	self.data["Arena"]["Status"] = {}
	
	-- Our Coordinates	
	-- Try with the 'Landing Pads' first
	-- PAD 1
	self.data["Arena"]["OpenTop"]["Pad"][1] = {}
	self.data["Arena"]["OpenTop"]["Pad"][1]["x"] = 5716
	self.data["Arena"]["OpenTop"]["Pad"][1]["y"] = 336
	self.data["Arena"]["OpenTop"]["Pad"][1]["z"] = -5182
	print(".. PAD  1 loaded")
	-- PAD 2
	self.data["Arena"]["OpenTop"]["Pad"][2] = {}
	self.data["Arena"]["OpenTop"]["Pad"][2]["x"] = 5728
	self.data["Arena"]["OpenTop"]["Pad"][2]["y"] = 336
	self.data["Arena"]["OpenTop"]["Pad"][2]["z"] = -5140	
	print(".. PAD  2 loaded")
	-- PAD 3
	self.data["Arena"]["OpenTop"]["Pad"][3] = {}
	print(".. PAD3.1 ..")
	self.data["Arena"]["OpenTop"]["Pad"][3]["x"] = 5681
	print(".. PAD3.2 ..")
	self.data["Arena"]["OpenTop"]["Pad"][3]["y"] = 336
	print(".. PAD3.2 ..")
	self.data["Arena"]["OpenTop"]["Pad"][3]["z"] = -5126
	print(".. PAD  3 loaded")
	-- PAD 4
	self.data["Arena"]["OpenTop"]["Pad"][4] = {}
	self.data["Arena"]["OpenTop"]["Pad"][4]["x"] = 5670
	self.data["Arena"]["OpenTop"]["Pad"][4]["y"] = 336
	self.data["Arena"]["OpenTop"]["Pad"][4]["z"] = -5171		
	print(".. PAD  4 loaded")
	-- Arena Statuses
	self.data["Arena"]["Status"]["OpenTop"] = "open"
	self.data["Arena"]["Status"]["Floating"] = "open"
	print("Coordinates Loaded...")
end

function PLUGIN:Coord( netuser, cmd, args )
    local coords = netuser.playerClient.lastKnownPosition
    rust.SendChatToUser( netuser, "Current Position: {x: " .. coords.x .. ", y: " .. coords.y .. ", z: " .. coords.z .. "}")
end

function PLUGIN:ahelp( netuser ) -- Extended the help
	rust.SendChatToUser( netuser, "Use /arena to TP to the the roof of the Arena" )
	rust.SendChatToUser( netuser, "/arenat1 : Bottom Floor of Arena (Team 1)" )
	rust.SendChatToUser( netuser, "/arenat2 : Rooftop Corner of Arena (Team 2)" )
    if (netuser:CanAdmin()) then
        rust.SendChatToUser( netuser, "Use /arenaon and /arenaoff to toggle the Arena Open or Closed" )
    end
end

function PLUGIN:SendHelpText( netuser )
    rust.SendChatToUser( netuser, "Use /ahelp to see Arena commands" )
end
