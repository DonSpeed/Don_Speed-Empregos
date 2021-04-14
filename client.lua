local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")


local trabalho = false
local idblip = nil
local idrota = nil
local blip = nil
local processo = false


local rotas = {
    [1] = {
	    [1] = {x = 306.58,y = -767.00,z = 28.72, pagar = 150},
	    [2] = {x = 114.65,y = -784.19,z = 30.81, pagar = 150},
	    [3] = {x = -174.89,y = -678.25,z = 33.65, pagar = 150},
	    [4] = {x = -609.74,y = -649.41,z = 31.14, pagar = 150},
	    [5] = {x = -619.94,y = -392.68,z = 34.18, pagar = 150},
	    [6] = {x = -506.18,y = -284.63,z = 34.88, pagar = 150},
	    [7] = {x = -176.73,y = -158.62,z = 43.12, pagar = 150},
	    [8] = {x = -36.33,y = -133.86,z = 56.68, pagar = 150},
	    [9] = {x = 132.35,y = -199.22,z = 53.89, pagar = 150},
	    [10] = {x = 317.88,y = -267.60,z = 53.29, pagar = 150},
	    [11] = {x = 247.20,y = -585.65,z = 42.58, pagar = 150},
	    [12] = {x = 243.74,y = -861.27,z = 29.02, pagar = 150},
	    [13] = {x = 411.54,y = -806.76,z = 28.66, pagar = 150},
	    [14] = {x = 461.47,y = -604.09,z = 28.00, pagar = 150},
    },
	[2] = {
		[1] = {x = 495.53,-1007.15,z = 27.08, pagar = 200},
	    [2] = {x = 531.65,-1409.26,z = 28.47, pagar = 200},
	    [3] = {x = 807.46,-1352.82,z = 25.52, pagar = 200},
	    [4] = {x = 998.29,y = -1006.74,z = 41.25, pagar = 200},
	    [5] = {x = 1205.01,y = -778.22,z = 56.34, pagar = 200},
	    [6] = {x = 1199.28,y = -272.08,z = 68.23, pagar = 200},
	    [7] = {x = 1028.35,y = -191.19,z = 69.37, pagar = 200},
	    [8] = {x = 717.28,y = 7.38,z = 83.22, pagar = 200},
	    [9] = {x = 504.67,y = -128.37,z = 59.04, pagar = 200},
	    [10] = {x = 249.73,y = -578.08,z = 42.47, pagar = 200},
	    [11] = {x = 241.23,y = -860.95,z = 28.84, pagar = 200},
	    [12] = {x = 411.51,y = -808.11,z = 28.44, pagar = 200},
	    [13] = {x = 465.60,y = -604.11,z = 27.77, pagar = 200},
	},
	[3] = {
		[1] = {x = 383.04,y = -670.47,z = 28.47, pagar = 450},
	    [2] = {x = 1532.52,y = 834.18,z = 76.72, pagar = 450},
	    [3] = {x = 1929.46,y = 2605.02,z = 45.64, pagar = 450},
	    [4] = {x = 1695.01,y = 6399.73,z = 31.40, pagar = 450},
	    [5] = {x = 438.23,y = 6580.80,z = 26.38, pagar = 450},
	    [6] = {x = -67.78,y = 6321.80,z = 30.62, pagar = 450},
	    [7] = {x = -2232.27,y = 4324.65,z = 48.18, pagar = 450},
	    [8] = {x = -3234.75,y = 978.16,z = 12.07, pagar = 450},
	    [9] = {x = -3004.75,y = 398.43,z = 14.17, pagar = 450},
	    [10] = {x = 249.54,y = -549.90,z = 42.37, pagar = 450},
	    [11] = {x = 244.26,y = -861.46,z = 28.78, pagar = 450},
	    [12] = {x = 411.15,y = -803.69,z = 28.45, pagar = 450},
	    [13] = {x = 467.09,y = -603.69,z = 27.78, pagar = 450},
	}
}

RegisterCommand("iniciarrota",function(source,args)
    if parseInt(args[1]) <= 3 and parseInt(args[1]) >= 1 then
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),453.48,-607.74,28.57,true) <= 30 and trabalho == false then
            trabalho = true
		    idblip = 1
		    idrota = parseInt(args[1])
		
		    CriandoBlip(rotas[idrota][idblip].x,rotas[idrota][idblip].y,rotas[idrota][idblip].z)
			TriggerEvent("Notify","importante","Siga seu trajeto!")
			FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()),false)
        end
	end
end)

RegisterCommand("vrp:proximo",function()
    if not processo and trabalho then
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),rotas[idrota][idblip].x,rotas[idrota][idblip].y,rotas[idrota][idblip].z,true) <= 10 then

		    if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("coach")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("bus"))then

			    FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()),true)
			    processo = true
			
			    Citizen.Wait(2000)
			
			    if idrota == 1 and idblip >= 14 then 
			        idblip = 0
			    end
				if idrota == 2 and idblip >= 13 then 
			        idblip = 0
			    end
				if idrota == 3 and idblip >= 13 then 
			        idblip = 0
			    end
			
			
			    idblip = idblip + 1
			
			    RemoveBlip(blip)
			
		        CriandoBlip(rotas[idrota][idblip].x,rotas[idrota][idblip].y,rotas[idrota][idblip].z)
			
			    FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()),false)
			    TriggerServerEvent("pagamento", rotas[idrota][idblip].pagar)
			    processo = false
			end
		end
    end
end)
RegisterKeyMapping ( 'vrp:proximo' , 'Proxima rota' , 'keyboard' , 'E' )

RegisterCommand("vrp:cancelar",function()
    if trabalho then
	   trabalho = false
       idblip = nil
       idrota = nil
	   RemoveBlip(blip)
       blip = nil
	   TriggerEvent("Notify","sucesso","Rota cancelada com sucesso!")
	end
end)
RegisterKeyMapping ( 'vrp:cancelar' , 'Cancelar rota' , 'keyboard' , 'F7' )

function CriandoBlip(x,y,z)
	blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,3)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Motorista")
	EndTextCommandSetBlipName(blip)
end