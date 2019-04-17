--[[
Copyright © 2019, Arusia von Sotto
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Rune Mater nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Arusia von Sotto BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]
--[[Psuedocode

variables
	Rune1
	Rune2
	Rune3
	
function(setRunes)=arg1,arg2,ar3
	sets variables to for Runes rune1-3
	
function(checkRunes)
	Checks if rune1-3 are active
	
function(castRunes)
	casts missing runes
	
]]
	
_addon.name = 'Rune Master'
_addon.author = 'Arusia von Sotto'
_addon.version = '0.1'
_addon.language = 'english'
_addon.command = 'rnmstr'

files = require('files')
chat = require('chat')
texts = require('texts')
images = require('images')
tables = require('tables')
resources = require('resources')
logger = require('logger')
packets=require('packets')
require 'sets'
require 'strings'
require 'actions'
require 'pack'

windower.register_event('load', function()
buff1=0
buff2=0
buff3=0
WantedBuffs = {}
WantedBuffs['Ignis'] = 0 
WantedBuffs['Gelus'] = 0 
WantedBuffs['Flabra'] = 0 
WantedBuffs['Tellus'] = 0 
WantedBuffs['Sulpor'] = 0 
WantedBuffs['Unda'] = 0 
WantedBuffs['Lux'] = 0 
WantedBuffs['Tenebrae']=0 
addon_active=false
end)

function set_buffs(arg1,arg2,arg3)
	WantedBuffs['Ignis'] = 0 
	WantedBuffs['Gelus'] = 0 
	WantedBuffs['Flabra'] = 0 
	WantedBuffs['Tellus'] = 0 
	WantedBuffs['Sulpor'] = 0 
	WantedBuffs['Unda'] = 0 
	WantedBuffs['Lux'] = 0 
	WantedBuffs['Tenebrae']=0 
	buff1=0
	buff_name1= arg1
	buff2=0
	buff_name2= arg2
	buff3=0
	buff_name3= arg3
	if arg1 == 'Ignis' or arg1== 'ignis' then 
		WantedBuffs['Ignis']=WantedBuffs['Ignis']+1
		buff1=1
		elseif arg1 == 'Gelus' or arg1 == 'gelus' then 
		WantedBuffs['Gelus']=WantedBuffs['Gelus']+1
		buff1=1
		elseif arg1 == 'Flabra' or arg1 == 'flabra' then 
		WantedBuffs['Flabra']=WantedBuffs['Flabra']+1
		buff1=1
		elseif arg1 == 'Tellus' or arg1 == 'tellus' then 
		WantedBuffs['Tellus']=WantedBuffs['Tellus']+1
		buff1=1
		elseif arg1 == 'Sulpor' or arg1 == 'sulpor' then 
		WantedBuffs['Sulpor']=WantedBuffs['Sulpor']+1
		buff1=1
		elseif arg1 == 'Unda' or arg1 == 'unda' then 
		WantedBuffs['Unda']=WantedBuffs['Unda']+1	
		buff1=1
		elseif arg1 == 'Lux' or arg1 == 'lux' then 
		WantedBuffs['Lux']=WantedBuffs['Lux']+1
		buff1=1
		elseif arg1 == 'Tenebrae' or arg1 == 'tenebrae' then 
		WantedBuffs['Tenebrae']=WantedBuffs['Tenebrae']+1
		buff1=1
		elseif arg1 == nil then windower.add_to_chat(2, 'First Rune not set!')
		else windower.add_to_chat(2, arg1 ..' is not a valid rune.')
	end
	if arg2 == 'Ignis' or arg2== 'ignis' then 
	WantedBuffs['Ignis']=WantedBuffs['Ignis']+1
		buff2=1
		elseif arg2 == 'Gelus' or arg2 == 'gelus' then 
		WantedBuffs['Gelus']=WantedBuffs['Gelus']+1
		buff2=1
		elseif arg2 == 'Flabra' or arg2 == 'flabra' then 
		WantedBuffs['Flabra']=WantedBuffs['Flabra']+1
		buff2=1
		elseif arg2 == 'Tellus' or arg2 == 'tellus' then 
		WantedBuffs['Tellus']=WantedBuffs['Tellus']+1
		buff2=1
		elseif arg2 == 'Sulpor' or arg2 == 'sulpor' then 
		WantedBuffs['Sulpor']=WantedBuffs['Sulpor']+1
		buff2=1
		elseif arg2 == 'Unda' or arg2 == 'unda' then 
		WantedBuffs['Unda']=WantedBuffs['Unda']+1	
		buff2=1
		elseif arg2 == 'Lux' or arg2 == 'lux' then 
		WantedBuffs['Lux']=WantedBuffs['Lux']+1
		buff2=1
		elseif arg2 == 'Tenebrae' or arg2 == 'tenebrae' then 
		WantedBuffs['Tenebrae']=WantedBuffs['Tenebrae']+1
		buff2=1
		elseif arg2 == nil then windower.add_to_chat(2, 'Second Rune not set!')
		else windower.add_to_chat(2, arg2 ..' is not a valid rune.')
	end
	if arg3 == 'Ignis' or arg3== 'ignis' then 
	WantedBuffs['Ignis']=WantedBuffs['Ignis']+1
		buff3=1
		elseif arg3 == 'Gelus' or arg3 == 'gelus' then 
		WantedBuffs['Gelus']=WantedBuffs['Gelus']+1
		buff3=1
		elseif arg3 == 'Flabra' or arg3 == 'flabra' then 
		WantedBuffs['Flabra']=WantedBuffs['Flabra']+1
		buff3=1
		elseif arg3 == 'Tellus' or arg3 == 'tellus' then 
		WantedBuffs['Tellus']=WantedBuffs['Tellus']+1
		buff3=1
		elseif arg3 == 'Sulpor' or arg3 == 'sulpor' then 
		WantedBuffs['Sulpor']=WantedBuffs['Sulpor']+1
		buff3=1
		elseif arg3 == 'Unda' or arg3 == 'unda' then 
		WantedBuffs['Unda']=WantedBuffs['Unda']+1	
		buff3=1
		elseif arg3 == 'Lux' or arg3 == 'lux' then 
		WantedBuffs['Lux']=WantedBuffs['Lux']+1
		buff3=1
		elseif arg3 == 'Tenebrae' or arg3 == 'tenebrae' then 
		WantedBuffs['Tenebrae']=WantedBuffs['Tenebrae']+1
		buff3=1
		elseif arg3 == nil then windower.add_to_chat(2, 'Third rune not set!')
		else windower.add_to_chat(2, arg3 ..' is not a valid rune.')
	end
end	

function compare_buffs()
	windower.add_to_chat(2, 'Comparing')
	buff_active()
	if HaveBuffs['Ignis'] ~= WantedBuffs['Ignis'] then
		if HaveBuffs['Ignis'] > WantedBuffs['Ignis'] then 
			windower.add_to_chat(2, 'Too Much Ignis')
		else
			windower.add_to_chat(2, 'Missing Ignis')
		end			
	else 
		if WantedBuffs['Ignis'] ~= 0 then
			windower.add_to_chat(2, 'Have Ignis')
		end
	end
	if HaveBuffs['Gelus'] ~= WantedBuffs['Gelus'] then
		if HaveBuffs['Gelus'] > WantedBuffs['Gelus'] then 
			windower.add_to_chat(2, 'Too Much Gelus')
		else
			windower.add_to_chat(2, 'Missing Gelus')
		end			
	else 
		if WantedBuffs['Ignis'] ~= 0 then
			windower.add_to_chat(2, 'Have Gelus')
		end
	end	
end

function start()
	if buff1 == 0 then
		windower.add_to_chat(2, 'Buffs not set.')
		addon_active=false
	elseif buff2 == 0 then
		windower.add_to_chat(2, 'Buffs not set.')
		addon_active=false
	elseif buff3 == 0 then
		windower.add_to_chat(2, 'Buffs not set.')
		addon_active=false
	else
		addon_active=true
		windower.add_to_chat(2, 'Starting')
		compare_buffs()
	end
end

function stop()
	addon_active=false
end

function buff_active()
	windower.add_to_chat(2, 'Checking Buffs')
	HaveBuffs = {}
	HaveBuffs['Ignis'] = 0 
	HaveBuffs['Gelus'] = 0 
	HaveBuffs['Flabra'] = 0 
	HaveBuffs['Tellus'] = 0 
	HaveBuffs['Sulpor'] = 0 
	HaveBuffs['Unda'] = 0 
	HaveBuffs['Lux'] = 0 
	HaveBuffs['Tenebrae'] = 0 
	buffs = {}
	for i,v in ipairs(windower.ffxi.get_player().buffs) do
		if v == 523 then 
			HaveBuffs['Ignis'] = HaveBuffs['Ignis']+1
		elseif v == 524 then 
			HaveBuffs['Gelus'] = HaveBuffs['Gelus']+1 
		elseif v == 525 then 
			HaveBuffs['Flabra'] = HaveBuffs['Flabra']+1
		elseif v == 526 then 
			HaveBuffs['Tellus'] = HaveBuffs['Tellus']+1 		
		elseif v == 527 then 
			HaveBuffs['Sulpor'] = HaveBuffs['Sulpor']+1 
		elseif v == 528 then 	
			HaveBuffs['Unda'] = HaveBuffs['Unda']+1
		elseif v == 529 then 
			HaveBuffs['Lux'] = HaveBuffs['Lux']+1
		elseif v == 530 then
			HaveBuffs['Tenebrae'] = HaveBuffs['Tenebrae']+1 
		end
	end
end

function autoJA(str,ta)
    windower.send_command('input /ja "%s" %s':format(str,ta))
    --JA_Delay = true
end 

windower.register_event('lose buff', function(buff_id)
	if buff_id >= 523 and buff_id <= 530 then
		if addon_active==true then compare_buffs() end
	end
end)	

windower.register_event('addon command', function(command, arg1, arg2, arg3)
	if command:lower() == 'list' then
		windower.add_to_chat(2, 'Got the buffs.')
	end
	if command:lower() == 'start' then
		start()
	end
	if command:lower() == 'set' then
		set_buffs(arg1,arg2,arg3)
		windower.add_to_chat(2, 'Set the buffs!')
	end
	if command:lower() == 'help' then
		windower.add_to_chat(2, 'There is no help for you.')
	end
	if command:lower() == 'check' then
		buff_active()
		if HaveBuffs['Ignis'] > 0 then windower.add_to_chat(2, 'Ignis x'..HaveBuffs['Ignis'])
		end
		if HaveBuffs['Gelus'] > 0 then windower.add_to_chat(2, 'Gelus x'..HaveBuffs['Gelus'])
		end
		if HaveBuffs['Flabra'] > 0 then windower.add_to_chat(2, 'Flabra x'..HaveBuffs['Flabra'])
		end
		if HaveBuffs['Tellus'] > 0 then windower.add_to_chat(2, 'Tellus x'..HaveBuffs['Tellus'])
		end
		if HaveBuffs['Sulpor'] > 0 then windower.add_to_chat(2, 'Sulpor x'..HaveBuffs['Sulpor'])
		end
		if HaveBuffs['Unda'] > 0 then windower.add_to_chat(2, 'Unda x'..HaveBuffs['Unda'])
		end
		if HaveBuffs['Lux'] > 0 then windower.add_to_chat(2, 'Lux x'..HaveBuffs['Lux'])
		end
		if HaveBuffs['Tenebrae'] > 0 then windower.add_to_chat(2, 'Tenebrae x'..HaveBuffs['Tenebrae'])
		end
	end	
end)	
