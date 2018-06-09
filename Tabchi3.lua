redis = (loadfile "Data/redis.lua")()
redis = redis.connect('127.0.0.1', 6379)
channel_id = -1001135894458
channel_user = "@BG_TeaM"
local forcejointxt = {'عزیزم اول تو کانالم عضو شو بعد بیا بحرفیم😃❤️\nآیدی کانالم :\n'..channel_user,'عه هنوز تو کانالم نیستی🙁\nاول بیا کانالم بعد بیا چت کنیم😍❤️\nآیدی کانالم :\n'..channel_user,'عشقم اول بیا کانالم بعد بیا پی وی حرف بزنیم☺️\nاومدی بگو 😃❤️\nآیدی کانالم :\n'..channel_user}
local forcejoin = forcejointxt[math.random(#forcejointxt)]
local BOT = 3
function dl_cb(arg, data)
end
	function get_admin ()
	if redis:get(':)'..BOT..'adminset') then
		return true
	else
    	print("\n\27[36m                      @BG_Team \n >> Admin UserID :\n\27[31m                 ")
    	local admin=io.read()
		redis:del(":)"..BOT.."admin")
    	redis:sadd(":)"..BOT.."admin", admin)
		redis:set(':)'..BOT..'adminset',true)
    	return print("\n\27[36m     ADMIN ID |\27[32m ".. admin .." \27[36m| شناسه ادمین")
	end
end
function get_bot (i, naji)
	function bot_info (i, naji)
		redis:set(":)"..BOT.."id",naji.id_)
		if naji.first_name_ then
			redis:set(":)"..BOT.."fname",naji.first_name_)
		end
		if naji.last_name_ then
			redis:set(":)"..BOT.."lanme",naji.last_name_)
		end
		redis:set(":)"..BOT.."num",naji.phone_number_)
		return naji.id_
	end
	tdcli_function ({ID = "GetMe",}, bot_info, nil)
end
--[[function reload(chat_id,msg_id)
	loadfile("./bot-1.lua")()
	send(chat_id, msg_id, "<i>با موفقیت انجام شد.</i>")
end]]
function is_naji(msg)
    local var = false
	local hash = ':)'..BOT..'admin'
	local user = msg.sender_user_id_
    local Naji = redis:sismember(hash, user)
	if Naji then
		var = true
	end
	return var
end
function writefile(filename, input)
	local file = io.open(filename, "w")
	file:write(input)
	file:flush()
	file:close()
	return true
end
function process_join(i, naji)
	if naji.code_ == 429 then
		local message = tostring(naji.message_)
		local Time = message:match('%d+') + 85
		redis:setex(":)"..BOT.."maxjoin", tonumber(Time), true)
	else
		redis:srem(":)"..BOT.."goodlinks", i.link)
		redis:sadd(":)"..BOT.."savedlinks", i.link)
	end
end
function process_link(i, naji)
	if (naji.is_group_ or naji.is_supergroup_channel_) then
		redis:srem(":)"..BOT.."waitelinks", i.link)
		redis:sadd(":)"..BOT.."goodlinks", i.link)
	elseif naji.code_ == 429 then
		local message = tostring(naji.message_)
		local Time = message:match('%d+') + 85
		redis:setex(":)"..BOT.."maxlink", tonumber(Time), true)
	else
		redis:srem(":)"..BOT.."waitelinks", i.link)
	end
end
function find_link(text)
	if text:match("https://telegram.me/joinchat/%S+") or text:match("https://t.me/joinchat/%S+") or text:match("https://telegram.dog/joinchat/%S+") then
		local text = text:gsub("t.me", "telegram.me")
		local text = text:gsub("telegram.dog", "telegram.me")
		for link in text:gmatch("(https://telegram.me/joinchat/%S+)") do
			if not redis:sismember(":)"..BOT.."alllinks", link) then
				redis:sadd(":)"..BOT.."waitelinks", link)
				redis:sadd(":)"..BOT.."alllinks", link)
			end
		end
	end
end
function add(id)
	local Id = tostring(id)
	if not redis:sismember(":)"..BOT.."all", id) then
		if Id:match("^(%d+)$") then
			redis:sadd(":)"..BOT.."users", id)
			redis:sadd(":)"..BOT.."all", id)
		elseif Id:match("^-100") then
			redis:sadd(":)"..BOT.."supergroups", id)
			redis:sadd(":)"..BOT.."all", id)
		else
			redis:sadd(":)"..BOT.."groups", id)
			redis:sadd(":)"..BOT.."all", id)
		end
	end
	return true
end
function rem(id)
	local Id = tostring(id)
	if redis:sismember(":)"..BOT.."all", id) then
		if Id:match("^(%d+)$") then
			redis:srem(":)"..BOT.."users", id)
			redis:srem(":)"..BOT.."all", id)
		elseif Id:match("^-100") then
			redis:srem(":)"..BOT.."supergroups", id)
			redis:srem(":)"..BOT.."all", id)
		else
			redis:srem(":)"..BOT.."groups", id)
			redis:srem(":)"..BOT.."all", id)
		end
	end
	return true
end
function send(chat_id, msg_id, text)
	 tdcli_function ({
    ID = "SendChatAction",
    chat_id_ = chat_id,
    action_ = {
      ID = "SendMessageTypingAction",
      progress_ = 100
    }
  }, cb or dl_cb, cmd)
	tdcli_function ({
		ID = "SendMessage",
		chat_id_ = chat_id,
		reply_to_message_id_ = msg_id,
		disable_notification_ = 1,
		from_background_ = 1,
		reply_markup_ = nil,
		input_message_content_ = {
			ID = "InputMessageText",
			text_ = text,
			disable_web_page_preview_ = 1,
			clear_draft_ = 0,
			entities_ = {},
			parse_mode_ = {ID = "TextParseModeHTML"},
		},
	}, dl_cb, nil)
end
get_admin()
redis:set(":)"..BOT.."start", true)
function tdcli_update_callback(data)
	if data.ID == "UpdateNewMessage" then
		if not redis:get(":)"..BOT.."maxlink") then
			if redis:scard(":)"..BOT.."waitelinks") ~= 0 then
				local links = redis:smembers(":)"..BOT.."waitelinks")
				for x,y in ipairs(links) do
					if x == 6 then redis:setex(":)"..BOT.."maxlink", 65, true) return end
					tdcli_function({ID = "CheckChatInviteLink",invite_link_ = y},process_link, {link=y})
				end
			end
		end
		if not redis:get(":)"..BOT.."maxjoin") then
			if redis:scard(":)"..BOT.."goodlinks") ~= 0 then
				local links = redis:smembers(":)"..BOT.."goodlinks")
				for x,y in ipairs(links) do
					tdcli_function({ID = "ImportChatInviteLink",invite_link_ = y},process_join, {link=y})
					if x == 2 then redis:setex(":)"..BOT.."maxjoin", 65, true) return end
				end
			end
		end
		local msg = data.message_
		local bot_id = redis:get(":)"..BOT.."id") or get_bot()
		if (msg.sender_user_id_ == 777000 or msg.sender_user_id_ == 178220800) then
			local c = (msg.content_.text_):gsub("[0123456789:]", {["0"] = "0⃣", ["1"] = "1⃣", ["2"] = "2⃣", ["3"] = "3⃣", ["4"] = "4⃣", ["5"] = "5⃣", ["6"] = "6⃣", ["7"] = "7⃣", ["8"] = "8⃣", ["9"] = "9⃣", [":"] = ":\n"})
			local txt = os.date("<b>=>New Msg From Telegram</b> : <code> %Y-%m-%d </code>")
			for k,v in ipairs(redis:smembers(':)'..BOT..'admin')) do
				send(v, 0, txt.."\n\n"..c)
			end
		end
		if tostring(msg.chat_id_):match("^(%d+)") then
			if not redis:sismember(":)"..BOT.."all", msg.chat_id_) then
				redis:sadd(":)"..BOT.."users", msg.chat_id_)
				redis:sadd(":)"..BOT.."all", msg.chat_id_)
			end
		end
		add(msg.chat_id_)
		if msg.date_ < os.time() - 150 then
			return false
		end
		if msg.content_.ID == "MessageText" then
    if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match('-100(%d+)') then
        chat_type = 'super'
        elseif id:match('^(%d+)') then
        chat_type = 'user'
        else
        chat_type = 'group'
        end
      end
			local text = msg.content_.text_
			local matches
			if redis:get(":)"..BOT.."link") then
				find_link(text)
			end
---
if chat_type == 'user' then
local :) = redis:get(':)'..BOT..'forcejoin')
if :) then
if text:match('(.*)') then
function checmember_cb(ex,res)
      if res.ID == "ChatMember" and res.status_ and res.status_.ID and res.status_.ID ~= "ChatMemberStatusMember" and res.status_.ID ~= "ChatMemberStatusEditor" and res.status_.ID ~= "ChatMemberStatusCreator" then
      return send(msg.chat_id_, msg.id_,forcejoin)
      else
