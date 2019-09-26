Hooks:PostHook(WeaponTweakData, "init", "ShellrackModInit", function(self)

	self:SetupAttachmentPoint( "benelli", {
		name = "a_rack_benelli",
		base_a_obj = "a_body",
		position = Vector3( 0, 21.5, 7.25 ),
		rotation = RotationCAP(0, 0, 0)
	})

	self:SetupAttachmentPoint( "spas12", {
		name = "a_rack_spas12",
		base_a_obj = "a_body",
		position = Vector3( 0, 19, 8 ),
		rotation = RotationCAP(0, 0, 0)
	})

	self:SetupAttachmentPoint( "ksg", {
		name = "a_rack_ksg",
		base_a_obj = "a_body",
		position = Vector3( 1, -10.5, 6 ),
		rotation = RotationCAP(0, 0, 160)
	})

end)