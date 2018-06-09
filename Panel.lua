------------------------
-- In The Name Of GoD --
-- Satring Panel.lua  --
--      By :)      --
------------------------
local URL = require "socket.url"
local https = require "ssl.https"
local serpent = require "serpent"
local json = (loadfile "Data/JSON.lua")()
local token = 'token' --token
local url = 'https://api.telegram.org/bot' .. token
local offset = 0
local redis = require('redis')
local redis = redis.connect('127.0.0.1', 6379)
local botcli = 460139006 -- id bot
local SUDO = 304933903 --sudo
local BOT = 1
local BOT2 = 2
local BOT3 = 3
function is_mod(chat,user)
sudo = {}
  local var = false 
  for v,_user in pairs(sudo) do
    if _user == user then
      var = true
    end
  end
  local hash = redis:sismember(':)'..BOT..'mod', user)
 if hash then
 var = true
 end
  local hash = redis:sismember(':)'..BOT..'admin', user)
 if hash then
 var = true
 end
 return var
 end
local function getUpdates()
  local response = {}
  local success, code, headers, status  = https.request{
    url = url .. '/getUpdates?timeout=20&limit=1&offset=' .. offset,
    method = "POST",
    sink = ltn12.sink.table(response),
  }

  local body = table.concat(response or {"no response"})
  if (success == 1) then
    return json:decode(body)
  else
    return nil, "Request Error"
  end
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function sendmsg(chat,text,keyboard)
if keyboard then
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard))
else
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text=' ..URL.escape(text)..'&parse_mode=html'
end
https.request(urlk)
end
 function edit( message_id, text, keyboard)
  local urlk = url .. '/editMessageText?&inline_message_id='..message_id..'&text=' .. URL.escape(text)
    urlk = urlk .. '&parse_mode=Markdown'
  if keyboard then
    urlk = urlk..'&reply_markup='..URL.escape(json:encode(keyboard))
  end
    return https.request(urlk)
  end
function Canswer(callback_query_id, text, show_alert)
	local urlk = url .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)
	if show_alert then
		urlk = urlk..'&show_alert=true'
	end
  https.request(urlk)
	end
  function answer(inline_query_id, query_id , title , description , text , keyboard)
  local results = {{}}
         results[1].id = query_id
         results[1].type = 'article'
         results[1].description = description
         results[1].title = title
         results[1].message_text = text
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  if keyboard then
   results[1].reply_markup = keyboard
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  end
    https.request(urlk)
  end
function fwd(chat_id, from_chat_id, message_id)
  local urlk = url.. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id
  local res, code, desc = https.request(urlk)
  if not res and code then --if the request failed and a code is returned (not 403 and 429)
  end
  return res, code
end
function sleep(n)
os.execute("sleep " .. tonumber(n))
end
local day = 86400
local function run()
  while true do
    local updates = getUpdates()
    vardump(updates)
    if(updates) then
      if (updates.result) then
        for i=1, #updates.result do
          local msg = updates.result[i]
          offset = msg.update_id + 1
          if msg.inline_query then
            local q = msg.inline_query
						if q.from.id == botcli or q.from.id == SUDO then
            if q.query:match('%d+') then
              local chat = '-'..q.query:match('%d+')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
--------Main Menu-------#:)
              local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '• BoT [1]', callback_data = 'firstmenu1:'..chat}
				},{
				{text = '• BoT [2]', callback_data = 'firstxxmenu:'..chat}
		     	},{
		     	{text = '• BoT [3]', callback_data = 'firstyyymenu:'..chat}
		     	},{
                {text = '> Close', callback_data = 'close:'..chat}
				}
				}
            answer(q.id,'panel','Group settings',chat,'• Select From Menu ⇩',keyboard)
            end
            end
						end
          if msg.callback_query then
            local q = msg.callback_query
						local chat = ('-'..q.data:match('(%d+)') or '')
						if is_mod(chat,q.from.id) then
             if q.data:match('_') and not (q.data:match('menu')) then
                Canswer(q.id,"#:) :D",true)
					elseif q.data:match('lock') then
							local lock = q.data:match('lock (.*)')			
				TIME_MAX = (redis:hget(SUDO.."gps:settings:"..chat,"floodtime") or 2)
              MSG_MAX = (redis:hget(SUDO.."gps:settings:"..chat,"floodmax") or 5)
			                WARN_MAX = (redis:hget("warn:settings:"..chat,"warnmax") or 3)
							local result = settings(chat,lock)
							if lock == 'contacting' or lock == 'savelink' or lock == 'markread' then
							q.data = 'tabsettings:'..chat
								end
							Canswer(q.id,result)
							end
