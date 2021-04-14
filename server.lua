local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("pagamento")
AddEventHandler("pagamento",function(valor)

	local source = source
	local user_id = vRP.getUserId(source)

	vRP.giveMoney(user_id,parseInt(valor))	
	TriggerClientEvent("Notify",source,"importante","Valor recebido R$ "..valor.."")
	print("ID: "..user_id.." recebeu R$ "..valor.." por um blip de motorista de onibus [by Don_Speed#6282]")
	return true
end)