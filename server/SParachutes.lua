---------------
--By Hallkezz--
---------------

-----------------------------------------------------------------------------------
--Settings
local active = "/chute" -- "Default Parachute" activate command.
local active1 = "/chute1" -- "Parachute Thrusters" activate command.
local active2 = "/chute2" -- "Daredevil Parachute" activate command.
local active3 = "/chute3" -- "Chaos Parachute" activate command.
local active4 = "/chute4" -- "Camo Parachute" activate command.
local active5 = "/chute5" -- "Tiger Parachute" activate command.
local active6 = "/chute6" -- "Scorpion Parachute" activate command.
local active7 = "/chute7" -- "Firestorm Parachute" activate command.
---------------------
local twActive = "/p" -- "Default Parachute" activate command 2.
local twActive1 = "/p1" -- "Parachute Thrusters" activate command 2.
local twActive2 = "/p2" -- "Daredevil Parachute" activate command 2.
local twActive3 = "/p3" -- "Chaos Parachute" activate command 2.
local twActive4 = "/p4" -- "Camo Parachute" activate command 2.
local twActive5 = "/p5" -- "Tiger Parachute" activate command 2.
local twActive6 = "/p6" -- "Scorpion Parachute" activate command 2.
local twActive7 = "/p7" -- "Firestorm Parachute" activate command 2.
---------------------
local thActive = "/p0" -- "Default Parachute" activate command 3.
local thActive1 = "/chute0" -- "Default Parachute" activate command 4.
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--Script
class 'DLCParachutes'

function DLCParachutes:__init()
	SQL:Execute( "CREATE TABLE IF NOT EXISTS parachutes (steamid VARCHAR UNIQUE, parachute INTEGER)" )
	self.parachute = "parachute01.pickup.execute"

	Network:Subscribe( "LoadParachute", self, self.LoadParachute )

	Events:Subscribe( "PlayerChat", self, self.PlayerChat )
	Events:Subscribe( "PlayerQuit", self, self.PlayerQuit )
end

function DLCParachutes:LoadParachute( args, sender )
	self:SetParachutesFromDB( args, sender )
end

function DLCParachutes:SetParachutesFromDB( args, sender )
    local qry = SQL:Query( "select parachute from parachutes where steamid = (?)" )
    qry:Bind( 1, sender:GetSteamId().id )
    local result = qry:Execute()

    if #result > 0 then
        Network:Send( sender, "GiveMeParachute", { parachutename = result[1].parachute } )
    end
end

function DLCParachutes:PlayerChat( args )
	local msg = args.text

	if ( msg:sub(1, 1) ~= "/" ) then
		return true
	end

	local cmdargs = {}
	for word in string.gmatch(msg, "[^%s]+") do
		table.insert(cmdargs, word)
	end
    
	--Default Parachute	
	if ( cmdargs[1] == active ) or ( cmdargs[1] == twActive ) or ( cmdargs[1] == thActive ) or ( cmdargs[1] == thActive1 ) then
		self.parachute = "parachute00.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end
	
	--Dual Parachute Thrusters
	if ( cmdargs[1] == active1 ) or ( cmdargs[1] == twActive1 ) then
		self.parachute = "parachute01.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Daredevil Parachute
	if ( cmdargs[1] == active2 ) or ( cmdargs[1] == twActive2 ) then
		self.parachute = "parachute02.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Chaos Parachute
	if ( cmdargs[1] == active3 ) or ( cmdargs[1] == twActive3 ) then
		self.parachute = "parachute03.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Camo Parachute
	if ( cmdargs[1] == active4 ) or ( cmdargs[1] == twActive4 ) then
		self.parachute = "parachute04.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Tiger Parachute
	if ( cmdargs[1] == active5 ) or ( cmdargs[1] == twActive5 ) then
		self.parachute = "parachute05.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Scorpion Parachute
	if ( cmdargs[1] == active6 ) or ( cmdargs[1] == twActive6 ) then
		self.parachute = "parachute06.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end

	--Firestorm Parachute
	if ( cmdargs[1] == active7 ) or ( cmdargs[1] == twActive7 ) then
		self.parachute = "parachute07.pickup.execute"
		Network:Send( args.player, "GiveMeParachute", { parachutename = self.parachute } )
		return false
	end
	return false
end

function DLCParachutes:PlayerQuit( args )
	self:SaveParachute( args )
end

function DLCParachutes:SaveParachute( args )
    local cmd = SQL:Command( "insert or replace into parachutes (steamid, parachute) values (?, ?)" )
    cmd:Bind( 1, args.player:GetSteamId().id )
    cmd:Bind( 2, self.parachute )
    cmd:Execute()

    return true, ""
end

dlcparachutes = DLCParachutes()
-----------------------------------------------------------------------------------
--Script Version
--v3.0--

--Release Date
--12.07.19--
-----------------------------------------------------------------------------------