--[[
# PokeRaidToTFOP
精靈寶可夢自動腳本，公園前團戰截圖回報。 / Pokemon GO Automation Script, Nearby Raid Screenshot to TFOP.

## 環境 / Environment
- 作業系統 / OS: Android
- 自動化環境 / Automation Environment: Ankulua
- 程式語言 / Language: Lua
- 精靈寶可夢台灣地圖 / Pokemon GO Map (for Taiwan only): 公園前 / TFOP 

## Ankulua Website:
- English: http://ankulua.boards.net/; 
- Chinese: http://ankulua-tw.boards.net/

## 公園前 / TFOP
- 精靈寶可夢台灣地圖 / Pokemon GO Map (for Taiwan only)
- 提供團戰截圖回報 / Support Nearby Raid Screenshot to TFOP
- Facebook: https://www.facebook.com/tfop.tw/
- Website: https://map.tfop.tw/

## 腳本特色 / Script Features
- 自動團戰截圖 / Automatically get a Screenshot of the Nearby Raid
- 截圖回報到公園前 / Nearby Raid Screenshot to TFOP

## 免責聲明
- 本腳本可能會被官方偵測，並以違反服務條款的方式處分遊戲帳號。
- 如因使用此腳本而造成任何損失，本人一概不負任何責任。
- 如要使用，請自行負擔可能造成的任何損失。

## Disclaimer:
- This script may be officially detected and the game account will be dismissed in violation of the Terms of Service.
- I am not responsible for any loss caused by the use of this script.
- If you want to use it, please bear any possible losses.

## 已測試設備 / Tested Device
Pixel.

## 手動程序 / Manual procedure

### 環境準備 / Environmental preparation
安卓手機 / Android Phone: 按 Home 鍵時, 桌面只有下面二個圖示 / When you press the Home button, the desktop has only the following two icons.
- Pokemon GO: 帳號至少等級5, 同時已加入陣營 / Account level at least level 5, has joined the team.
- 公園前 / TFOP: 用 Chrom 加入主畫面功能, 將公園前網站圖示放在桌面, 封鎖訊息, 開啟定位, 開啟跟隨我的位置 / Use Chrome to Add to Home screen feature, Add TFOP website icon placed on the desktop, block notification, allow GPS, enable follow me.
<img src="https://i.imgur.com/PnmwNf2.png" width="270">

### 團戰截圖 / Nearby Raid Screenshot
- 按 Home 鍵 / press the Home button
- 點擊 Pokemon GO 圖示 / Click on the Pokemon GO icon
- 點擊在附近寶可夢區域 / Click on the nearby Pokémon area
- 點擊在附近團戰頁籤 / Click on the Nearby Raid tabpage
- 截圖 / Screenshot
- 關閉在附近頁面 / Close the Nearby page
- 按 Home 鍵 / press the Home button

<img src="https://i.imgur.com/Vb5HjeB.png" width="270"> <img src="https://i.imgur.com/0HlUcRl.png" width="270"> <img src="https://i.imgur.com/qh9i2FE.png" width="270">

### 截圖回報到公園前 / Nearby Raid Screenshot to TFOP
- 按 Home 鍵 / press the Home button
- 點擊公園前圖示 / Click on the TFOP icon: 等待【我】圖示 / Wait [me] icon
- 點擊【團戰截圖回報】 / Click on [團戰截圖回報]: 出現上傳對話框 / Display Upload dialog box
- 點擊【選擇檔案】 / Click on the [Choose File]
- 點擊【檔案】圖示 / Click on the [Files] icon
- 選項 / Optional: 如果不是截圖目錄[Screenshots], 手動選到該目錄 / If it is not the screenshot directory [Screenshots], manually select the directory
- 長按第1張圖 / Long press the first picture
- 按【開啟】 / press the [OPEN] button
- 按【上傳】 / press the [上傳] button
- 關閉上傳對話框 / Close Upload dialog box
- 按 Home 鍵 / press the Home button

<img src="https://i.imgur.com/QFEzNOO.png" width="270"> <img src="https://i.imgur.com/nrp68zV.png" width="270"> <img src="https://i.imgur.com/Ho01hEa.png" width="270"> <img src="https://i.imgur.com/qO2ZDHn.png" width="270"> <img src="https://i.imgur.com/m1b7DK5.png" width="270"> <img src="https://i.imgur.com/KOHdBjp.png" width="270">

### 完成 / Finished
- 手動程序過程若符合上述圖檔, 極可能不需調整, 就可執行本自動化腳本
- If the manual program process meets the above image, it is very likely that the automation script can be executed without adjustment.
--]]
-- ========== Settings ================
Settings:setCompareDimension(true, 540)
Settings:setScriptDimension(true, 540)
Settings:set("MinSimilarity", 0.80)

