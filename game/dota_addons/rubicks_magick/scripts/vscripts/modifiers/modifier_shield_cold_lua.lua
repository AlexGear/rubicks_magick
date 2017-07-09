
if modifier_shield_cold_lua == nil then
	modifier_shield_cold_lua = class({})
end

function modifier_shield_cold_lua:IsDebuff()
	return false
end

function modifier_shield_cold_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_shield_cold_lua:OnDestroy()
	if self.particleIndex ~= nil then
		ParticleManager:DestroyParticle(self.particleIndex, false)
	end
end

function modifier_shield_cold_lua:OnCreated(kv)
	self.index = kv.index
	self.duration = kv.duration
	if IsServer() then
		self:SetDuration(self.duration, true)
		self:StartIntervalThink(self.duration)

		self.particleIndex = ParticleManager:CreateParticle("particles/shield_circles/shield_circle_cold.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControl(self.particleIndex, 1, Vector(kv.circleRadius, 0, 0))
		self:AddParticle(self.particleIndex, false, false, -1, false, false)
	end
end

function modifier_shield_cold_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP
	}
	return funcs
end

function modifier_shield_cold_lua:OnTooltip()
	return "Cold shield"
end

function modifier_shield_cold_lua:OnIntervalThink()
	if IsServer() then
		self:StartIntervalThink(-1)
		self:GetCaster():GetPlayerOwner().shieldElements[self.index] = nil
		self:Destroy()
	end
end