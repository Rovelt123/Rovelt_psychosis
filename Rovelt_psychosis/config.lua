Config = {}
Config.MonsterAmount = 0 --0 = 1, 1 = 2, 2 = 3 And So On.
Config.GiveWeapon = true --Give weapon to monster.
Config.MonsterWeapon = 'WEAPON_BAT' --Weapon for monster.
Config.SetInvincible = true --Sets Monster invincible.

RegisterCommand('psykose', function()
    TriggerEvent('Rovelt_psychosis')

end)