setImmersiveMode(true)

-- ========== Function ================
function funSnapContinue()
    usePreviousSnap(false)
end

function funSnapScreen()
    usePreviousSnap(false)
    exists("snap_dummy_grey.png", 0) -- just for screen capture
    usePreviousSnap(true)
end


-- ========== User Interface ================
dialogInit()

newRow()
addTextView("ver：20180916 1050")

newRow()
addTextView("Report Time (HH - HH): ")
addEditNumber("intPRTF_HHbgn", 5)
addTextView(" - ")
addEditNumber("intPRTF_HHend", 21)

newRow()
addTextView("Report Interval (seconds) = ")
addEditNumber("intPRTF_Interval", 1500)

newRow()
addTextView("Step Wait Seconds = ")
addEditNumber("intPRTF_StepWait", 10)

newRow()
addCheckBox("chkPRTF_HaveEgg", "Must Have Egg", false)

newRow()
addCheckBox("chkPRTF_SSOnly", "Screenshot Only", false)

dialogShow("Set Parameters")

intHHbgn = intPRTF_HHbgn
intHHend = intPRTF_HHend

rptInterval = intPRTF_Interval
stepWaitSec = intPRTF_StepWait
chkHaveEgg = chkPRTF_HaveEgg
chkSSOnly = chkPRTF_SSOnly

thrCnt = 0

regUpper = Region(0, 0, 540, 430)
regMidLow = Region(0, 180, 540, 780)
regBottom = Region(0, 730, 540, 230)
regMain = regBottom

