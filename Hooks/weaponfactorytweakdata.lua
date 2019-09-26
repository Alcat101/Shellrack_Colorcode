Hooks:PostHook( WeaponFactoryTweakData, "init", "ShellrackModInit", function(self)

	--giving other pump-action shotgun the shell rack attch
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
	
	
	--for loop to apply different shell color texture
	local rack_matcfg = {
		["wpn_fps_shot_r870_body_rack"] = "units/payday2/weapons/wpn_fps_shot_r870_pts/wpn_fps_shot_r870_body_rack",
		["wpn_fps_shot_b682_s_ammopouch"] = "units/pd2_dlc_bonnie/weapons/wpn_fps_shot_b682_pts/wpn_fps_shot_b682_s_ammopouch"
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
		}
	}
	for rack_id, mat_id in pairs(rack_matcfg) do
		for ammo_id, matcfg_path in pairs(shell_id[rack_id]) do
			if self.parts[ammo_id] then
				self.parts[ammo_id].override = self.parts[ammo_id].override or {}
				self.parts[ammo_id].override[rack_id] = { 
					unit = matcfg_path
				}
			end
		end
	end

end )