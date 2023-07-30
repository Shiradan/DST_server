local Widget = require "widgets/widget"
local Button = require "widgets/button"
local Image = require "widgets/image"
local Text = require "widgets/text"

local Zzh_SkillButton2 = Class(Button, function(self, inst, atlas, normal_tex, focus_tex, x,y,z, str)
	
	Button._ctor(self, "Zzh_SkillButton")
	
	--定义按钮
	
	--增加贴图
    --self:SetTextures(atlas, normal_tex, focus_tex, normal_tex) 
	--SetTextures(atlas, normal, focus, disabled, down, selected, image_scale, image_offset)
	
	if atlas and normal_tex and focus_tex then
		self.image = self:AddChild(Image())
		self.image:SetTexture(atlas, normal_tex, focus_tex) 
	end
	
	--技能按钮的位置
    self:SetPosition(x, y, z)
	
	--定义文字
	self.text0 = self:AddChild(Text(NUMBERFONT, 30))
	self.text0:SetVAlign(ANCHOR_MIDDLE)
    self.text0:SetColour({0,1,0,1})
	self.text0:SetString(str)
	
	self:SetScale(.75, .75, .75)
end)

function Zzh_SkillButton2:Zzh_SetTint(a,b,c,d)
	if self.image then
		self.image:SetTint(a,b,c,d)
	end
end

function Zzh_SkillButton2:Zzh_SetColour(a,b,c,d)
	self.text0:SetColour({a,b,c,d})
end

function Zzh_SkillButton2:Zzh_SetString(str)
	self.text0:SetString(str)
end

return Zzh_SkillButton2





