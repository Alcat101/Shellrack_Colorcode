Hooks:PostHook(WeaponTweakData, "init", "ShellrackModInit", function(self)

	self:SetupAttachmentPoint( "benelli", {
		name = "a_body",
		base_a_obj = "a_rack_benelli",
		position = Vector3( 0, 0, 0 ),
		rotation = RotationCAP(0, 0, 0)
	})

end)