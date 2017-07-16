
if modifier_shield_lightning == nil then
	modifier_shield_lightning = class({})
end

function modifier_shield_lightning:IsDebuff()
	return false
end

function modifier_shield_lightning:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_shield_lightning:OnDestroy()
	if IsServer() then
		self:GetParent():GetPlayerOwner().shieldElements[self.index] = nil
		if self.particleIndex ~= nil then
			ParticleManager:DestroyParticle(self.particleIndex, false)
		end
	end
end

function modifier_shield_lightning:OnCreated(kv)
	self.index = kv.index
	if IsServer() then
		self:GetParent():GetPlayerOwner().shieldElements[self.index] = ELEMENT_LIGHTNING

		self.particleIndex = ParticleManager:CreateParticle("particles/shield_circles/shield_circle_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self.particleIndex, 1, Vector(kv.circleRadius, 0, 0))
		self:AddParticle(self.particleIndex, false, false, -1, false, false)
	end
end