local Beds, CurrentBed, OnBed = {'v_med_bed1', 'V_Med_bed2', 'gabz_pillbox_diagnostics_bed_01', 'gabz_pillbox_diagnostics_bed_02', 'gabz_pillbox_diagnostics_bed_03', 'v_med_emptybed', 'v_med_cor_autopsytbl'}, nil, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		if not OnBed then
			local PlayerPed = PlayerPedId()
			local PlayerCoords = GetEntityCoords(PlayerPed)

			for k,v in pairs(Beds) do
				local ClosestBed = GetClosestObjectOfType(PlayerCoords, 0.8, GetHashKey(v), false, false)

				if ClosestBed ~= 0 and ClosestBed ~= nil then
					CurrentBed = ClosestBed
					break
				else
					CurrentBed = nil
				end
			end
		end
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                 --Made by SaskaTheBlESSED
Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if CurrentBed ~= nil then
			if not OnBed then
				sleep = 7
				local BedCoords = GetEntityCoords(CurrentBed)

				Draw3DText(BedCoords + vector3(0.0, 0.0, 0.5), '~g~[E]~s~ maataksesi')
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
		sleep = 1000
		local dict = "missfbi1"
		local PlayerPed = PlayerPedId()
		local BedCoords, BedHeading = GetEntityCoords(CurrentBed), GetEntityHeading(CurrentBed)
        if CurrentBed ~= nil and not OnBed then
			sleep = 7
			if IsControlJustReleased(0, 46) then

				if not HasAnimDictLoaded(dict) then
					RequestAnimDict(dict)
			
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(1)
					end
				end

				SetEntityCoords(PlayerPed, BedCoords)
				SetEntityHeading(PlayerPed, (BedHeading+180))

				TaskPlayAnim(PlayerPed, 'missfbi1', 'cpr_pumpchest_idle', 8.0, -8.0, -1, 1, 0, false, false, false)
				OnBed = true
			end
        elseif CurrentBed ~= nil and OnBed then
			sleep = 7
			
			Draw3DText(BedCoords + vector3(0.0, 0.0, 0.5), '~o~[X]~s~ Noustaksesi')
			if IsControlJustReleased(0, 105) then
            	ClearPedTasks(PlayerPedId())

            	OnBed = false
			end
        end
        Citizen.Wait(sleep)
    end
end)

Draw3DText = function(coords, text)

	local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.3, 0.3)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x, _y + 0.0118, factor, 0.025, 20, 20, 20, 170)
	end
end