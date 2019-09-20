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
		-- ["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_r870",
		-- ["wpn_fps_shot_r870_body_rack"] = "wpn_fps_shot_serbu",
		-- ["wpn_fps_shot_b682_s_ammopouch"] = "wpn_fps_shot_b682",
		["wpn_fps_shot_ben_upg_rack"] = "wpn_fps_sho_ben"
	}
	
	local shell_id = {
		-- ["wpn_fps_shot_r870_body_rack"] = {
			-- ["wpn_fps_upg_a_slug"] = "units/mods/weapons/wpn_fps_shot_r870_pts/wpn_fps_shot_r870_APrack",
			-- ["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/wpn_fps_shot_r870_pts/wpn_fps_shot_r870_Dragonrack",
			-- ["wpn_fps_upg_a_piercing"] = "units/mods/weapons/wpn_fps_shot_r870_pts/wpn_fps_shot_r870_Flechetterack",
			-- ["wpn_fps_upg_a_explosive"] = "units/mods/weapons/wpn_fps_shot_r870_pts/wpn_fps_shot_r870_HErack"
		-- },
		-- ["wpn_fps_shot_b682_s_ammopouch"] = {
			-- ["wpn_fps_upg_a_slug"] = "units/mods/weapons/wpn_fps_shot_b682_pts/wpn_fps_shot_b682_APrack",
			-- ["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/wpn_fps_shot_b682_pts/wpn_fps_shot_b682_Dragonrack",
			-- ["wpn_fps_upg_a_piercing"] = "units/mods/weapons/wpn_fps_shot_b682_pts/wpn_fps_shot_b682_Flechetterack",
			-- ["wpn_fps_upg_a_explosive"] = "units/mods/weapons/wpn_fps_shot_b682_pts/wpn_fps_shot_b682_HErack"
		-- },
		["wpn_fps_shot_ben_upg_rack"] = {
			-- ["wpn_fps_upg_a_slug"] = "units/mods/weapons/wpn_fps_sho_ben_pts/wpn_fps_sho_ben_APrack",
			-- ["wpn_fps_upg_a_dragons_breath"] = "units/mods/weapons/wpn_fps_sho_ben_pts/wpn_fps_sho_ben_Dragonrack",
			-- ["wpn_fps_upg_a_piercing"] = "units/mods/weapons/wpn_fps_sho_ben_pts/wpn_fps_sho_ben_Flechetterack",
			["wpn_fps_upg_a_explosive"] = "units/mods/weapons/HEslug_texture/r870_HE_rack"
		}
	}
	
	for rack_id, wpn_id in pairs(shotgun_id) do
		self[wpn_id].override = self[wpn_id].override or {}
		
		for ammo_id, matcfg_path in pairs(shell_id[rack_id]) do
			if self.parts[ammo_id] then
				if self.parts[ammo_id].override then 
					self[wpn_id].override[ammo_id] = deep_clone(self.parts[ammo_id].override) -- I would do it with an 'or {}' if the game wasn't retarded "tAbLe eXpEctEd" bullshit, as if there couldn't be checks for that instead of crashing
				else
					self[wpn_id].override[ammo_id] = {}
				end
				self[wpn_id].override[ammo_id].override = self[wpn_id].override[ammo_id].override or {}
				self[wpn_id].override[ammo_id].override[rack_id] = {
					material_config = Idstring( matcfg_path )
					thq_material_config = Idstring( matcfg_path + "_thq" )
					cc_material_config = Idstring( matcfg_path + "_cc" )
					cc_thq_material_config = Idstring( matcfg_path + "_cc_thq" )
				}
			end
		end
		
	end

end )