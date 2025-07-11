---------------
--By Hallkezz--
---------------

-----------------------------------------------------------------------------------
--Settings
local command = "/chute" -- Command to change parachute
---------------------
local succColor = Color.Chartreuse -- Successfully messages color
local unsuccColor = Color.Red -- Unsuccessfully messages color
---------------------
local changedText = "Parachute changed" -- Parachute changed message
local unknownText = "Unknown parachute. Usage: /chute 0-7" -- Unknown parachute message
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--Script
class 'DLCParachutes'

function DLCParachutes:__init()
    SQL:Execute("CREATE TABLE IF NOT EXISTS parachutes (steamid VARCHAR UNIQUE, parachute INTEGER)")

	self.parachutes = {
		[0] = "parachute00.pickup.execute", -- Default chute
		[1] = "parachute01.pickup.execute", -- Parachute thrusters
		[2] = "parachute02.pickup.execute", -- Daredevil chute
		[3] = "parachute03.pickup.execute", -- Chaos chute
		[4] = "parachute04.pickup.execute", -- Camo chute
		[5] = "parachute05.pickup.execute", -- Tiger chute
		[6] = "parachute06.pickup.execute", -- Scorpion chute
		[7] = "parachute07.pickup.execute" -- Firestorm chute
	}

	self.player_parachutes = {}

    Network:Subscribe("LoadParachute", self, self.LoadParachute)

    Events:Subscribe("PlayerChat", self, self.PlayerChat)
    Events:Subscribe("PlayerQuit", self, self.PlayerQuit)
end

function DLCParachutes:LoadParachute(args, sender)
    self:SetParachutesFromDB(args, sender)
end

function DLCParachutes:SetParachutesFromDB(args, sender)
    local qry = SQL:Query("select parachute from parachutes where steamid = (?)")
    qry:Bind(1, sender:GetSteamId().id)
    local result = qry:Execute()

    if #result > 0 then
		local parachute_num = tonumber(result[1].parachute)

		self.player_parachutes[sender:GetId()] = parachute_num
        Network:Send(sender, "GiveMeParachute", {parachute_name = self.parachutes[parachute_num]})
    end
end

function DLCParachutes:PlayerChat(args)
    local cmd_args = args.text:split(" ")

	if cmd_args[1] == command then
        local num = tonumber(cmd_args[2]) or 0
        local current_parachute = self.parachutes[num]

		if not current_parachute then
			Chat:Send(args.player, unknownText, unsuccColor)
		else
			self.player_parachutes[args.player:GetId()] = num
			Network:Send(args.player, "GiveMeParachute", {parachute_name = current_parachute})

			Chat:Send(args.player, changedText, succColor)
		end

		return false
	end
end

function DLCParachutes:PlayerQuit(args)
    self:SaveParachute(args)
end

function DLCParachutes:SaveParachute(args)
	local pId = args.player:GetId()
	local steamId = args.player:GetSteamId().id
	local num = self.player_parachutes[pId] or 0

    if num == 0 then
        local cmd = SQL:Command("delete from parachutes where steamid = ?")
        cmd:Bind(1, steamId)
		cmd:Execute()
    else
        local cmd = SQL:Command("insert or replace into parachutes (steamid, parachute) values (?, ?)")
        cmd:Bind(1, steamId)
        cmd:Bind(2, num)
		cmd:Execute()
    end

	self.player_parachutes[pId] = nil
end

local dlcparachutes = DLCParachutes()
-----------------------------------------------------------------------------------
--Script Version
--v4.0--

--Release Date
--11.07.25--
-----------------------------------------------------------------------------------