flgStep = 0
flgSeeDetails = 0
flgDebug = 0
-- ========== Main Program ================
while true do

    funSnapScreen()

	currTime = os.time()

    flgRun = 0
	intHHnow = os.date("%H") + 0
	if intHHend > intHHbgn then
		if intHHnow >= intHHbgn and intHHnow < intHHend then flgRun = 1 end
	else
		if intHHnow >= intHHend or intHHnow < intHHbgn then flgRun = 1 end
	end

	if flgRun == 0 or flgStep == 99 then
		-- Wait
		keyevent(3) -- home
		wait(rptInterval)
		flgStep = 0
		flgSeeDetails = 0
	elseif flgStep == 0 then
		-- Home
		keyevent(3) -- home
		wait(stepWaitSec)
		flgStep = 1
	elseif (flgStep == 1 or flgStep == 2) and exists("home_pokemon_go.png", 0) and exists("home_tfop.png", 0) then
		-- Launch Pokemong GO
		click(exists("home_pokemon_go.png", 0))
		wait(stepWaitSec)
		flgStep = 2
	elseif flgStep == 2 then
		-- Message
		if exists("msg_ok.png", 0) and (exists("msg_dangerous.png", 0) or exists("msg_dangerous_en.png", 0)) then
			click(exists("msg_ok.png", 0))
			wait(stepWaitSec)
		elseif exists("msg_ok.png", 0) and (exists("msg_driving.png", 0) or exists("msg_driving_en.png", 0)) then
			click(exists("msg_ok.png", 0))
			wait(stepWaitSec)
		elseif exists("msg_ok.png", 0) and (exists("msg_trespass.png", 0) or exists("msg_trespass_en.png", 0)) then
			click(exists("msg_ok.png", 0))
			wait(stepWaitSec)
		elseif exists("msg_passenger.png", 0) or exists("msg_passenger_en.png", 0) then
			click(getLastMatch())
			wait(stepWaitSec)
		elseif exists("msg_see_details.png", 0) or exists("msg_see_details_en.png", 0) then
			click(getLastMatch())
			flgSeeDetails = 1
			wait(stepWaitSec)
		elseif flgSeeDetails == 1 and exists("msg_exit.png", 0) then
			click(getLastMatch())
			flgSeeDetails = 2
			wait(stepWaitSec)
		-- Nearby Raid Screenshot
		elseif regMain:exists("main_menu.png", 0) then
			-- Main
			click(regMain:exists(Pattern("main_menu.png"):targetOffset(200,0),0))
			wait(stepWaitSec)
		elseif exists("nearby_pokemon_find.png", 0) and exists("nearby_pokemon_find_exit.png", 0) then
			-- Nearby Pokemon Find
			click(exists("nearby_pokemon_find_exit.png", 0))
			wait(stepWaitSec)
		--[[
		elseif exists("nearby_pokemong_active.png", 0) and (exists("nearby_blank.png", 0) or exists("nearby_pokemon_none.png", 0)) then
			-- Nearby Pokemon and no internet connection
			wait(stepWaitSec)
		elseif exists("nearby_pokemong_active_en.png", 0) and (exists("nearby_blank.png", 0) or exists("nearby_pokemon_none_en.png", 0)) then
			-- Nearby Pokemon and no internet connection
			wait(stepWaitSec)
		--]]
		elseif regUpper:exists("nearby_pokemong_active.png", 0) then
			-- Nearby Pokemon
			click(regUpper:exists("nearby_raid_title.png", 0))
			wait(stepWaitSec)
		elseif regUpper:exists("nearby_pokemong_active_en.png", 0) then
			-- Nearby Pokemon
			click(regUpper:exists("nearby_raid_title_en.png", 0))
			wait(stepWaitSec)
		elseif exists("nearby_raid_active.png", 0) and (exists("nearby_blank.png", 0) or regMidLow:exists(Pattern("nearby_unknown.png"):similar(0.9), 0)) then
			-- Nearby Raid and no internet connection / gym unknown
			wait(stepWaitSec)
		elseif exists("nearby_raid_active_en.png", 0) and (exists("nearby_blank.png", 0) or regMidLow:exists(Pattern("nearby_unknown.png"):similar(0.9), 0)) then
			-- Nearby Raid and no internet connection / gym unknown
			wait(stepWaitSec)
		elseif exists("nearby_raid_active.png", 0) and exists("nearby_raid_none.png", 0) then
			-- Nearby Raid and not found
			--click(regBottom:exists("nearby_exit.png", 0))
			wait(stepWaitSec)
			--flgStep = 99
		elseif exists("nearby_raid_active_en.png", 0) and exists("nearby_raid_none_en.png", 0) then
			-- Nearby Raid and not found
			--click(regBottom:exists("nearby_exit.png", 0))
			wait(stepWaitSec)
			--flgStep = 99
		elseif (exists("nearby_raid_active.png", 0) or exists("nearby_raid_active_en.png", 0))
			and ( chkHaveEgg == false or exists(Pattern("nearby_egg_1.png"):similar(0.9), 0) or exists(Pattern("nearby_egg_3.png"):similar(0.9), 0) or exists(Pattern("nearby_egg_5.png"):similar(0.9), 0)) then
			-- Nearby Raid
			keyevent(120) -- screenshot
			wait(stepWaitSec)
			funSnapContinue()
			--[[
			while regBottom:exists("nearby_exit.png", 0) do
				click(regBottom:getLastMatch())
				wait(stepWaitSec)
				--]]
			-- Message
			if exists("msg_passenger.png", 0) or exists("msg_passenger_en.png", 0) then
				click(getLastMatch())
				wait(stepWaitSec)
				if regBottom:exists("nearby_exit.png", 0) then
					-- Nearby Raid
					keyevent(120) -- screenshot
					wait(stepWaitSec)
				end
			end
			--end
			keyevent(3) -- home
			wait(stepWaitSec)
			flgStep = 10
			if chkPRTF_SSOnly == true then
				flgStep = 99
			end
		end
	elseif (flgStep == 10 or flgStep == 11) and exists("home_pokemon_go.png", 0) and exists("home_tfop.png", 0) then
		-- Nearby Raid Screenshot Report to TFOP
		-- Lanuch TFOP
		click(exists("home_tfop.png", 0))
		wait(stepWaitSec)
		flgStep = 11
		startTFOP = os.time()
	--[[
	elseif flgStep == 11 and exists("tfop_upload.png", 0) then
		-- close Upload dialog
		click(exists(Pattern("tfop_upload.png"):targetOffset(230,0), 0))
		wait(stepWaitSec)
	elseif flgStep == 11 and exists("pms_upload.png", 0) and exists("pms_close.png", 0) then
		-- close Upload dialog (pms)
		click(exists("pms_close.png", 0))
		wait(stepWaitSec)
	--]]
	elseif (flgStep == 11 or flgStep == 12) and os.difftime(currTime, startTFOP) >= 120 then
		-- restart TFOP
		keyevent(3) -- home
		wait(stepWaitSec)
		--killApp("com.android.chrome")
		--wait(stepWaitSec)
		flgStep = 10
	--[[
	elseif (flgStep == 11 or flgStep == 12) and exists("tfop_title.png", 0) and exists("tfop_me.png", 0) then
		-- Wait TFOP ready, set follow me ON
		click(exists(Pattern("tfop_title.png"):targetOffset(140,0), 0))
		wait(stepWaitSec)
		flgStep = 12
	--]]
	elseif (flgStep == 12 or flgStep == 13) and (exists("tfop_choose_file.png", 0) or exists("tfop_choose_file_en.png", 0)) then
		-- Choose file
		click(getLastMatch())
		wait(stepWaitSec)
		flgStep = 13
	elseif (flgStep == 11 or flgStep == 12) and exists("pms_radis_ss.png", 0) and (exists("pms_location.png", 0) or exists("pms_location2.png", 0)) then
		-- Wait PMS ready (pms)
		click(exists("pms_radis_ss.png", 0))
		wait(stepWaitSec)
		flgStep = 12
	elseif (flgStep == 13 or flgStep == 14) and exists("tfop_select_file.png", 0) then
		-- Select file
		click(getLastMatch())
		wait(stepWaitSec)
		flgStep = 14
	elseif (flgStep == 14 or flgStep == 15) and exists("tfop_select_file_recent.png", 0) then
		-- Select Recent
		longClick(exists(Pattern("tfop_select_file_recent.png"):targetOffset(0,85), 0), 1)
		wait(stepWaitSec)
		flgStep = 15
	elseif (flgStep == 14 or flgStep == 15) and exists("tfop_select_file_recent_en.png", 0) then
		-- Select Recent
		longClick(exists(Pattern("tfop_select_file_recent_en.png"):targetOffset(0,85), 0), 1)
		wait(stepWaitSec)
		flgStep = 15
	elseif (flgStep == 14 or flgStep == 15) and exists("tfop_select_file_screenshots.png", 0) then
		-- Select Recent
		longClick(exists(Pattern("tfop_select_file_screenshots.png"):targetOffset(0,85), 0), 1)
		wait(stepWaitSec)
		flgStep = 15
	elseif (flgStep == 14 or flgStep == 15) and exists("tfop_select_1_item.png", 0) and exists("tfop_select_item_open.png", 0) then
		-- Select Recent
		click(exists("tfop_select_item_open.png", 0))
		wait(stepWaitSec)
		flgStep = 15
	elseif (flgStep == 14 or flgStep == 15) and exists("tfop_select_1_item_en.png", 0) and exists("tfop_select_item_open_en.png", 0) then
		-- Select Recent
		click(exists("tfop_select_item_open_en.png", 0))
		wait(stepWaitSec)
		flgStep = 15
	--elseif flgStep == 15 and exists("tfop_upload.png", 0) then
	elseif flgStep == 15 and exists("pms_upload.png", 0) then
		-- Upload
		click(getLastMatch())
		-- wait(60)
		funSnapContinue()
		--if exists("tfop_upload_success.png", 60) then
		if exists("pms_upload_success.png", 60) then
			--click(exists(Pattern("tfop_upload.png"):targetOffset(230,0), 0))
			click(exists("pms_close.png", 0))
			wait(stepWaitSec)
			keyevent(3) -- home
			wait(stepWaitSec)
			flgStep = 99
		end
	end

end
