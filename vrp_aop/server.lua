local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

a = 0
b = 0
c = 0
d = 0
e = 0
--f = 0		--new entry

local AOP = class("AOP", vRP.Extension)

local function menu_aop(self)
	
	local function m_set(menu)
		menu.user:openMenu("aop.set")
	end
	
	local function m_vote(menu)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			vRP:triggerEvent("voteEnd", nuser)
		end
		
		self.setaop = not self.setaop
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			if self.setaop then -- set
				vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
				vRP.EXT.Base.remote._notify(nuser.source, self.lang.vote.start_vote.notify())
				local aop = self.cfg.aop
				local css = self.cfg.display_css
				local lang = self.lang.aop.vote
				for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
					vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_1",css,lang({aop[1].name,a}))
					vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_2",css,lang({aop[2].name,b}))
					vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_3",css,lang({aop[3].name,c}))
					vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_4",css,lang({aop[4].name,d}))
					vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_5",css,lang({aop[5].name,e}))
					--vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_6",css,lang({aop[6].name,f}))	-- --new entry
				end
			end
			if nuser:hasPermission(self.cfg.nuser) and not nuser:hasPermission(self.cfg.admin)  then
				nuser:openMenu("aop.vote.choice")
			end
		end
	end
	
	local function m_endVote(menu)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			vRP:triggerEvent("forceEnd", nuser)
		end
	end
	
	local function m_autoAOP(menu)
		vRP:triggerEvent("auto_aop", nuser)
	end
	
	local function m_clear(menu)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
			--vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5","remove_aop_5", nuser)
			--new entry
		end
	end
	
	vRP.EXT.GUI:registerMenuBuilder("aop", function(menu)
		local user = menu.user

		menu.title = self.lang.aop.title()
		menu.css.header_color = "rgba(200,0,0,0.75)"
		
		menu:addOption(self.lang.set.title(), m_set)
		menu:addOption(self.lang.vote.title(), m_vote)
		menu:addOption(self.lang.vote.title_1(), m_endVote)
		menu:addOption(self.lang.auto_aop.title(), m_autoAOP)
		menu:addOption(self.lang.clear.title(), m_clear)
	end)
end

local function menu_aop_vote_choice(self)
	
	local function m_choice(menu, i)
		local aop = self.cfg.aop
		local css = self.cfg.display_css
		local lang = self.lang.aop.vote
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			if i == 1 then
				a = a + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_1",css,lang({aop[1].name,a}))
				nuser:closeMenu(menu)
				if a >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_1", nuser)
				end
			end
			if i == 2 then
				b = b + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_2",css,lang({aop[2].name,b}))
				nuser:closeMenu(menu)
				if b >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_2", nuser)
				end
			end
			if i == 3 then
				c = c + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_3",css,lang({aop[3].name,c}))
				nuser:closeMenu(menu)
				if c >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_3", nuser)
				end
			end
			if i == 4 then
				d = d + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_4",css,lang({aop[4].name,d}))
				nuser:closeMenu(menu)
				if d >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_4", nuser)
				end
			end
			if i == 5 then
				e = e + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_5",css,lang({aop[5].name,e}))
				nuser:closeMenu(menu)
				if e >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_5", nuser)
				end
			end
			--[[
			--new entry
			if i == 6 then
				f = f + 1
				vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_5",css,lang({aop[6].name,f}))
				--nuser:closeMenu(menu)
				if f >= self.cfg.vote then
					vRP:triggerEvent("forceEnd", nuser)
					vRP:triggerEvent("set_aop_6", nuser)
				end
			end
			--]]
		end
	end

	vRP.EXT.GUI:registerMenuBuilder("aop.vote.choice", function(menu)
		menu.title = self.lang.aop.vote_1()
		menu.css.header_color="rgba(0,125,255,0.75)"
		local aop = self.cfg.aop
		for i=1, #aop, 1 do 
			menu:addOption(self.lang.vote.choice({aop[i].name}), m_choice, i)
		end
	end)
end

local function menu_aop_set(self)
	local function m_set(menu, i)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			if i == 1 then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_1", nuser)
			end
			if i == 2 then 
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_2", nuser)
			end
			if i == 3 then 
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_3", nuser)
			end
			if i == 4 then 
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_4", nuser)
			end
			if i == 5 then 
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_5", nuser)
			end
			--[[
			--new entry
			if i == 6 then 
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5","remove_aop_6", nuser)
				vRP:triggerEvent("set_aop_6", nuser)
			end
			--]]
		end
	end
	
	vRP.EXT.GUI:registerMenuBuilder("aop.set", function(menu)
		menu.title = self.lang.set.title()
		menu.css.header_color="rgba(0,125,255,0.75)"
		local user = menu.user
		local aop = self.cfg.aop
		for i=1, #aop, 1 do 
			menu:addOption(self.lang.set.pos_title({aop[i].name}), m_set, i)
		end
	end)
end

function AOP:__construct()
	vRP.Extension.__construct(self)
	
	self.cfg = module("vrp_aop", "cfg/cfg")
	self.setaop = false
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_aop", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
   
	menu_aop(self)
	menu_aop_set(self)
	menu_aop_vote_choice(self)
	
   
	vRP.EXT.GUI:registerMenuBuilder("admin", function(menu)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			if nuser:hasPermission(self.cfg.admin) then
				menu:addOption("AOP", function(menu)
					menu.user:openMenu("aop")
				end)
			end
		end
	end)