--------  To Main-------#:)---------------
							if q.data:match('main') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
                local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '• BoT [1]', callback_data = 'firstmenu1:'..chat}
				},{
				{text = '• BoT [2]', callback_data = 'firstxxmenu:'..chat}
		     	},{
		     	{text = '• BoT [3]', callback_data = 'firstyyymenu:'..chat}
		     	},{
                {text = '> Close', callback_data = 'close:'..chat}
				}
				}
            edit(q.inline_message_id,'• *Select From* `Menu` ⇩',keyboard)
            end
------------------------
--        BoT 1       --
--      Starting      --
--      By :)      --
------------------------
-------- Menu BoT 1-------#:)---------------
							if q.data:match('firstmenu1') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
                local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '• Stats', callback_data = 'asdfdsa:'..chat},{text = '• Info', callback_data = 'wedjsa:'..chat}
							},{
				{text = '• Settings', callback_data = 'setting:'..chat}
							},{
				{text = '• Help', callback_data = 'help:'..chat}
							},{
				{text = '> ', callback_data = 'main:'..chat}
							},{
                {text = '> Close', callback_data = 'close:'..chat}
							}
							}
            edit(q.inline_message_id,'⇩⇩⇩⇩ *Panel For* `•[BoT 1]•` ⇩⇩⇩⇩',keyboard)
            end
--------Close-------#:)
						if q.data:match('close') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• BG TeaM', url = 'https://t.me/bg_team'}
				}
							}
              edit(q.inline_message_id,'• *Done*\n• `Panel` *Closed*.',keyboard)
            end
--------Help-------#:)
			if q.data:match('help') then
                           local chat = '-'..q.data:match('(%d+)$')
		                    local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '> ', callback_data = 'firstmenu1:'..chat}
				}
							}
             local text = '•[⇩راهنمای دستورات⇩]•\n➖➖➖➖➖➖\n• reload contacts\n• بازنگری مخاطبین\n••• برای شمارش دقیق مخاطبین از این دستور استفاده نمایید.\n➖➖➖➖➖➖\n• modset USERID\n• افزودن ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• moddem USERID\n• حذف ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• link list\n• دریافت لیست لینک های ربات\n➖➖➖➖➖➖\n• fwd users\n• فروارد پیام به کاربران (با ریپلی)\n➖➖➖➖➖➖\n• fwd groups\n• فروارد پیام به گروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd sgroups\n• فروارد پیام به سوپرگروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd all\n• فروارد پیام به همه (کاربران،گروه ها،سوپرگروه ها)،(با ریپلی)\n➖➖➖➖➖➖\n• on\n• اطلاع از آنلاین بودن ربات\n➖➖➖➖➖➖\n• addall USERID\n• افزودن کاربر مورد نظر به تمامیه گروه ها\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• addcontacts\n• افزودن مخاطبان در گروه\n➖➖➖➖➖➖\n• reload stats\n• ریست کردن امار ربات\n➖➖➖➖➖➖\n• echo TEXT\n• تکرار کردن متن\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• bc TEXT\n• ارسال متن به تمامیه سوپرگروه ها\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• setname "FIRST" LAST\n• تنظیم نام\n••• به جای FIRST اسم و بجای LAST فامیل موردنظرتان را قرار دهید .\n➖➖➖➖➖➖\n• setusername USERNAME\n• تنظیم نام کاربری\n••• به جای USERNAME نام کاربری مورد نظرتان را بدون @ قرار دهید .\n➖➖➖➖➖➖\n• delusername\n• حذف نام کاربری\n➖➖➖➖➖➖\n▪ از انتشار این سورس به هیچ وجه راضی نمیباشیم ...\n▪▪ نوشته شده توسط :\n▪▪ [:)](https://t.me/bannedbylife)\n▪▪▪ کانال :\n▪▪▪ [BG TeaM](https://t.me/BG_TeaM)'
 edit(q.inline_message_id,""..text.."",keyboard)
            end
--------Info-------#:)
								if q.data:match('wedjsa') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						local s =  redis:get(":)"..BOT.."offjoin") and 0 or redis:get(":)"..BOT.."maxjoin") and redis:ttl(":)"..BOT.."maxjoin") or 0
					local ss = redis:get(":)"..BOT.."offlink") and 0 or redis:get(":)"..BOT.."maxlink") and redis:ttl(":)"..BOT.."maxlink") or 0
					local msgadd = redis:get(":)"..BOT.."addmsg") and "✅️" or "⛔️"
					local numadd = 	redis:get(":)"..BOT.."markread") and "✅️" or "⛔️"
					local txtadd = redis:get(":)"..BOT.."addmsgtext") or  "addi"
					local autoanswer = redis:get(":)"..BOT.."autoanswer") and "✅️" or "⛔️"
