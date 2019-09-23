Hooks:PostHook( WeaponFactoryTweakData, "init", "ShellrackModInit", function(self)

	--[[this is how the shell rack will change the shell texture according to equipped shotgun ammo
	a_HE override = {
		self.parts.wpn_fps_shot_ben_upg_rack.material_config = Idstring("units/mods/weapons/HEslug_texture/r870_HE_rack")
		self.parts.wpn_fps_shot_ben_upg_rack.thq_material_config = Idstring("units/mods/weapons/HEslug_texture/r870_HE_rack_thq")
		self.parts.wpn_fps_shot_ben_upg_rack.cc_material_config = Idstring("units/mods/weapons/HEslug_texture/r870_HE_rack_cc")
		self.parts.wpn_fps_shot_ben_upg_rack.cc_thq_material_config = Idstring("units/mods/weapons/HEslug_texture/r870_HE_rack_cc_thq")
	}
	]]--
	
	--
	local shotgun_id = {
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_r870",
		["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_serbu",
		["wpn_fps_shot_b682_s_ammopouch"] = "wpn_fps_shot_b682",
		["wpn_fps_shot_ben_upg_rack"] = "wpn_fps_sho_ben"
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
		["wpn_fps_shot_ben_upg_rack"] = {
			["wpn_fps_upg_a_slug"] = "units/mods/weapons/APslug_texture/r870_AP_rack",
			["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/Dragonsbreath_texture/r870_Dragon_rack",
			["wpn_fps_upg_a_piercing"] = "units/mods/weapons/Flechette_texture/r870_Flechette_rack",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/HEslug_texture/r870_HE_rack"
		}
	}
	
	for rack_id, wpn_id in pairs(shotgun_id) do
		for ammo_id, matcfg_path in pairs(shell_id[rack_id]) do
			if self.parts[ammo_id] then
				--log("COLOR_TEST " .. self.parts[rack_id].material_config)
				self.parts[ammo_id].override = self.parts[ammo_id].override or {}
				self.parts[ammo_id].override[rack_id] = {
					material_config = Idstring( matcfg_path ),
					thq_material_config = Idstring( matcfg_path .. "_thq" ),
					cc_material_config = Idstring( matcfg_path .. "_cc" ),
					cc_thq_material_config = Idstring( matcfg_path .. "_cc_thq" )
				}
			end
		end
	end

end )