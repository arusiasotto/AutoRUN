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
	
_addon.name = 'Rune Master'
_addon.author = 'Arusia von Sotto'
_addon.version = '0.1'
_addon.language = 'english'
_addon.command = 'ar'

files = require('files')
chat = require('chat')
texts = require('texts')
images = require('images')
tables = require('tables')
res = require('resources')
logger = require('logger')
packets=require('packets')
require 'sets'
require 'strings'
require 'actions'
require 'pack'

----------------------------------------------------------------------------------------------
-- Function : inRunes
--
-- Checks if the entered value is a rune. Returns boolean.
----------------------------------------------------------------------------------------------
function inRunes(val)
    runeArr = {'ignis', 'gelus', 'flabra', 'tellus', 'sulpor', 'unda', 'lux', 'tenebrae'}

    for index, value in ipairs(runeArr) do
        if value == val then
            return true
        end
    end

    return false
end

----------------------------------------------------------------------------------------------
-- Function : setRunes
--
-- Set desired runes.
----------------------------------------------------------------------------------------------
function set_Runes(arg1, arg2, arg3)
    setRunes = {}

    if arg1 then
	    if inRunes(arg1:lower()) then
	    	if setRunes[arg1:lower()] == nil then
	    		setRunes[arg1:lower()] = 1
	    	else
	        	setRunes[arg1:lower()] = setRunes[arg1:lower()] + 1
	        end
	    else
	        windower.add_to_chat(2, arg1 ..' is not a valid rune.')
	    end
	else
		windower.add_to_chat(2, 'Arg1 is null.')
	end

	if arg2 then
	    if inRunes(arg2:lower()) then 
	    	if setRunes[arg2:lower()] == nil then
	    		setRunes[arg2:lower()] = 1
	    	else
	        	setRunes[arg2:lower()] = setRunes[arg2:lower()] + 1
	    	end
	    else
	        windower.add_to_chat(2, arg2 ..' is not a valid rune.')
	    end
	else
		windower.add_to_chat(2, 'Arg2 is null.')
	end

	if arg3 then
	    if inRunes(arg3:lower()) then
	    	if setRunes[arg3:lower()] == nil then
	    		setRunes[arg3:lower()] = 1
	    	else
	       		setRunes[arg3:lower()] = setRunes[arg3:lower()] + 1
	    	end
	    else
	        windower.add_to_chat(2, arg3 ..' is not a valid rune.')
	    end
	else
		windower.add_to_chat(2, 'Arg3 is null.')
	end	

end

function activeBuffs()
    buffs = {}
    activeRunes = {}
    
    for i,v in ipairs(windower.ffxi.get_player().buffs) do
    	if v == 523 then
    		if activeRunes['ignis'] == nil then
    			activeRunes['ignis'] = 1
    		else
				activeRunes['ignis'] = activeRunes['ignis'] + 1
			end
		elseif v == 524 then
			if activeRunes['gelus'] == nil then
				activeRunes['gelus'] = 1
			else 
				activeRunes['gelus'] = activeRunes['gelus'] + 1 
			end
		elseif v == 525 then 
			if activeRunes['flabra'] == nil then
				activeRunes['flabra'] = 1
			else
				activeRunes['flabra'] = activeRunes['flabra'] + 1
			end
		elseif v == 526 then
			if activeRunes['tellus'] == nil then
				activeRunes['tellus'] = 1
			else	 
				activeRunes['tellus'] = activeRunes['tellus'] + 1
			end 		
		elseif v == 527 then 
			if activeRunes['sulpor'] == nil then
				activeRunes['sulpor'] = 1
			else
				activeRunes['sulpor'] = activeRunes['sulpor'] + 1 
			end
		elseif v == 528 then
			if activeRunes['unda'] == nil then
				activeRunes['unda'] = 1
			else 	
				activeRunes['unda'] = activeRunes['unda'] + 1
			end
		elseif v == 529 then
			if activeRunes['lux'] == nil then
				activeRunes['lux'] = 1
			else 
				activeRunes['lux'] = activeRunes['lux'] + 1
			end
		elseif v == 530 then
			if activeRunes['tenebrae'] == nil then
				activeRunes['tenebrae'] = 1
			else
				activeRunes['tenebrae'] = activeRunes['tenebrae'] + 1 
			end
		else
            buffs[res.buffs[v].english:lower()] = (buffs[res.buffs[v].english:lower()] or 0) + 1
        end
    end

    if buffs.sleep or buffs.petrification or buffs.stun or 
        buffs.charm or buffs.amnesia or buffs.terror or 
            buffs.lullaby or buffs.impairment then
        incapacitated = true
    else
        incapacitated = false
    end	
end

function compare_buffs()

	runeArr = {'ignis', 'gelus', 'flabra', 'tellus', 'sulpor', 'unda', 'lux', 'tenebrae'}
	
	for index, value in ipairs(runeArr) do
		if setRunes[value] ~= nil then
			if setRunes[value] > 0 and activeRunes[value] == nil then
				autoJA(value, '<me>')
	        elseif activeRunes[value] ~= nil then
	        	if activeRunes[value] < setRunes[value] then
	            	autoJA(value, '<me>')
	            end
	        end
	    end
    end
end	

function autoJA(str,ta)
    windower.send_command('input /ja "%s" %s':format(str,ta))
end 

windower.register_event('load', function()
	incapacitated = false
	setRunes = {}
	addon_active=false
	acting=false
	player_id = windower.ffxi.get_player().id
end)

windower.register_event('prerender', function()

	if enableAddon then
		local recast = windower.ffxi.get_ability_recasts()
		activeBuffs()

		if not incapacitated and recast[92] == 0 and not acting then
			compare_buffs()
		end
	end
end)

windower.register_event('hp change', function(hp1,hp2)
	if hp1==0 then 
		enableAddon=false
		windower.add_to_chat(2, 'He is dead Jim, Stopping')
	end
end)

windower.register_event('addon command', function(command, arg1, arg2, arg3)
	if command:lower() == 'start' then
		windower.add_to_chat(2, 'AutoRUN: Started')
		enableAddon=true
	end
	if command:lower() == 'set' then
		set_Runes(arg1,arg2,arg3)
	end
	if command:lower() == 'stop' then
		windower.add_to_chat(2, 'AutoRUN: Stopped')
		enableAddon=false
	end
	if command:lower() == 'help' then
		windower.add_to_chat(2, 'There is no help for you.')
		windower.add_to_chat(2, 'Use //ar set rune1 rune2 rune3')
	end	
end)	

windower.register_event('action', function(act)
if act.actor_id == player_id then
	if (act.category > 5 and act.category < 10) or (act.category > 11) then
		if act.category==06 then
			acting=true
			coroutine.sleep(1)
			acting=false
		else acting=true
		end
	end
	if act.category > 1 and act.category < 6 then
		acting=false
	end	
end
end)
