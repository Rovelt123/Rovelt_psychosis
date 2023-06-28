local Monsters = {}
local Models = {'u_f_m_drowned_01', 'a_m_m_acult_01', 'a_c_chimp'}
local eventstarted = false
 


function Restart(playerPed)
    eventstarted = false
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetPedIsDrunk(playerPed, false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(playerPed)
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
    for k, Monster in pairs(Monsters) do
        if(Monster ~= nil) then
            DeletePed(Monster)
            
            Monsters[k] = nil
        end
    end
end

RegisterNetEvent("Rovelt_psychosis")
AddEventHandler("Rovelt_psychosis", function()
    if not eventstarted then
        local playerPed = GetPlayerPed(-1)
        chance = math.random(30000, 60000)
        DoScreenFadeOut(5000)
        SetPedToRagdoll(playerPed, 22000, 22000, 0, 0, 0, 0)
        Wait(20000)
        DoScreenFadeIn(5000)
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(playerPed, true)
        SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
        SetPedIsDrunk(playerPed, true)
        AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
        ShakeGameplayCam("DRUNK_SHAKE", 5.0)
        Wait(2000)
        local eventstarted = true
		local MonsterSkinID = Models[math.random(1, #Models)]
        local playerPosition = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 10.0, 0.0)
        Citizen.Wait(10)
        RequestModel(MonsterSkinID)
        while(not HasModelLoaded(MonsterSkinID)) do
            Citizen.Wait(10)
        end
        for i = 0, Config.MonsterAmount, 1 do
            Monsters[i] = CreatePed(26, MonsterSkinID, playerPosition.x, playerPosition.y, playerPosition.z, 1, false, true)	
            SetPedCanSwitchWeapon(Monsters[i],false)
            SetPedAsEnemy(Monsters[i], true)
            SetPedCombatAttributes(Monsters[i], 3, false)
            SetPedCombatAttributes(Monsters[i], 5, true)
            SetPedCombatAttributes(Monsters[i], 46, true)
            SetEntityInvincible(Monsters[i], true)
            SetPedMoveRateOverride(Monsters[i],2)
            TaskCombatPed(Monsters[i], playerPed, 0, 16)
            SetPedKeepTask(Monsters[i], true)
            if Config.SetInvincible == true then
                SetEntityInvincible(Monsters[i], true)
            else
                SetEntityInvincible(Monsters[i], false)
            end
            if Config.GiveWeapon == true then
                GiveWeaponToPed(Monsters[i], GetHashKey(Config.MonsterWeapon), 100, true, true)
            end
        end
        SetModelAsNoLongerNeeded(MonsterSkinID)
        Citizen.Wait(chance)
        Restart(playerPed)
        print("YOU SURIVED! GOOD JOB")
        Citizen.Wait(1500)
    end
end)