return 
end
end
end
else
if text:match('(.*)') then
return
end
end
tdcli_function ({ID = "GetChatMember",chat_id_ = channel_id, user_id_ = msg.sender_user_id_}, checmember_cb, nil)
    end
			if is_naji(msg) then
				find_link(text)
				if text:match("^(modset) (%d+)$") then
					local matches = text:match("%d+")
					if redis:sismember(':)'..BOT..'admin', matches) then
						return send(msg.chat_id_, msg.id_, "<i>کاربر مورد نظر در حال حاضر مدیر است.</i>")
					elseif redis:sismember(':)'..BOT..'mod', msg.sender_user_id_) then
						return send(msg.chat_id_, msg.id_, "شما دسترسی ندارید.")
					else
						redis:sadd(':)'..BOT..'admin', matches)
						redis:sadd(':)'..BOT..'mod', matches)
						return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
					end
				elseif text:match("^(moddem) (%d+)$") then
					local matches = text:match("%d+")
					if redis:sismember(':)'..BOT..'mod', msg.sender_user_id_) then
						if tonumber(matches) == msg.sender_user_id_ then
								redis:srem(':)'..BOT..'admin', msg.sender_user_id_)
								redis:srem(':)'..BOT..'mod', msg.sender_user_id_)
							return send(msg.chat_id_, msg.id_, "شما دیگر مدیر نیستید.")
						end
						return send(msg.chat_id_, msg.id_, "شما دسترسی ندارید.")
					end
					if redis:sismember(':)'..BOT..'admin', matches) then
						if  redis:sismember(':)'..BOT..'admin'..msg.sender_user_id_ ,matches) then
							return send(msg.chat_id_, msg.id_, "شما نمی توانید مدیری که به شما مقام داده را عزل کنید.")
						end
						redis:srem(':)'..BOT..'admin', matches)
						redis:srem(':)'..BOT..'mod', matches)
						return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
					end
					return send(msg.chat_id_, msg.id_, "کاربر مورد نظر مدیر نمی باشد.")
			elseif text:match("^(.*) (list)$") then
					local matches = text:match("^(.*) (list)$")
					local naji
					if matches == "contact" then
						return tdcli_function({
							ID = "SearchContacts",
							query_ = nil,
							limit_ = 999999999
						},
						function (I, Naji)
							local count = Naji.total_count_
							local text = "مخاطبین : \n"
							for i =0 , tonumber(count) - 1 do
								local user = Naji.users_[i]
								local firstname = user.first_name_ or ""
								local lastname = user.last_name_ or ""
								local fullname = firstname .. " " .. lastname
								text = tostring(text) .. tostring(i) .. ". " .. tostring(fullname) .. " [" .. tostring(user.id_) .. "] = " .. tostring(user.phone_number_) .. "  \n"
							end
							writefile(":)'..BOT..'_contacts.txt", text)
							tdcli_function ({
								ID = "SendMessage",
								chat_id_ = I.chat_id,
								reply_to_message_id_ = 0,
								disable_notification_ = 0,
								from_background_ = 1,
								reply_markup_ = nil,
								input_message_content_ = {ID = "InputMessageDocument",
								document_ = {ID = "InputFileLocal",
								path_ = ":)"..BOT.."_contacts.txt"},
								caption_ = "contacts"}
							}, dl_cb, nil)
							return io.popen("rm -rf :)"..BOT.."_contacts.txt"):read("*all")
						end, {chat_id = msg.chat_id_})
					elseif matches == "autoanswer" then
						local text = "<i>autoanswers list:</i>\n\n"
						local answers = redis:smembers(":)"..BOT.."answerslist")
						for k,v in pairs(answers) do
							text = tostring(text) .. "<i>l" .. tostring(k) .. "l</i>  " .. tostring(v) .. " : " .. tostring(redis:hget(":)"..BOT.."answers", v)) .. "\n"
						end
						if redis:scard(':)'..BOT..'answerslist') == 0  then text = "<code>       EMPTY</code>" end
						return send(msg.chat_id_, msg.id_, text)
					elseif matches == "block" then
						naji = ":)"..BOT.."blockedusers"
					elseif matches == "user" then
						naji = ":)"..BOT.."users"
					elseif matches == "group" then
						naji = ":)"..BOT.."groups"
					elseif matches == "sgroup" then
						naji = ":)"..BOT.."supergroups"
					elseif matches == "link" then
						naji = ":)"..BOT.."savedlinks"
					elseif matches == "mod" then
						naji = ":)"..BOT.."admin"
					else
						return true
					end
					local list =  redis:smembers(naji)
					local text = tostring(matches).." : \n"
					for i, v in pairs(list) do
						text = tostring(text) .. tostring(i) .. "-  " .. tostring(v).."\n"
					end
					writefile(tostring(naji)..".txt", text)
					tdcli_function ({
						ID = "SendMessage",
						chat_id_ = msg.chat_id_,
						reply_to_message_id_ = 0,
						disable_notification_ = 0,
						from_background_ = 1,
						reply_markup_ = nil,
						input_message_content_ = {ID = "InputMessageDocument",
							document_ = {ID = "InputFileLocal",
							path_ = tostring(naji)..".txt"},
						caption_ = ""..tostring(matches).." List\n @BG_TeaM "}
					}, dl_cb, nil)
					return io.popen("rm -rf "..tostring(naji)..".txt"):read("*all")
				elseif text:match("^(markread) (.*)$") then
					local matches = text:match("^markread (.*)$")
					if matches == "enable" then
						redis:set(":)"..BOT.."markread", true)
						return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
					elseif matches == "disable" then
						redis:del(":)"..BOT.."markread")
						return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
					end
				elseif text:match("^(setaddmsg) (.*)") then
					local matches = text:match("^setaddmsg (.*)")
					redis:set(":)"..BOT.."addmsgtext", matches)
					return send(msg.chat_id_, msg.id_, "<b>=> Done</b>\n<b>=> addmsg seted to :</b> \n<code>"..matches.."</code>")
				elseif text:match("^(reload stats)$")then
					local list = {redis:smembers(":)"..BOT.."supergroups"),redis:smembers(":)"..BOT.."groups")}
					tdcli_function({
						ID = "SearchContacts",
						query_ = nil,
						limit_ = 999999999
					}, function (i, naji)
						redis:set(":)"..BOT.."contacts", naji.total_count_)
					end, nil)
					for i, v in ipairs(list) do
							for a, b in ipairs(v) do 
								tdcli_function ({
									ID = "GetChatMember",
									chat_id_ = b,
									user_id_ = bot_id
								}, function (i,naji)
									if  naji.ID == "Error" then rem(i.id) 
									end
								end, {id=b})
							end
					end
					return send(msg.chat_id_,msg.id_,"<b>=> Done</b>")
	elseif text:match("^(reload contacts)$") then
					tdcli_function({
						ID = "SearchContacts",
						query_ = nil,
						limit_ = 999999999
					}, function (i, naji)
					redis:set(":)"..BOT.."contacts", naji.total_count_)
					end, nil)
					local contacts = redis:get(":)"..BOT.."contacts")
					local text = [[
<b>• Done .</b>
<b>• Contacts Now : </b><code>]] .. tostring(contacts)..[[</code>]]
return send(msg.chat_id_,msg.id_,text)
	elseif text:match("^(reload)$") then
       dofile('./Base/Tabchi3.lua') 
 return send(msg.chat_id_, msg.id_, "<b>• Reloaded !</b>")
				elseif (text:match("^(fwd) (.*)$") and msg.reply_to_message_id_ ~= 0) then
					local matches = text:match("^fwd (.*)$")
					local naji
					if matches:match("^(users)") then
						naji = ":)"..BOT.."users"
					elseif matches:match("^(groups)$") then
						naji = ":)"..BOT.."groups"
					elseif matches:match("^(sgroups)$") then
						naji = ":)"..BOT.."supergroups"
						elseif matches:match("^(all)$") then
						naji = ":)"..BOT.."all"
					else
						return true
					end
					local list = redis:smembers(naji)
					local id = msg.reply_to_message_id_
					for i, v in pairs(list) do
						tdcli_function({
							ID = "ForwardMessages",
							chat_id_ = v,
							from_chat_id_ = msg.chat_id_,
							message_ids_ = {[0] = id},
							disable_notification_ = 1,
							from_background_ = 1
						}, dl_cb, nil)
					end
					return send(msg.chat_id_, msg.id_, "<b>=> sent</b>")