end

-- EVENT
AOP.event = {}

function AOP.event:playerSpawn(user, first_spawn)
  -- add aop display
	if self.cfg.aop_display and first_spawn then
		vRP.EXT.GUI.remote._setDiv(user.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end

function AOP.event:forceEnd()
	local lang1 = self.lang.aop.vote_end
	local css = self.cfg.display_css
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		Wait(200)
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source, self.lang.vote.end_vote.notify())
		vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_1",css,lang1())
		vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_2",css,lang1())
		vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_3",css,lang1())
		vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_4",css,lang1())
		vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_5",css,lang1())
		--vRP.EXT.GUI.remote._setDiv(nuser.source,"vote_6",css,lang1())		--new entry
		a = 0
		b = 0
		c = 0
		d = 0
		e = 0
		--f = 0		--new entry
	end
end

function AOP.event:auto_aop()
	local aop = self.cfg.aop
	j = math.random(1,#aop)
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		if self.cfg.auto then
			if aop[j].name == aop[1].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_1", nuser)
			end
			if aop[j].name == aop[2].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_2", nuser)
			end
			if aop[j].name == aop[3].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_3", nuser)
			end
			if aop[j].name == aop[4].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_4", nuser)
			end
			if aop[j].name == aop[5].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_5", nuser)
			end
			--[[
			--new entry
			if aop[j].name == aop[5].name then
				vRP:triggerEvent("remove_aop_1","remove_aop_2","remove_aop_3","remove_aop_4","remove_aop_5", nuser)
				vRP:triggerEvent("set_aop_5", nuser)
			end
			--]]
		else 
			vRP.EXT.Base.remote._notify(nuser.source,self.lang.auto_aop.off())
		end
	end
	if self.cfg.auto then
		Wait(60000*self.cfg.refresh)
		for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
			vRP:triggerEvent("auto_aop", nuser)
		end
	end
end

--sets the locations
function AOP.event:set_aop_1()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[1].pos)
	local ment = clone(self.cfg.entity_1)
	ment[2].title = self.lang.set.map_title({aop[1].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[1].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[1].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[1].name}))
	end
end
function AOP.event:set_aop_2()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[2].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[2].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[2].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[2].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[2].name}))
	end
end
function AOP.event:set_aop_3()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[3].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[3].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[3].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[3].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[3].name}))
	end
end
function AOP.event:set_aop_4()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[4].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[4].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[4].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[4].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[4].name}))
	end
end
function AOP.event:set_aop_5()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[5].pos)
	local ment = clone(self.cfg.entity_1)
	ment[2].title = self.lang.set.map_title({aop[5].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[5].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[5].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[5].name}))
	end
end
--new entry
--[[
function AOP.event:set_aop_6()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[6].pos)
	local ment = clone(self.cfg.entity_2)							--change to entity_1 for no blimp
	ment[2].title = self.lang.set.map_title({aop[6].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._setEntity(nuser.source, "vRP:Aop:"..aop[6].name, ment[1], ment[2])
		vRP.EXT.Audio.remote._playAudioSource(-1, vRP.EXT.Phone.cfg.sms_sound, 0.5, 0,0,0, 30, nuser.source)
		vRP.EXT.Base.remote._notify(nuser.source,self.lang.set.pos_set({aop[6].name}))
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.aop({self.cfg.aop[6].name}))
	end
end
--]]

--removes all locations
function AOP.event:remove_aop_1()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[1].pos)
	local ment = clone(self.cfg.entity_1)
	ment[2].title = self.lang.set.map_title({aop[1].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[1].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end
function AOP.event:remove_aop_2()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[2].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[2].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[2].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end
function AOP.event:remove_aop_3()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[3].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[3].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[3].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end
function AOP.event:remove_aop_4()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[4].pos)
	local ment = clone(self.cfg.entity_2)
	ment[2].title = self.lang.set.map_title({aop[4].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[4].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end
function AOP.event:remove_aop_5()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[5].pos)
	local ment = clone(self.cfg.entity_1)
	ment[2].title = self.lang.set.map_title({aop[5].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[5].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end

--new entry
--[[
function AOP.event:remove_aop_6()
	local aop = self.cfg.aop
	local x,y,z = table.unpack(aop[6].pos)
	local ment = clone(self.cfg.entity_1)
	ment[2].title = self.lang.set.map_title({aop[6].name})
	ment[2].pos = {x,y,z-1}
	for _,nuser in pairs(vRP.EXT.Group:getUsersByPermission(self.cfg.nuser)) do
		vRP.EXT.Map.remote._removeEntity(nuser.source, "vRP:Aop:"..aop[6].name, ment[1], ment[2])
		vRP.EXT.GUI.remote._setDiv(nuser.source,"aop",self.cfg.display_css,self.lang.aop.none())
	end
end
--]]

AOP.tunnel = {}

AOP.tunnel.toggleSetaop = AOP.toggleSetaop
	
vRP:registerExtension(AOP)
