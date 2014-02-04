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
   self:AddChatCommand( "arenaarm", self.arenaArm )

end

function PLUGIN:tower( netuser )
	rust.Notice( netuser, "Test. Teleport to Tower..." )		
end

function PLUGIN:arenaArm( netuser )
	if( arenaArmed == "no" ) then
		self.arenaArmed = "yes"
		rust.Notice( netuser, "TEST : Arena Kit Will Be Deployed" )		
		else
		self.arenaArmed = "no"
		rust.Notice( netuser, "TEST : Arena Kit Will NOT Be Deployed" )
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
	if (self.Arena == "on") then
	local coords = netuser.playerClient.lastKnownPosition
		if(args[1] == nil ) then						
			rust.Notice( netuser, "Spawning on Rooftop" )
			coords.x = 5150 --Xcoordinates arena
			coords.y = 445 --Ycoordinates arena
			coords.z = -4062 --Zcoordinates arena
			rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
		else
			-- Main Arena Bottom Floor
			if((args[1] == "floating") and (args[2] == "1")) then
				rust.Notice( netuser, "Spawning on Bottom Floor" )
				coords.x = 5156.21972656 --Xcoordinates arena
				coords.y = 423.2848815918 --Ycoordinates arena
				coords.z = -4084.0363769531 --Zcoordinates arena
				rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)			
				else
				-- Take user to new Arena
				if( (args[1] == "opentop") and (args[2] == "1") ) then
				rust.Notice( netuser, "OpenTop: PAD 1" )
				coords.x = 5716
				coords.y = 333
				coords.z = -5182
				rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
				else
					if( ( args[1] == "opentop" ) and ( args[2] == "2" ) ) then
					rust.Notice( netuser, "OpenTop: PAD 2" )
					coords.x = 5728
					coords.y = 333
					coords.z = -5140
					rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
					else
						if( ( args[1] == "opentop" ) and ( args[2] == "3" ) ) then
						rust.Notice( netuser, "OpenTop: PAD 3" )
						coords.x = 5681
						coords.y = 333
						coords.z = -5126
						rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
						else
							if( ( args[1] == "opentop" ) and ( args[2] == "4" ) ) then
							rust.Notice( netuser, "OpenTop: PAD 4" )
							coords.x = 5670
							coords.y = 333
							coords.z = -5171
							rust.ServerManagement():TeleportPlayer(netuser.playerClient.netPlayer, coords)
							else
								if( ( args[1] == "opentop" ) and ( args[2] == nil ) ) then
								randomSpawnpoint = math.random(1,4)
								rust.Notice( netuser, "Spawning on PAD " .. randomSpawnpoint )
								end
							end
						end						
					end							
				end
			end
		end
	else
	rust.Notice(netuser, "Arena is closed!")
	end
   return
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
