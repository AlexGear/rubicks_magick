
if modifier_shield_life_lua == nil then
	modifier_shield_life_lua = class({})
end

function modifier_shield_life_lua:IsDebuff()
	return false
end

function modifier_shield_life_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_shield_life_lua:OnDestroy()
	if self.particleIndex ~= nil then
		ParticleManager:DestroyParticle(self.particleIndex, false)
	end
end

function modifier_shield_life_lua:OnCreated(kv)
	self.index = kv.index
	self.duration = kv.duration
	if IsServer() then
		self:SetDuration(self.duration, true)
		self:StartIntervalThink(self.duration)

		self.particleIndex = ParticleManager:CreateParticle("particles/shield_circles/shield_circle_life.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControl(self.particleIndex, 1, Vector(kv.circleRadius, 0, 0))
		self:AddParticle(self.particleIndex, false, false, -1, false, false)
	end
end

function modifier_shield_life_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP
	} 
	return funcs
end

function modifier_shield_life_lua:OnTooltip()
	return "Life shield"
end

function modifier_shield_life_lua:OnIntervalThink()
	if IsServer() then
		self:StartIntervalThink(-1)
		self:GetCaster():GetPlayerOwner().shieldElements[self.index] = nil
		self:Destroy()
	end
end