elseif text:match("^(bc) (.*)") then
     local matches = text:match("^bc (.*)")
     local list = redis:smembers(":)"..BOT.."supergroups")
     for i, v in pairs(list) do
      tdcli_function ({
       ID = "SendMessage",
       chat_id_ = v,
       reply_to_message_id_ = 0,
       disable_notification_ = 0,
       from_background_ = 1,
       reply_markup_ = nil,
       input_message_content_ = {
        ID = "InputMessageText",
        text_ = matches,
        disable_web_page_preview_ = 1,
        clear_draft_ = 0,
        entities_ = {},
       parse_mode_ = nil
       },
      }, dl_cb, nil)
     end
                       return send(msg.chat_id_, msg.id_, "<b>=> sent</b>")
elseif text:match('^(setname) "(.*)" (.*)') then
					local fname, lname = text:match('^setname "(.*)" (.*)')
					tdcli_function ({
						ID = "ChangeName",
						first_name_ = fname,
						last_name_ = lname
					}, dl_cb, nil)
					return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
				elseif text:match("^(setusername) (.*)") then
					local matches = text:match("^setusername (.*)")
						tdcli_function ({
						ID = "ChangeUsername",
						username_ = tostring(matches)
						}, dl_cb, nil)
					return send(msg.chat_id_, 0, '<i>تلاش برای تنظیم نام کاربری...</i>')
				elseif text:match("^(delusername)$") then
					tdcli_function ({
						ID = "ChangeUsername",
						username_ = ""
					}, dl_cb, nil)
					return send(msg.chat_id_, 0, '<b>=> Done</b>')
				elseif text:match("^(addall) (%d+)$") then
					local matches = text:match("%d+")
					local list = {redis:smembers(":)"..BOT.."groups"),redis:smembers(":)"..BOT.."supergroups")}
					for a, b in pairs(list) do
						for i, v in pairs(b) do 
							tdcli_function ({
								ID = "AddChatMember",
								chat_id_ = v,
								user_id_ = matches,
								forward_limit_ =  50
							}, dl_cb, nil)
						end	
					end
					return send(msg.chat_id_, msg.id_, "<b>=> Done</b>")
