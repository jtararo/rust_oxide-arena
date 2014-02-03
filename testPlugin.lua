PLUGIN.Title = "Example"
PLUGIN.Description = "Example Plugin"
PLUGIN.Author = "Your Name"
PLUGIN.Version = "1.0"

-- Called when oxide loads or user types oxide.reload example at F1 console
function PLUGIN:Init()
	self.arenaArmed = "no"
    self:AddChatCommand("status", self.cmdStatus)
	self.AddChatCommand("arm", self.cmdArmArena)
	
end

-- Called when user types /example
function PLUGIN:cmdStatus( netuser, cmd, args )
rust.SendChatToUser( netuser, "/status Command Called" )
	if self.arenaArmed == "no" then
		rust.SendChatToUser( netuser, "Arena is Not Armed!" )
	else
		rust.SendChatToUser( netuser, "Arena is Armed" )
	end
end

-- Arm the Arena
function PLUGIN:cmdArmArena( netuser, cmd, args )
rust.SendChatToUser( netuser, "/arm Command Called" )
	if self.arenaArmed == "no" then
	self.arenaArmed = "yes"
		rust.SendChatToUser( netuser, "Arena is now Armed!" )
	else
	self.arenaArmed = "no"
		rust.SendChatToUser( netuser, "Arena is no disarmed" )
	end
end

-- Automated Oxide help function (added to /help list)
function PLUGIN:SendHelpText( netuser )
	rust.SendChatToUser( netuser, "Use /example to spawn in a pillar behind your head." )
end