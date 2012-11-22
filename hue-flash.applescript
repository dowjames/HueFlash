global BridgeAddress
global apiKey
set BridgeAddress to "YOUR BRIDGE IP"
set apiKey to "YOUR API KEY"

global turnOn
global turnOff
set turnOn to the quoted form of "{\"on\": true,\"bri\": 254,\"transitiontime\": 0}"
set turnOff to the quoted form of "{\"on\": false,\"transitiontime\": 0}"

run evaluateState
script flasher
	
	set Lamp1State to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/"
	set Lamp2State to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/"
	
	set the_String to Lamp1State
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		-- do script steps here
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try
	set Lamp1power to (item 3 of these_items)
	set Lamp1bri to (item 5 of these_items)
	set Lamp1hue to (item 7 of these_items)
	set Lamp1sat to (item 9 of these_items)
	set Lamp1ct to (item 14 of these_items)
	set Lamp1x to (item 11 of these_items)
	set Lamp1y to (item 12 of these_items)
	
	set the_String to Lamp2State
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try
	set Lamp2power to (item 3 of these_items)
	set Lamp2bri to (item 5 of these_items)
	set Lamp2hue to (item 7 of these_items)
	set Lamp2sat to (item 9 of these_items)
	set Lamp2ct to (item 14 of these_items)
	set Lamp2x to (item 11 of these_items)
	set Lamp2y to (item 12 of these_items)
	
	
	set BLUE1 to "{\"hue\": " & 45000 & ", \"sat\": 254,\"bri\": " & Lamp1bri & ",\"transitiontime\": 0}"
	set BLUE1 to the quoted form of BLUE1
	set BLUE2 to "{\"hue\": " & 45000 & ", \"sat\": 254,\"bri\": " & Lamp2bri & ",\"transitiontime\": 0}"
	set BLUE2 to the quoted form of BLUE2
	
	set RED1 to "{\"hue\": " & 0 & ", \"sat\": 254,\"bri\": " & Lamp1bri & ",\"transitiontime\": 0}"
	set RED1 to the quoted form of RED1
	set RED2 to "{\"hue\": " & 0 & ", \"sat\": 254,\"bri\": " & Lamp2bri & ",\"transitiontime\": 0}"
	set RED2 to the quoted form of RED2
	
	
	delay 0.2
	
	repeat 10 times
		delay 0.1
		do shell script "curl --request PUT --data " & RED1 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/state/"
		do shell script "curl --request PUT --data " & BLUE2 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/state/"
		delay 0.1
		do shell script "curl --request PUT --data " & BLUE1 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/state/"
		do shell script "curl --request PUT --data " & RED2 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/state/"
	end repeat
	
	set lamp1Restore to "{\"on\": true,\"bri\": " & Lamp1bri & ",\"hue\": " & Lamp1hue & ",\"xy\": " & Lamp1x & "," & Lamp1y & ",\"sat\": " & Lamp1sat & ",\"ct\": " & Lamp1ct & ",\"transitiontime\": 0}"
	set lamp1Restore to the quoted form of lamp1Restore
	
	do shell script "curl --request PUT --data " & lamp1Restore & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/state/"
	
	
	set lamp2Restore to "{\"on\": true,\"bri\": " & Lamp2bri & ",\"hue\": " & Lamp2hue & ",\"xy\": " & Lamp2x & "," & Lamp2y & ",\"sat\": " & Lamp2sat & ",\"ct\": " & Lamp2ct & ",\"transitiontime\": 0}"
	set lamp2Restore to the quoted form of lamp2Restore
	
	do shell script "curl --request PUT --data " & lamp2Restore & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/state/"
	
end script
script evaluateState
	
	set Lamp1State to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/"
	set Lamp2State to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/"
	
	set the_String to Lamp1State
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		-- do script steps here
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try
	set Lamp1power to (item 3 of these_items)
	set Lamp1bri to (item 5 of these_items)
	set Lamp1hue to (item 7 of these_items)
	set Lamp1sat to (item 9 of these_items)
	set Lamp1ct to (item 14 of these_items)
	set Lamp1x to (item 11 of these_items)
	set Lamp1y to (item 12 of these_items)
	
	set the_String to Lamp2State
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try
	set Lamp2power to (item 3 of these_items)
	set Lamp2bri to (item 5 of these_items)
	set Lamp2hue to (item 7 of these_items)
	set Lamp2sat to (item 9 of these_items)
	set Lamp2ct to (item 14 of these_items)
	set Lamp2x to (item 11 of these_items)
	set Lamp2y to (item 12 of these_items)
	
	if Lamp1power = "true" and Lamp2power = "true" then
		run flasher
	else
		do shell script "curl --request PUT --data " & turnOn & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/state/"
		do shell script "curl --request PUT --data " & turnOn & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/state/"
		delay 1
		run flasher
		do shell script "curl --request PUT --data " & turnOff & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/1/state/"
		delay 1
		do shell script "curl --request PUT --data " & turnOff & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/2/state/"
	end if
end script
