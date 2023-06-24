
Config = {}

Config.NPCS = {
    {
        id = 'HarrisonsPawn',
        pedenabled = true,
        pedcoords = vec3(-267.6729, 234.9292, 90.5747),
        pedheading = 356.9681,
        ped ='S_M_Y_AmmuCity_01',
        pedhash = 0x9E08633D,
        scenario = 'WORLD_HUMAN_AA_SMOKE'
    },
}

Config.Items = { -- bei Erhöung der Anzahl Index[] , müssen in der client.lua auch die Abfragen angepasst werden
    { name = 'weaponrepairkit', label = 'Waffen Rep. Kit', bprice = 300.00, sprice = 450.00, currency = 'money', stash = 'pawnstash', society = 'society_gwa'},
    { name = 'parachute', label = 'Fallschirm', bprice = 250.00, sprice = 330.00, currency = 'money', stash = 'pawnstash', society = 'society_gwa'},
    { name = 'phone', label = 'Handy', bprice = 50.00, sprice = 180.00, currency = 'money', stash = 'pawnstash', society = 'society_gwa'},
    { name = 'kanister5l', label = '5L Kanister (leer)', bprice = 3.00, sprice = 6.00, currency = 'money', stash = 'pawnstash', society = 'society_gwa'},
}

Config.Targets = {
    {name = 'sellpoint', id = 1, coords = {-267.6729, 234.9292, 90.5747}, size = {1.5,1.5,1.5}, heading = 0}
}

Config.Stash = {
    {
       id = 'pawnsellstash',
       label = 'Verkaufslager',
       slots = 100,
       weight = 200000,
       owner = false,
       coords = vec3(-266.3508,233.9774,89.76888),
       groups =  ({["gwa"] = 0})
    },
    {
        id = 'pawnstash',
        label = 'Lager',
        slots = 100,
        weight = 200000,
        owner = false,
        coords = vec3(-264.8761,234.0471,89.56666),
        groups =  ({["gwa"] = 0})
    }
}