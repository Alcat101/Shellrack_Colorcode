function NewRaycastWeaponBase:_update_materials()
	if not self._parts then
		return
	end

	local use = not self:is_npc() or self:use_thq()
	local use_cc_material_config = use and self._cosmetics_data and true or false
	local is_thq = self:is_npc() and self:use_thq()
	is_thq = is_thq or not self:is_npc() and _G.IS_VR

	local material_config_ids = Idstring("material_config")
	if self._materials then
		for part_id, part in pairs(self._parts) do
			local part_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(part_id, self._factory_id, self._blueprint)
			
			if part_data then
				local new_material_config_ids = part_data.material_config or Idstring(self:is_npc() and part_data.third_unit or part_data.unit)

				if part.unit:material_config() ~= new_material_config_ids and DB:has(material_config_ids, new_material_config_ids) then
					part.unit:set_material_config(new_material_config_ids, true)
				end
			end
		end

		self._materials = nil
	else
		for part_id, part in pairs(self._parts) do
			local part_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(part_id, self._factory_id, self._blueprint)

			if part_data then
				local new_material_config_ids = self:_material_config_name(part_data, use_cc_material_config)

				if part.unit:material_config() ~= new_material_config_ids and DB:has(material_config_ids, new_material_config_ids) then
					part.unit:set_material_config(new_material_config_ids, true)
				end
			end
		end

		if use_cc_material_config then
			self._materials = {}
			self._materials_default = {}

			for part_id, part in pairs(self._parts) do
				local materials = part.unit:get_objects_by_type(Idstring("material"))

				for _, m in ipairs(materials) do
					if m:variable_exists(Idstring("wear_tear_value")) then
						self._materials[part_id] = self._materials[part_id] or {}
						self._materials[part_id][m:key()] = m
					end
				end
			end
		end
	end
end

function NewRaycastWeaponBase:spawn_magazine_unit(pos, rot, hide_bullets)
	local mag_data = nil
	local mag_list = managers.weapon_factory:get_parts_from_weapon_by_type_or_perk("magazine", self._factory_id, self._blueprint)
	local mag_id = mag_list and mag_list[1]

	if not mag_id then
		return
	end

	mag_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(mag_id, self._factory_id, self._blueprint)
	local part_data = self._parts[mag_id]

	if not mag_data or not part_data then
		return
	end

	pos = pos or Vector3()
	rot = rot or Rotation()
	local is_thq = managers.weapon_factory:use_thq_weapon_parts()
	local use_cc_material_config = is_thq and self:get_cosmetics_data() and true or false
	local material_config_ids = Idstring("material_config")
	local mag_unit = World:spawn_unit(part_data.name, pos, rot)
	local new_material_config_ids = self:_material_config_name(mag_id, mag_data, use_cc_material_config, true)

	if mag_unit:material_config() ~= new_material_config_ids and DB:has(material_config_ids, new_material_config_ids) then
		mag_unit:set_material_config(new_material_config_ids, true)
	end

	if hide_bullets and part_data.bullet_objects then
		local prefix = part_data.bullet_objects.prefix

		for i = 1, part_data.bullet_objects.amount, 1 do
			local target_object = mag_unit:get_object(Idstring(prefix .. i))
			local ref_object = part_data.unit:get_object(Idstring(prefix .. i))

			if target_object then
				if ref_object then
					target_object:set_visibility(ref_object:visibility())
				else
					target_object:set_visibility(false)
				end
			end
		end
	end

	local materials = {}
	local unit_materials = mag_unit:get_objects_by_type(Idstring("material")) or {}

	for _, m in ipairs(unit_materials) do
		if m:variable_exists(Idstring("wear_tear_value")) then
			table.insert(materials, m)
		end
	end

	local textures = {}
	local base_variable, base_texture, mat_variable, mat_texture, type_variable, type_texture, p_type, custom_variable, texture_key = nil
	local cosmetics_data = self:get_cosmetics_data() or {}
	local cosmetics_quality = self._cosmetics_quality
	local wear_tear_value = cosmetics_quality and tweak_data.economy.qualities[cosmetics_quality] and tweak_data.economy.qualities[cosmetics_quality].wear_tear_value or 1

	for _, material in pairs(materials) do
		material:set_variable(Idstring("wear_tear_value"), wear_tear_value)

		p_type = managers.weapon_factory:get_type_from_part_id(mag_id)

		for key, variable in pairs(material_variables) do
			mat_variable = cosmetics_data.parts and cosmetics_data.parts[mag_id] and cosmetics_data.parts[mag_id][material:name():key()] and cosmetics_data.parts[mag_id][material:name():key()][key]
			type_variable = cosmetics_data.types and cosmetics_data.types[p_type] and cosmetics_data.types[p_type][key]
			base_variable = cosmetics_data[key]

			if mat_variable or type_variable or base_variable then
				material:set_variable(Idstring(variable), mat_variable or type_variable or base_variable)
			end
		end

		for key, material_texture in pairs(material_textures) do
			mat_texture = cosmetics_data.parts and cosmetics_data.parts[mag_id] and cosmetics_data.parts[mag_id][material:name():key()] and cosmetics_data.parts[mag_id][material:name():key()][key]
			type_texture = cosmetics_data.types and cosmetics_data.types[p_type] and cosmetics_data.types[p_type][key]
			base_texture = cosmetics_data[key]
			local texture_name = mat_texture or type_texture or base_texture

			if texture_name then
				if type_name(texture_name) ~= "Idstring" then
					texture_name = Idstring(texture_name)
				end

				Application:set_material_texture(material, Idstring(material_texture), texture_name, Idstring("normal"))
			end
		end
	end

	return mag_unit
end

function NewRaycastWeaponBase:_material_config_name(part_data, use_cc_material_config, force_third_person)
	force_third_person = force_third_person or _G.IS_VR or self:is_npc()

	if force_third_person then
		if use_cc_material_config and part_data.cc_thq_material_config then
			return part_data.cc_thq_material_config
		end

		if part_data.thq_material_config then
			return part_data.thq_material_config
		end
	end

	if use_cc_material_config and part_data.cc_material_config then
		return part_data.cc_material_config
	end

	if not use_cc_material_config and not force_third_person and part_data.material_config then
		return part_data.material_config
	end

	local cc_string = use_cc_material_config and "_cc" or ""
	local thq_string = force_third_person and "_thq" or ""

	return Idstring(part_data.unit .. cc_string .. thq_string)
end