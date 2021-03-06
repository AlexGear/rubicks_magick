require("modifiers/helper_modifier_shield")

if modifier_shield_cold == nil then
	modifier_shield_cold = class({})
end

function modifier_shield_cold:IsDebuff()
	return false
end

function modifier_shield_cold:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_shield_cold:OnDestroy()
	HelperModifierShield:StdOnDestroy(self)
end

function modifier_shield_cold:OnCreated(kv)
	HelperModifierShield:StdOnCreated(self, kv, ELEMENT_COLD, "particles/shield_circles/shield_circle_cold.vpcf")
end