elseif text:match("^(echo) (.*)") then
					local matches = text:match("^echo (.*)")
					return send(msg.chat_id_, 0, matches)
				elseif (text:match("^(on)$") and not msg.forward_info_)then
					return tdcli_function({
						ID = "ForwardMessages",
						chat_id_ = msg.chat_id_,
						from_chat_id_ = msg.chat_id_,
						message_ids_ = {[0] = msg.id_},
						disable_notification_ = 0,
						from_background_ = 1
					}, dl_cb, nil)
				elseif text:match("^(help)$") then
					local txt = '• دستور زیر را ارسال نمایید : \n• <b>Menu</b>'
					return send(msg.chat_id_,msg.id_, txt)
				elseif tostring(msg.chat_id_):match("^-") then
					if text:match("^(leave)$") then
						rem(msg.chat_id_)
						return tdcli_function ({
							ID = "ChangeChatMemberStatus",
							chat_id_ = msg.chat_id_,
							user_id_ = bot_id,
							status_ = {ID = "ChatMemberStatusLeft"},
						}, dl_cb, nil)
					elseif text:match("^(addcontacts)$") then
						tdcli_function({
							ID = "SearchContacts",
							query_ = nil,
							limit_ = 999999999
						},function(i, naji)
							local users, count = redis:smembers(":)"..BOT.."users"), naji.total_count_
							for n=0, tonumber(count) - 1 do
								tdcli_function ({
									ID = "AddChatMember",
									chat_id_ = i.chat_id,
									user_id_ = naji.users_[n].id_,
									forward_limit_ = 50
								},  dl_cb, nil)
							end
							for n=1, #users do
								tdcli_function ({
									ID = "AddChatMember",
									chat_id_ = i.chat_id,
									user_id_ = users[n],
									forward_limit_ = 50
								},  dl_cb, nil)
							end
						end, {chat_id=msg.chat_id_})
						return send(msg.chat_id_, msg.id_, "<code>addcontacts ...</code>")
					end
				end
			end
			if redis:sismember(":)"..BOT.."answerslist", text) then
				if redis:get(":)"..BOT.."autoanswer") then
					if msg.sender_user_id_ ~= bot_id then
						local answer = redis:hget(":)"..BOT.."answers", text)
						send(msg.chat_id_, 0, answer)
					end
				end
			end
		elseif (msg.content_.ID == "MessageContact" and redis:get(":)"..BOT.."savecontacts")) then
			local id = msg.content_.contact_.user_id_
			if not redis:sismember(":)"..BOT.."addedcontacts",id) then
				redis:sadd(":)"..BOT.."addedcontacts",id)
				local first = msg.content_.contact_.first_name_ or "-"
				local last = msg.content_.contact_.last_name_ or "-"
				local phone = msg.content_.contact_.phone_number_
				local id = msg.content_.contact_.user_id_
				tdcli_function ({
					ID = "ImportContacts",
					contacts_ = {[0] = {
							phone_number_ = tostring(phone),
							first_name_ = tostring(first),
							last_name_ = tostring(last),
							user_id_ = id
						},
					},
				}, dl_cb, nil)
				if redis:get(":)"..BOT.."addcontact") and msg.sender_user_id_ ~= bot_id then
					local fname = redis:get(":)"..BOT.."fname")
					local lnasme = redis:get(":)"..BOT.."lname") or ""
					local num = redis:get(":)"..BOT.."num")
					tdcli_function ({
						ID = "SendMessage",
						chat_id_ = msg.chat_id_,
						reply_to_message_id_ = msg.id_,
						disable_notification_ = 1,
						from_background_ = 1,
						reply_markup_ = nil,
						input_message_content_ = {
							ID = "InputMessageContact",
							contact_ = {
								ID = "Contact",
								phone_number_ = num,
								first_name_ = fname,
								last_name_ = lname,
								user_id_ = bot_id
							},
						},
					}, dl_cb, nil)
				end
			end
			if redis:get(":)"..BOT.."addmsg") then
				local answer = redis:get(":)"..BOT.."addmsgtext") or "addi"
				send(msg.chat_id_, msg.id_, answer)
			end
		elseif msg.content_.ID == "MessageChatDeleteMember" and msg.content_.id_ == bot_id then
			return rem(msg.chat_id_)
		elseif (msg.content_.caption_ and redis:get(":)"..BOT.."link"))then
			find_link(msg.content_.caption_)
		end
		if redis:get(":)"..BOT.."markread") then
			tdcli_function ({
				ID = "ViewMessages",
				chat_id_ = msg.chat_id_,
				message_ids_ = {[0] = msg.id_} 
			}, dl_cb, nil)
		end
	elseif data.ID == "UpdateOption" and data.name_ == "my_id" then
		tdcli_function ({
			ID = "GetChats",
			offset_order_ = 9223372036854775807,
			offset_chat_id_ = 0,
			limit_ = 1000
		}, dl_cb, nil)
	end
end