local forcejoin = redis:get(":)"..BOT.."forcejoin") and "✅️" or "⛔️"
					local wlinks = redis:scard(":)"..BOT.."waitelinks")
					local glinks = redis:scard(":)"..BOT.."goodlinks")
					local links = redis:scard(":)"..BOT.."savedlinks")
					local offjoin = redis:get(":)"..BOT.."offjoin") and "⛔️" or "✅️"
					local offlink = redis:get(":)"..BOT.."offlink") and "⛔️" or "✅️"
					local nlink = redis:get(":)"..BOT.."link") and "✅️" or "⛔️"
					local contacts = redis:get(":)"..BOT.."savecontacts") and "✅️" or "⛔️"   
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = ''..tostring(offjoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(offlink)..'', callback_data = 'aksldsnf:'..chat},{text = 'تایید لینک خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(nlink)..'', callback_data = 'fqwe:'..chat},{text = 'تشخیص لینک های عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(contacts)..'', callback_data = 'sdf:'..chat},{text = 'افزودن خودکار مخاطبین :', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(numadd)..'', callback_data = 'asdf:'..chat},{text = 'خواندن پیام ها(تیک دوم) :', callback_data = 'asmnd:'..chat}
				},{
 {text = ''..tostring(forcejoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت اجباری :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(msgadd)..'', callback_data = 'aksldsnf:'..chat},{text = 'افزودن مخاطب با پیام :', callback_data = 'asmnd:'..chat}
				},{
				{text = '⇩ پیام افزودن مخاطب ⇩', callback_data = 'fqwe:'..chat}
				},{
				{text = ''..tostring(txtadd)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(links)..'', callback_data = 'sdf:'..chat},{text = 'لینک های ذخیره شده :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(glinks)..'', callback_data = 'fiasd:'..chat},{text = 'لینک های در انتظار عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(s)..' ثانیه تا عضویت مجدد', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(wlinks)..'', callback_data = 'asdf:'..chat},{text = 'لینک های در انتظار تایید :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(ss)..' ثانیه تا تایید لینک مجدد', callback_data = 'asdf:'..chat}
				},{
				{text = '> ', callback_data = 'firstmenu1:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Status For* `•[BoT 1]•` ⇩⇩⇩⇩',keyboard)
            end			
--------Stats-------#:)
							if q.data:match('asdfdsa') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						  local gps = redis:scard(":)"..BOT.."groups")
					local sgps = redis:scard(":)"..BOT.."supergroups")
					local usrs = redis:scard(":)"..BOT.."users")
					local links = redis:scard(":)"..BOT.."savedlinks")
					local glinks = redis:scard(":)"..BOT.."goodlinks")
					local wlinks = redis:scard(":)"..BOT.."waitelinks")	
					local contacts = redis:get(":)"..BOT.."contacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'Groups :', callback_data = 'asdf:'..chat},{text = ''..tostring(gps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'SuperGroups :', callback_data = 'aksldsnf:'..chat},{text = ''..tostring(sgps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Users :', callback_data = 'fqwe:'..chat},{text = ''..tostring(usrs)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Contacts :', callback_data = 'sdf:'..chat},{text = ''..tostring(contacts)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Links :', callback_data = 'fiasd:'..chat},{text = ''..tostring(links)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = '> ', callback_data = 'firstmenu1:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Stats For* `•[BoT 1]•` ⇩⇩⇩⇩',keyboard)
            end	
----------------------
-- Starting Setting --
--     By :)     --
----------------------
			if q.data:match('setting') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'عضویت خودکار', callback_data = 'autojoin:'..chat}
				},{
				{text = 'تایید لینک خودکار', callback_data = 'truelink:'..chat}
				},{
				{text = 'تشخیص لینک های عضویت', callback_data = 'relink:'..chat}
				},{
				{text = 'افزودن خودکار مخاطبین', callback_data = 'addcontact:'..chat}
				},{
				{text = 'افزودن مخاطب با پیام', callback_data = 'addedmsg:'..chat}
				},{
			    {text = 'خواندن پیام ها (تیک دوم)', callback_data = 'markread:'..chat}
				},{
                {text = 'عضویت اجباری', callback_data = 'forcejoin:'..chat}
				},{
				{text = '> ', callback_data = 'firstmenu1:'..chat}
							}
							}
              edit(q.inline_message_id, '`•[⇩Settings⇩]•`',keyboard)
            end			
