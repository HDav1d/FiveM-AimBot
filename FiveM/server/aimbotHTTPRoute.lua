local aimbotdetection = {}

local function sendResponse(response, statusCode, message)
    response.writeHead(statusCode, { ['Content-Type'] = 'text/plain' })
    response.send(message)
end

AddEventHandler('playerDropped', function(reason)
    local _source = source
    if aimbotdetection[_source] then
        aimbotdetection[_source] = nil
    end
end)

SetHttpHandler(function(request, response)
    if request.method == 'POST' then
        if not request.headers or request.headers["Authorization"] ~= "YourSecretKey" then
            sendResponse(response, 401, 'Unauthorized')
            return
        end

        if request.path == '/aimbot' then
            local body = nil

            request.setDataHandler(function(str)
                local status, data = pcall(function() return json.decode(str) end)
                if status then
                    body = data
                else
                    sendResponse(response, 400, 'Invalid JSON')
                end
            end)

            if not body or not body.playeridentifier then
                sendResponse(response, 400, 'Invalid request')
                return
            end

            local identifier = body.playeridentifier:gsub('license:', '')
            local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

            if xPlayer then
                local _source = xPlayer.source

                if not aimbotdetection[_source] then
                    aimbotdetection[_source] = { count = 1 }
                else
                    if aimbotdetection[_source].count >= 2 then
                        print(string.format("\nReason: ^8AIMBOT^7 | Playername: ^6%s^7 | PlayerID: ^6%d^7\n", GetPlayerName(_source), _source))
                        DropPlayer(_source, "Security Kick | AimBot")
                        aimbotdetection[_source] = nil
                    else
                        aimbotdetection[_source].count = aimbotdetection[_source].count + 1
                    end
                end

                sendResponse(response, 200, 'Ok')
            else
                sendResponse(response, 404, 'Player not found')
            end
        else
            sendResponse(response, 404, 'Not found')
        end
    else
        sendResponse(response, 404, 'Not found')
    end
end)