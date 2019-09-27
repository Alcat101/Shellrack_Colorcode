Hooks:PostHook( WeaponFactoryTweakData, "init", "ShellrackModInit", function(self)

	--giving vanilla pump-action shotgun the shell rack attch
	--benelli m1014
	table.list_append(self.wpn_fps_sho_ben.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	table.list_append(self.wpn_fps_sho_ben_npc.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	self.wpn_fps_sho_ben.override = self.wpn_fps_sho_ben.override or {}
	self.wpn_fps_sho_ben.override.wpn_fps_shot_r870_body_rack = {
		a_obj = "a_rack_benelli",
		stats = {
			value = 3,
			spread_moving = -1,
			concealment = -2,
			total_ammo_mod = 2
		}
	}
	--spas12
	table.list_append(self.wpn_fps_sho_spas12.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	table.list_append(self.wpn_fps_sho_spas12_npc.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	self.wpn_fps_sho_spas12.override = self.wpn_fps_sho_spas12.override or {}
	self.wpn_fps_sho_spas12.override.wpn_fps_shot_r870_body_rack = {
		a_obj = "a_rack_spas12",
		stats = {
			value = 3,
			spread_moving = -1,
			concealment = -2,
			total_ammo_mod = 2
		}
	}
	--ksg
	table.list_append(self.wpn_fps_sho_ksg.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	table.list_append(self.wpn_fps_sho_ksg_npc.uses_parts, {"wpn_fps_shot_r870_body_rack"})
	self.wpn_fps_sho_ksg.override = self.wpn_fps_sho_ksg.override or {}
	self.wpn_fps_sho_ksg.override.wpn_fps_shot_r870_body_rack = {
		a_obj = "a_rack_ksg",
		stats = {
			value = 3,
			spread_moving = -1,
			concealment = -2,
			total_ammo_mod = 4
		}
	}
	
	
	--[[==================================================================================================================================================================]]
	--for loop to apply different shell color texture to vanilla gun
	--table, shell rack attch identifier, that match the ammo and its slug texture change
	--the vanilla_gun table is there to make sure the vanilla for loop only applies to vanilla gun only
	local vanilla_gun = {
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_sho_ben",
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_sho_spas12",
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_sho_ksg",
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_r870",
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_serbu",
		["wpn_fps_shot_b682_s_ammopouch"] = "wpn_fps_shot_b682"
	}
	
	local shell_id = {
		["wpn_fps_shot_r870_body_rack"] = {
			["wpn_fps_upg_a_slug"] = "units/mods/weapons/APslug_texture/r870_AP_rack",
			["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/Dragonsbreath_texture/r870_Dragon_rack",
			["wpn_fps_upg_a_piercing"] = "units/mods/weapons/Flechette_texture/r870_Flechette_rack",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/HEslug_texture/r870_HE_rack"
		},
		["wpn_fps_shot_b682_s_ammopouch"] = {
			["wpn_fps_upg_a_slug"] = "units/mods/weapons/APslug_texture/b682_AP_ammopouch",
			["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/Dragonsbreath_texture/b682_Dragon_ammopouch",
			["wpn_fps_upg_a_piercing"] = "units/mods/weapons/Flechette_texture/b682_Flechette_ammopouch",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/HEslug_texture/b682_HE_ammopouch"
		},
		["wpn_fps_shot_m37_s_rack"] = {
			["wpn_fps_upg_a_slug"] = "units/mods/weapons/wpn_fps_shot_m37_shellrack/m37_AP_stockrack",
			["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/wpn_fps_shot_m37_shellrack/m37_Dragon_stockrack",
			["wpn_fps_upg_a_piercing"] = "units/mods/weapons/wpn_fps_shot_m37_shellrack/m37_Flechette_stockrack",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/wpn_fps_shot_m37_shellrack/m37_HE_stockrack"
		},
		["wpn_fps_shot_huntsman_s_pouch"] = {
			["wpn_fps_upg_a_slug"] = "units/mods/weapons/wpn_fps_shot_huntsman_shellrack/huntsman_AP_stockpouch",
			["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/wpn_fps_shot_huntsman_shellrack/huntsman_Dragon_stockpouch",
			["wpn_fps_upg_a_piercing"] = "units/mods/weapons/wpn_fps_shot_huntsman_shellrack/huntsman_Flechette_stockpouch",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/wpn_fps_shot_huntsman_shellrack/huntsman_HE_stockpouch"
		}
	}
	--vanilla for loop texture change applier
	for rack_id, gun_id in pairs(vanilla_gun) do
		for ammo_id, matcfg_path in pairs(shell_id[rack_id]) do
			if self.parts[ammo_id] then
				self.parts[ammo_id].override = self.parts[ammo_id].override or {}
				self.parts[ammo_id].override[rack_id] = { 
					unit = matcfg_path
				}
			end
		end
	end
	
	
	--custom gun/attachment support
	if BeardLib.Utils:FindMod("GSPS Various Attachment") then
		if self.parts.wpn_fps_shot_m37_s_rack then
			for ammo_id, matcfg_path in pairs(shell_id["wpn_fps_shot_m37_s_rack"]) do
				if self.parts[ammo_id] then
					self.parts[ammo_id].override = self.parts[ammo_id].override or {}
					self.parts[ammo_id].override.wpn_fps_shot_m37_s_rack = { 
						unit = matcfg_path
					}
				end
			end
		end
	end
	
	if BeardLib.Utils:FindMod("Mosconi Various Attachment") then
		if self.parts.wpn_fps_shot_huntsman_s_pouch then
			for ammo_id, matcfg_path in pairs(shell_id["wpn_fps_shot_huntsman_s_pouch"]) do
				if self.parts[ammo_id] then
					self.parts[ammo_id].override = self.parts[ammo_id].override or {}
					self.parts[ammo_id].override.wpn_fps_shot_huntsman_s_pouch = { 
						unit = matcfg_path
					}
				end
			end
		end
	end
	
	if BeardLib.Utils:FindMod("TOZ-194") then
		--already supported by default, since its just reusing r870 rack part tweak data
	end
	
	if BeardLib.Utils:FindMod("Browning Auto Shotgun") then
		--already supported by default, since its just reusing r870 rack part tweak data
	end
		
	if BeardLib.Utils:FindMod("Trench Shotgun") then
		--coming with the mod rework
	end
	
	if BeardLib.Utils:FindMod("Baikal MP-153") then
		table.list_append(self.wpn_fps_shot_mp153.uses_parts, {"wpn_fps_shot_r870_body_rack"})
		table.list_append(self.wpn_fps_shot_mp153_npc.uses_parts, {"wpn_fps_shot_r870_body_rack"})
		self.wpn_fps_shot_mp153.override = self.wpn_fps_shot_mp153.override or {}
		self.wpn_fps_shot_mp153.override.wpn_fps_shot_r870_body_rack = {
			a_obj = "a_rack_mp153",
			adds = { "wpn_fps_shot_mp153_reciever" }, --MP153 uses upper_receiver type for its gun body.. this is to make sure the body stays when isntalling shell rack
			stats = {
				value = 3,
				spread_moving = -1,
				concealment = -2,
				total_ammo_mod = 2
			}
		}
	end
	
	-- if BeardLib.Utils:FindMod("KS-23") then
		--hmm, adding a BIG rack for a BIG slug... intersting
	-- end

	-- if BeardLib.Utils:FindMod("novas") then --Nova Shotgun
		--probably when I came back to it to add more stuff to it..
	-- end

	-- if BeardLib.Utils:FindMod("PLA Pack - QBS-09") then
		--when Im assed enough to update most of the gun on the PLA Pack
	-- end

end )