--AutoJoin
						if q.data:match('autojoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT.."offjoin")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onautojoinnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'alksjdfdkslaksjd:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onautojoinnn') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT.."maxjoin")
		redis:del(":)"..BOT.."offjoin")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'alksjdfdkslaksjd:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('alksjdfdkslaksjd') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:set(":)"..BOT.."maxjoin", true)
		redis:set(":)"..BOT.."offjoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onautojoinnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--TrueLink
						if q.data:match('truelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT.."offlink")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'ontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiistruelink:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('ontruelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT.."maxlink")
						redis:del(":)"..BOT.."offlink")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiistruelink:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiistruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT.."maxlink", true)
						redis:set(":)"..BOT.."offlink", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'ontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ReLink
						if q.data:match('relink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT.."link")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisreeelink:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT.."link", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisreeelink:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisreeelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT.."link")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddContact
						if q.data:match('addcontact') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT.."savecontacts")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'addcontactonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'addcontactoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('addcontactonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT.."savecontacts", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'addcontactoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('addcontactoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT.."savecontacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'addcontactonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddMsg
						if q.data:match('addedmsg') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT.."addmsg")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'addedmsgonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'addedmsgoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
						if q.data:match('addedmsgonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT.."addmsg", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'addedmsgoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('addedmsgoff') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT.."addmsg")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'addedmsgonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--MarkRead
						if q.data:match('markread') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(":)"..BOT.."markread")
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'markreadonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'markreadoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('markreadonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT.."markread", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'markreadoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('markreadoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT.."markread")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'markreadonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ForceJoin
						if q.data:match('forcejoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(':)"..BOT.."forcejoin')
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'forcejoinonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'forcejoinoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('forcejoinonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT.."forcejoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'forcejoinoff:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('forcejoinoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(':)'..BOT..'forcejoin')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'forcejoinonnn:'..chat}
},{
		{text = '> ', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end	
------------------------
--      End BoT 1     --
--   Starting BoT 2   --
--      By :)      --
------------------------
-------- Menu BoT 2-------#:)---------------
							if q.data:match('firstxxmenu') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
                local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '• Stats', callback_data = 'stats2:'..chat},{text = '• Info', callback_data = 'info2:'..chat}
							},{
				{text = '• Settings', callback_data = 'xxsetting:'..chat}
							},{
							{text = '• Help', callback_data = 'help2:'..chat}
							},{
				{text = '> ', callback_data = 'main:'..chat}
							},{
                {text = '> Close', callback_data = 'close:'..chat}
							}
							}
            edit(q.inline_message_id,'⇩⇩⇩⇩ *Panel For* `•[BoT 2]•` ⇩⇩⇩⇩',keyboard)
            end
--------Help-------#:)
			if q.data:match('help2') then
                           local chat = '-'..q.data:match('(%d+)$')
		                    local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '> ', callback_data = 'firstxxmenu:'..chat}
				}
							}
             local text = '•[⇩راهنمای دستورات⇩]•\n➖➖➖➖➖➖\n• reload contacts\n• بازنگری مخاطبین\n••• برای شمارش دقیق مخاطبین از این دستور استفاده نمایید.\n➖➖➖➖➖➖\n• modset USERID\n• افزودن ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• moddem USERID\n• حذف ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• link list\n• دریافت لیست لینک های ربات\n➖➖➖➖➖➖\n• fwd users\n• فروارد پیام به کاربران (با ریپلی)\n➖➖➖➖➖➖\n• fwd groups\n• فروارد پیام به گروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd sgroups\n• فروارد پیام به سوپرگروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd all\n• فروارد پیام به همه (کاربران،گروه ها،سوپرگروه ها)،(با ریپلی)\n➖➖➖➖➖➖\n• on\n• اطلاع از آنلاین بودن ربات\n➖➖➖➖➖➖\n• addall USERID\n• افزودن کاربر مورد نظر به تمامیه گروه ها\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• addcontacts\n• افزودن مخاطبان در گروه\n➖➖➖➖➖➖\n• reload stats\n• ریست کردن امار ربات\n➖➖➖➖➖➖\n• echo TEXT\n• تکرار کردن متن\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• bc TEXT\n• ارسال متن به تمامیه سوپرگروه ها\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• setname "FIRST" LAST\n• تنظیم نام\n••• به جای FIRST اسم و بجای LAST فامیل موردنظرتان را قرار دهید .\n➖➖➖➖➖➖\n• setusername USERNAME\n• تنظیم نام کاربری\n••• به جای USERNAME نام کاربری مورد نظرتان را بدون @ قرار دهید .\n➖➖➖➖➖➖\n• delusername\n• حذف نام کاربری\n➖➖➖➖➖➖\n▪ از انتشار این سورس به هیچ وجه راضی نمیباشیم ...\n▪▪ نوشته شده توسط :\n▪▪ [:)](https://t.me/bannedbylife)\n▪▪▪ کانال :\n▪▪▪ [BG TeaM](https://t.me/BG_TeaM)'
 edit(q.inline_message_id,""..text.."",keyboard)
            end
--------Info-------#:)
								if q.data:match('info2') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						local s =  redis:get(":)"..BOT2.."offjoin") and 0 or redis:get(":)"..BOT2.."maxjoin") and redis:ttl(":)"..BOT2.."maxjoin") or 0
					local ss = redis:get(":)"..BOT2.."offlink") and 0 or redis:get(":)"..BOT2.."maxlink") and redis:ttl(":)"..BOT2.."maxlink") or 0
					local msgadd = redis:get(":)"..BOT2.."addmsg") and "✅️" or "⛔️"
					local numadd = 	redis:get(":)"..BOT2.."markread") and "✅️" or "⛔️"
					local txtadd = redis:get(":)"..BOT2.."addmsgtext") or  "addi"
					local autoanswer = redis:get(":)"..BOT2.."autoanswer") and "✅️" or "⛔️"
local forcejoin = redis:get(":)"..BOT2.."forcejoin") and "✅️" or "⛔️"
					local wlinks = redis:scard(":)"..BOT2.."waitelinks")
					local glinks = redis:scard(":)"..BOT2.."goodlinks")
					local links = redis:scard(":)"..BOT2.."savedlinks")
					local offjoin = redis:get(":)"..BOT2.."offjoin") and "⛔️" or "✅️"
					local offlink = redis:get(":)"..BOT2.."offlink") and "⛔️" or "✅️"
					local nlink = redis:get(":)"..BOT2.."link") and "✅️" or "⛔️"
					local contacts = redis:get(":)"..BOT2.."savecontacts") and "✅️" or "⛔️"   
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = ''..tostring(offjoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(offlink)..'', callback_data = 'aksldsnf:'..chat},{text = 'تایید لینک خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(nlink)..'', callback_data = 'fqwe:'..chat},{text = 'تشخیص لینک های عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(contacts)..'', callback_data = 'sdf:'..chat},{text = 'افزودن خودکار مخاطبین :', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(numadd)..'', callback_data = 'asdf:'..chat},{text = 'خواندن پیام ها(تیک دوم) :', callback_data = 'asmnd:'..chat}
				},{
 {text = ''..tostring(forcejoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت اجباری :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(msgadd)..'', callback_data = 'aksldsnf:'..chat},{text = 'افزودن مخاطب با پیام :', callback_data = 'asmnd:'..chat}
				},{
				{text = '⇩ پیام افزودن مخاطب ⇩', callback_data = 'fqwe:'..chat}
				},{
				{text = ''..tostring(txtadd)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(links)..'', callback_data = 'sdf:'..chat},{text = 'لینک های ذخیره شده :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(glinks)..'', callback_data = 'fiasd:'..chat},{text = 'لینک های در انتظار عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(s)..' ثانیه تا عضویت مجدد', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(wlinks)..'', callback_data = 'asdf:'..chat},{text = 'لینک های در انتظار تایید :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(ss)..' ثانیه تا تایید لینک مجدد', callback_data = 'asdf:'..chat}
				},{
				{text = '> ', callback_data = 'firstxxmenu:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Status For* `•[BoT 2]•` ⇩⇩⇩⇩',keyboard)
            end			
--------Stats-------#:)
							if q.data:match('stats2') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						  local gps = redis:scard(":)"..BOT2.."groups")
					local sgps = redis:scard(":)"..BOT2.."supergroups")
					local usrs = redis:scard(":)"..BOT2.."users")
					local links = redis:scard(":)"..BOT2.."savedlinks")
					local glinks = redis:scard(":)"..BOT2.."goodlinks")
					local wlinks = redis:scard(":)"..BOT2.."waitelinks")	
					local contacts = redis:get(":)"..BOT2.."contacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'Groups :', callback_data = 'asdf:'..chat},{text = ''..tostring(gps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'SuperGroups :', callback_data = 'aksldsnf:'..chat},{text = ''..tostring(sgps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Users :', callback_data = 'fqwe:'..chat},{text = ''..tostring(usrs)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Contacts :', callback_data = 'sdf:'..chat},{text = ''..tostring(contacts)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Links :', callback_data = 'fiasd:'..chat},{text = ''..tostring(links)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = '> ', callback_data = 'firstxxmenu:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Stats For* `•[BoT 2]•` ⇩⇩⇩⇩',keyboard)
            end	
----------------------
-- Starting Setting --
--     By :)     --
----------------------
			if q.data:match('xxsetting') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'عضویت خودکار', callback_data = 'xxautojoin:'..chat}
				},{
				{text = 'تایید لینک خودکار', callback_data = 'xxtruelink:'..chat}
				},{
				{text = 'تشخیص لینک های عضویت', callback_data = 'xxrelink:'..chat}
				},{
				{text = 'افزودن خودکار مخاطبین', callback_data = 'xxaddcontact:'..chat}
				},{
				{text = 'افزودن مخاطب با پیام', callback_data = 'xxaddedmsg:'..chat}
				},{
					{text = 'خواندن پیام ها (تیک دوم)', callback_data = 'xxmarkread:'..chat}
				},{
{text = 'عضویت اجباری', callback_data = 'xxforcejoin:'..chat}
				},{
				{text = '> ', callback_data = 'firstxxmenu:'..chat}
							}
							}
              edit(q.inline_message_id, '`•[⇩Settings⇩]•`',keyboard)
            end			
--AutoJoin
						if q.data:match('xxautojoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT2.."offjoin")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onxxautojoin:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diisxxautojoin:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onxxautojoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT2.."maxjoin")
		redis:del(":)"..BOT2.."offjoin")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diisxxautojoin:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diisxxautojoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:set(":)"..BOT2.."maxjoin", true)
		redis:set(":)"..BOT2.."offjoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onxxautojoin:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--TrueLink
						if q.data:match('xxtruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT2.."offlink")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisxxtruelink:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('xxontruelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT2.."maxlink")
						redis:del(":)"..BOT2.."offlink")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisxxtruelink:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisxxtruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT2.."maxlink", true)
						redis:set(":)"..BOT2.."offlink", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ReLink
						if q.data:match('xxrelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT2.."link")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onxxreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisxxreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onxxreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT2.."link", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisxxreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisxxreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT2.."link")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onxxreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddContact
						if q.data:match('xxaddcontact') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT2.."savecontacts")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxaddcontacton:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxaddcontactoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('xxaddcontacton') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT2.."savecontacts", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxaddcontactoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('xxaddcontactoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT2.."savecontacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxaddcontacton:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddMsg
						if q.data:match('xxaddedmsg') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT2.."addmsg")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxaddedmsgonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxaddedmsgoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
						if q.data:match('xxaddedmsgonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT2.."addmsg", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxaddedmsgoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('xxaddedmsgoff') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT2.."addmsg")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxaddedmsgonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--MarkRead
						if q.data:match('xxmarkread') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(":)"..BOT2.."markread")
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxmarkreadonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxmarkreadoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('xxmarkreadonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT2.."markread", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxmarkreadoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('xxmarkreadoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT2.."markread")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxmarkreadonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ForceJoin
						if q.data:match('xxforcejoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(':)'..BOT2..'forcejoin')
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxforcejoinonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxforcejoinoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('xxforcejoinonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT2.."forcejoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'xxforcejoinoff:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('xxforcejoinoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(':)'..BOT2..'forcejoin')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'xxforcejoinonnn:'..chat}
},{
		{text = '> ', callback_data = 'xxsetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
------------------------
--      End BoT 2     --
--   Starting BoT 3   --
--      By :)      --
------------------------	
-------- Menu BoT 3-------#:)---------------
							if q.data:match('firstyyymenu') then
							local chat = '-'..q.data:match('(%d+)$')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
                local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '• Stats', callback_data = 'stats3:'..chat},{text = '• Info', callback_data = 'info3:'..chat}
							},{
				{text = '• Settings', callback_data = 'yyysetting:'..chat}
							},{
							{text = '• Help', callback_data = 'help3:'..chat}
							},{
				{text = '> ', callback_data = 'main:'..chat}
							},{
                {text = '> Close', callback_data = 'close:'..chat}
							}
							}
            edit(q.inline_message_id,'⇩⇩⇩⇩ *Panel For* `•[BoT 3]•` ⇩⇩⇩⇩',keyboard)
            end
--------Help-------#:)
			if q.data:match('help3') then
                           local chat = '-'..q.data:match('(%d+)$')
		                    local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '> ', callback_data = 'firstyyymenu:'..chat}
				}
							}
             local text = '•[⇩راهنمای دستورات⇩]•\n➖➖➖➖➖➖\n• reload contacts\n• بازنگری مخاطبین\n••• برای شمارش دقیق مخاطبین از این دستور استفاده نمایید.\n➖➖➖➖➖➖\n• modset USERID\n• افزودن ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• moddem USERID\n• حذف ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• link list\n• دریافت لیست لینک های ربات\n➖➖➖➖➖➖\n• fwd users\n• فروارد پیام به کاربران (با ریپلی)\n➖➖➖➖➖➖\n• fwd groups\n• فروارد پیام به گروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd sgroups\n• فروارد پیام به سوپرگروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd all\n• فروارد پیام به همه (کاربران،گروه ها،سوپرگروه ها)،(با ریپلی)\n➖➖➖➖➖➖\n• on\n• اطلاع از آنلاین بودن ربات\n➖➖➖➖➖➖\n• addall USERID\n• افزودن کاربر مورد نظر به تمامیه گروه ها\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• addcontacts\n• افزودن مخاطبان در گروه\n➖➖➖➖➖➖\n• reload stats\n• ریست کردن امار ربات\n➖➖➖➖➖➖\n• echo TEXT\n• تکرار کردن متن\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• bc TEXT\n• ارسال متن به تمامیه سوپرگروه ها\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• setname "FIRST" LAST\n• تنظیم نام\n••• به جای FIRST اسم و بجای LAST فامیل موردنظرتان را قرار دهید .\n➖➖➖➖➖➖\n• setusername USERNAME\n• تنظیم نام کاربری\n••• به جای USERNAME نام کاربری مورد نظرتان را بدون @ قرار دهید .\n➖➖➖➖➖➖\n• delusername\n• حذف نام کاربری\n➖➖➖➖➖➖\n▪ از انتشار این سورس به هیچ وجه راضی نمیباشیم ...\n▪▪ نوشته شده توسط :\n▪▪ [:)](https://t.me/bannedbylife)\n▪▪▪ کانال :\n▪▪▪ [BG TeaM](https://t.me/BG_TeaM)'
 edit(q.inline_message_id,""..text.."",keyboard)
            end
