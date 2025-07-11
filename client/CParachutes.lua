---------------
--By Hallkezz--
---------------

-----------------------------------------------------------------------------------
--Script
class 'DLCParachutes'

function DLCParachutes:__init()
    Network:Subscribe("GiveMeParachute", self, self.GiveMeParachute)

    Events:Subscribe("GameLoad", self, self.GameLoad)
    Events:Subscribe("ModulesLoad", self, self.ModulesLoad)
    Events:Subscribe("ModuleUnload", self, self.ModuleUnload)
end

function DLCParachutes:GiveMeParachute(args, sender)
    Game:FireEvent(args.parachute_name)
end

function DLCParachutes:GameLoad()
    Network:Send("LoadParachute")
end

--Help
function DLCParachutes:ModulesLoad()
	Events:Fire("HelpAddItem",
		{
			name = "[DLC] Parachutes",
			text = 
				"You can use any parachute (if you have DLC), enter these commands to activate:\n" ..
				"    /chute - Default Parachute\n" ..
				"    /chute 1 - Dual Parachute Thrusters\n" ..
				"    /chute 2 - Daredevil Parachute\n" ..
				"    /chute 3 - Chaos Parachute\n" ..
				"    /chute 4 - Camo Parachute\n" ..
				"    /chute 5 - Tiger Parachute\n" ..
				"    /chute 6 - Scorpion Parachute\n" ..
				"    /chute 7 - Firestorm Parachute\n \n" ..
				"Buy DLC - https://store.steampowered.com/dlc/8190/\n \n" ..
				"- Created By Hallkezz"
		})
end

function DLCParachutes:ModuleUnload()
    Events:Fire("HelpRemoveItem", {name = "[DLC] Parachutes"})
end

local dlcparachutes = DLCParachutes()
-----------------------------------------------------------------------------------
--Script Version
--v4.0--

--Release Date
--11.07.25--
-----------------------------------------------------------------------------------