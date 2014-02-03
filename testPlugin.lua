PLUGIN.Title = "Example"
PLUGIN.Description = "Example Plugin"
PLUGIN.Author = "Your Name"
PLUGIN.Version = "1.0"

print(PLUGIN.Title .. " plugin loaded")

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

function PLUGIN:cmdStatus1( netuser, cmd, args )

user = netuser.DisplayName
	if ( user == "3lindNinja" ) then
		rust.SendChatToUser( netuser, "/status1 Command Called" )
		if ( args[1] == nil ) then
		rust.SendChatToUser( netuser, "No Arguments." )
			if self.arenaArmed == "no" then
				rust.SendChatToUser( netuser, "Arena is Not Armed!" )
			else
				rust.SendChatToUser( netuser, "Arena is Armed" )
			end
		else
			arg = args[1]
			rust.SendChatToUser ( netuser, "Argument Found: " .. arg )
			
			-- Some Random Data
			data = {}
			data.1.coords.x = 100
			data.1.coords.y = 110
			data.1.coords.z = 120

			data.2.coords.x = 200
			data.2.coords.y = 210
			data.2.coords.z = 220

			data.3.coords.x = 300
			data.3.coords.y = 310
			data.3.coords.z = 320

			data.4.coords.x = 400
			data.4.coords.y = 410
			data.4.coords.z = 420
			
			if ( data.arg != nil ) then
				rust.SendChatToUser( netuser, "Coords: x=" .. data.arg.coords.x .. " y=" .. data.arg.coords.y .. " y=" .. data.arg.coords.z )
				else
				rust.SendChatTouser( netuser, "Invalid choice!" )
				end
			
		end
			
			
	else
		rust.SendChatToUser( netuser, "Wrong USer!" )
	end
end

-- Define some random data
function PLUGIN:data()
data == {}
data.1.coords.x = 100
data.1.coords.y = 110
data.1.coords.z = 120

data.2.coords.x = 200
data.2.coords.y = 210
data.2.coords.z = 220

data.3.coords.x = 300
data.3.coords.y = 310
data.3.coords.z = 320

data.4.coords.x = 400
data.4.coords.y = 410
data.4.coords.z = 420
return
end

-- Automated Oxide help function (added to /help list)
function PLUGIN:SendHelpText( netuser )
	rust.SendChatToUser( netuser, "Use /example to spawn in a pillar behind your head." )
end