--------Info-------#:)
								if q.data:match('info3') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						local s =  redis:get(":)"..BOT3.."offjoin") and 0 or redis:get(":)"..BOT3.."maxjoin") and redis:ttl(":)"..BOT3.."maxjoin") or 0
					local ss = redis:get(":)"..BOT3.."offlink") and 0 or redis:get(":)"..BOT3.."maxlink") and redis:ttl(":)"..BOT3.."maxlink") or 0
					local msgadd = redis:get(":)"..BOT3.."addmsg") and "✅️" or "⛔️"
					local numadd = 	redis:get(":)"..BOT3.."markread") and "✅️" or "⛔️"
					local txtadd = redis:get(":)"..BOT3.."addmsgtext") or  "addi"
					local autoanswer = redis:get(":)"..BOT3.."autoanswer") and "✅️" or "⛔️"
local forcejoin = redis:get(":)"..BOT3.."forcejoin") and "✅️" or "⛔️"
					local wlinks = redis:scard(":)"..BOT3.."waitelinks")
					local glinks = redis:scard(":)"..BOT3.."goodlinks")
					local links = redis:scard(":)"..BOT3.."savedlinks")
					local offjoin = redis:get(":)"..BOT3.."offjoin") and "⛔️" or "✅️"
					local offlink = redis:get(":)"..BOT3.."offlink") and "⛔️" or "✅️"
					local nlink = redis:get(":)"..BOT3.."link") and "✅️" or "⛔️"
					local contacts = redis:get(":)"..BOT3.."savecontacts") and "✅️" or "⛔️"   
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = ''..tostring(offjoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(offlink)..'', callback_data = 'aksldsnf:'..chat},{text = 'تایید لینک خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(nlink)..'', callback_data = 'fqwe:'..chat},{text = 'تشخیص لینک های عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(contacts)..'', callback_data = 'sdf:'..chat},{text = 'افزودن خودکار مخاطبین :', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(numadd)..'', callback_data = 'asdf:'..chat},{text = 'خواندن پیام ها(تیک دوم) :', callback_data = 'asmnd:'..chat}
				},{
 {text = ''..tostring(forcejoin)..'', callback_data = 'asdf:'..chat},{text = 'عضویت اجباری :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(msgadd)..'', callback_data = 'aksldsnf:'..chat},{text = 'افزودن مخاطب با پیام :', callback_data = 'asmnd:'..chat}
				},{
				{text = '⇩ پیام افزودن مخاطب ⇩', callback_data = 'fqwe:'..chat}
				},{
				{text = ''..tostring(txtadd)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(links)..'', callback_data = 'sdf:'..chat},{text = 'لینک های ذخیره شده :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(glinks)..'', callback_data = 'fiasd:'..chat},{text = 'لینک های در انتظار عضویت :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(s)..' ثانیه تا عضویت مجدد', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(wlinks)..'', callback_data = 'asdf:'..chat},{text = 'لینک های در انتظار تایید :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(ss)..' ثانیه تا تایید لینک مجدد', callback_data = 'asdf:'..chat}
				},{
				{text = '> ', callback_data = 'firstyyymenu:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Status For* `•[BoT 3]•` ⇩⇩⇩⇩',keyboard)
            end			
--------Stats-------#:)
							if q.data:match('stats3') then
                           local chat = '-'..q.data:match('(%d+)$')
						   
						  local gps = redis:scard(":)"..BOT3.."groups")
					local sgps = redis:scard(":)"..BOT3.."supergroups")
					local usrs = redis:scard(":)"..BOT3.."users")
					local links = redis:scard(":)"..BOT3.."savedlinks")
					local glinks = redis:scard(":)"..BOT3.."goodlinks")
					local wlinks = redis:scard(":)"..BOT3.."waitelinks")	
					local contacts = redis:get(":)"..BOT3.."contacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'Groups :', callback_data = 'asdf:'..chat},{text = ''..tostring(gps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'SuperGroups :', callback_data = 'aksldsnf:'..chat},{text = ''..tostring(sgps)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Users :', callback_data = 'fqwe:'..chat},{text = ''..tostring(usrs)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Contacts :', callback_data = 'sdf:'..chat},{text = ''..tostring(contacts)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = 'Links :', callback_data = 'fiasd:'..chat},{text = ''..tostring(links)..'', callback_data = 'asmnd:'..chat}
				},{
				{text = '> ', callback_data = 'firstyyymenu:'..chat}
							}
							}
              edit(q.inline_message_id, '⇩⇩⇩⇩ *Stats For* `•[BoT 3]•` ⇩⇩⇩⇩',keyboard)
            end	
----------------------
-- Starting Setting --
--     By :)     --
----------------------
			if q.data:match('yyysetting') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'عضویت خودکار', callback_data = 'yyyautojoin3:'..chat}
				},{
				{text = 'تایید لینک خودکار', callback_data = 'yyytruelink:'..chat}
				},{
				{text = 'تشخیص لینک های عضویت', callback_data = 'yyyrelink:'..chat}
				},{
				{text = 'افزودن خودکار مخاطبین', callback_data = 'yyyaddcontact3:'..chat}
				},{
				{text = 'افزودن مخاطب با پیام', callback_data = 'yyyaddedmsg3:'..chat}
				},{
					{text = 'خواندن پیام ها (تیک دوم)', callback_data = 'yyymarkread3:'..chat}
				},{
{text = 'عضویت اجباری', callback_data = 'yyyforcejoin3:'..chat}
				},{
				{text = '> ', callback_data = 'firstyyymenu:'..chat}
							}
							}
              edit(q.inline_message_id, '`•[⇩Settings⇩]•`',keyboard)
            end			
