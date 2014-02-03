PLUGIN.Title = "Example"
PLUGIN.Description = "Example Plugin"
PLUGIN.Author = "Your Name"
PLUGIN.Version = "1.0"

-- Called when oxide loads or user types oxide.reload example at F1 console
function PLUGIN:Init()
	self.arenaArmed = "no";
    self:AddChatCommand("status", self.cmdStatus);
	self:AddChatCommand("status1", self.cmdStatus1);
	
end

-- Called when user types /example
function PLUGIN:cmdStatus( netuser, cmd, args )
user = netuser.DisplayName
if ( user == "3lindNinja" ) then
	rust.SendChatToUser( netuser, "/status Command Called" )
		if self.arenaArmed == "no" then
			rust.SendChatToUser( netuser, "Arena is Not Armed!" )
		else
			rust.SendChatToUser( netuser, "Arena is Armed" )
		end
	else
		rust.SendChatToUser( netuser, "Wrong USer!" )
	end
end

-- Arm the Arena
--[[ function PLUGIN:cmdStatus1( netuser, cmd, args )
rust.SendChatToUser( netuser, "/status1 Command Called" )
	if self.arenaArmed == "no" then
		rust.SendChatToUser( netuser, "Arena is Not Armed!" )
	else
		rust.SendChatToUser( netuser, "Arena is Armed" )
	end
end ]]
function PLUGIN:cmdStatus1( netuser, cmd, args )
user = netuser.DisplayName
	if ( user == "3lindNinja" ) then
		if ( args[1] == nil ) then
		rust.SendChatToUser( netuser, "/status1 Command Called. No Arguments." )
			if self.arenaArmed == "no" then
				rust.SendChatToUser( netuser, "Arena is Not Armed!" )
			else
				rust.SendChatToUser( netuser, "Arena is Armed" )
			end
		else
			rust.SendChatToUser ( netuser, "Argument Found: " .. args[1] )
		end
			
			
	else
		rust.SendChatToUser( netuser, "Wrong USer!" )
	end
end


-- Automated Oxide help function (added to /help list)
function PLUGIN:SendHelpText( netuser )
	rust.SendChatToUser( netuser, "Use /example to spawn in a pillar behind your head." )
end