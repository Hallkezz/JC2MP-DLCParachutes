---------------
--By Hallkezz--
---------------

-----------------------------------------------------------------------------------
--Settings
local thrusters = true -- Use Parachute Thrusters? (Use: true/false)
---------------------
local tColor = Color( 255, 170, 0 ) -- Messages Color.
---------------------
local purchasedText = "You have purchased a " -- Purchased Message.
---------------------
local pD = "Default chute!" -- "Default chute" name.
local p1 = "Parachute thrusters!" -- "Parachute thrusters" name.
local p2 = "Daredevil chute!" -- "Daredevil chute" name.
local p3 = "Chaos chute!" -- "Chaos chute" name.
local p4 = "Camo chute!" -- "Camo chute" name.
local p5 = "Tiger chute!" -- "Tiger chute" name.
local p6 = "Scorpion chute!" -- "Scorpion chute" name.
local p7 = "Firestorm chute!" -- "Firestorm chute" name.
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--Script
class 'DLCParachutes'

function DLCParachutes:__init()
	Network:Subscribe( "GiveMeParachute", self, self.GiveMeParachute )

	Events:Subscribe( "GameLoad", self, self.GameLoad )
	Events:Subscribe( "ModulesLoad", self, self.ModulesLoad )
	Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end

function DLCParachutes:GiveMeParachute( args, sender )
	Game:FireEvent( args.parachutename )
end

function DLCParachutes:GameLoad()
	Network:Send( "LoadParachute" )
end

--Help
function DLCParachutes:ModulesLoad()
	Events:Fire( "HelpAddItem",
		{
			name = "[DLC] Parachutes",
			text = 
				"You can use any parachute (if you have DLC), enter these commands to activate:\n" ..
				"    /p or /chute - Default Parachute\n" ..
				"    /p1 or /chute1 - Dual Parachute Thrusters\n" ..
				"    /p2 or /chute2 - Daredevil Parachute\n" ..
				"    /p3 or /chute3 - Chaos Parachute\n" ..
				"    /p4 or /chute4 - Camo Parachute\n" ..
				"    /p5 or /chute5 - Tiger Parachute\n" ..
				"    /p6 or /chute6 - Scorpion Parachute\n" ..
				"    /p7 or /chute7 - Firestorm Parachute\n \n" ..
				"Buy DLC - https://store.steampowered.com/dlc/8190/\n \n" ..
				"- Created By Hallkezz"
		} )
end

function DLCParachutes:ModuleUnload()
    Events:Fire( "HelpRemoveItem",
		{
			name = "[DLC] Parachutes"
		} )
end

dlcparachutes = DLCParachutes()
-----------------------------------------------------------------------------------
--Script Version
--v3.0--

--Release Date
--12.07.19--
-----------------------------------------------------------------------------------