--AutoJoin
						if q.data:match('yyyautojoin3') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT3.."offjoin")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyonautojoinnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyalksjdfdkslaksjd3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('yyyonautojoinnn3') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT3.."maxjoin")
		redis:del(":)"..BOT3.."offjoin")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyalksjdfdkslaksjd3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('yyyalksjdfdkslaksjd3') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:set(":)"..BOT3.."maxjoin", true)
		redis:set(":)"..BOT3.."offjoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyonautojoinnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--TrueLink
						if q.data:match('yyytruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT3.."offlink")
		if :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisyyytruelink:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('yyyontruelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT3.."maxlink")
						redis:del(":)"..BOT3.."offlink")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisyyytruelink:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisyyytruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT3.."maxlink", true)
						redis:set(":)"..BOT3.."offlink", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyontruelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ReLink
						if q.data:match('yyyrelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT3.."link")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onyyyreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisyyyreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onyyyreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT3.."link", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisyyyreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisyyyreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT3.."link")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onyyyreeelinkkk:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddContact
						if q.data:match('yyyaddcontact3') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT3.."savecontacts")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyaddcontactonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyaddcontactoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن خودکار مخاطبین]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('yyyaddcontactonnn3') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT3.."savecontacts", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyaddcontactoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('yyyaddcontactoff3') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT3.."savecontacts")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyaddcontactonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن خودکار مخاطبین]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--AddMsg
						if q.data:match('yyyaddedmsg3') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = redis:get(":)"..BOT3.."addmsg")
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyaddedmsgonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyaddedmsgoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[افزودن مخاطب با ارسال پیام]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
						if q.data:match('yyyaddedmsgonnn3') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set(":)"..BOT3.."addmsg", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyaddedmsgoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('yyyaddedmsgoff3') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del(":)"..BOT3.."addmsg")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyaddedmsgonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[افزودن مخاطب با ارسال پیام]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--MarkRead
						if q.data:match('yyymarkread3') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(":)"..BOT3.."markread")
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyymarkreadonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyymarkreadoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('yyymarkreadonnn3') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT3.."markread", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyymarkreadoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('yyymarkreadoff3') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(":)"..BOT3.."markread")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyymarkreadonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ForceJoin
						if q.data:match('yyyforcejoin3') then
                           local chat = '-'..q.data:match('(%d+)$')
		local :) = 	redis:get(':)'..BOT3..'forcejoin')
			
		if not :) then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyforcejoinonnn3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyforcejoinoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('yyyforcejoinonnn3') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set(":)"..BOT3.."forcejoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'yyyforcejoinoff3:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('yyyforcejoinoff3') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del(':)'..BOT3..'forcejoin')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'yyyforcejoinonnn:'..chat}
},{
		{text = '> ', callback_data = 'yyysetting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end				
-------------------
--   End BoT 3   --
--   By :)    --
-------------------
			else Canswer(q.id,'⚠️Your Not Admin \n #:) ',true)
						end
						end
          if msg.message and msg.message.date > (os.time() - 5) and msg.message.text then
		  	 local m = msg.message
      if m.text == "/start" then
    local keyboard = {}
    keyboard.inline_keyboard = {
         {
				 {text = '• Our Channel', url = 'https://t.me/BG_TeaM'}
                },{
                   {text = '• Writer', url = 'https://t.me/im_:)'}
				   }
							}
        sendmsg(m.chat.id, "<b>• BG Tabchi iNLiNe</b> <code>Helper</code>", keyboard, true)
      end
   end
      end
    end
  end
    end
	end 

return run()					
-------------------
-- End Panel.lua --
--   By :)    --
-------------------
