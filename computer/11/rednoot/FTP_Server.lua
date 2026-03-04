local side = "bottom"
rednet.open(side)
--local logFile = "ftp_log.txt"

local function log(action)
    local logFile = fs.open("ftp_log.txt", "a")
    local day = os.day()
    local time = textutils.formatTime(os.time())
    logFile.writeLine("[Day "..day.." at "..time.."] "..action)
    logFile.close()
end

print("FTP Server started! Listening for requests...")
log("Server Started")

local function sendResponse(id, data)
    rednet.send(id, textutils.serialise(data))
end

local function handleRequest(id, message)
    log("Client "..id.." sent command: "..(message.cmd or "unknown"))
    local cmd = message.cmd

    if cmd == "get" then
        local path = message.path
        if fs.exists(path) and not fs.isDir(path) then
            local file = fs.open(path, "r")
            local data = file.readAll()
            file.close()
            sendResponse(id, {status = "ok", data = data})
        else
            sendResponse(id, {status = "error", message = "File not found: "..path})
            log("Error: File not found - "..path)
        end

    elseif cmd == "put" then
        local path, data = message.path, message.data
        local file = fs.open(path, "w")
        file.write(data)
        file.close()
        sendResponse(id, {status = "ok", message = "File saved as: "..path})

    elseif cmd == "list" then
        local dir = message.path or ""
        if fs.exists(dir) and fs.isDir(dir) then
            local files = {}
            for _, file in ipairs(fs.list(dir)) do
                if file ~= "ftp_log.txt" then
                    table.insert(files, file)
                end
            end
            sendResponse(id, {status = "ok", files = files})
        else
            sendResponse(id, {status = "error", message = "Directory not found: "..dir})
        end

    elseif cmd == "delete" then
        local path = message.path
        if fs.exists(path) then
            fs.delete(path)
            sendResponse(id, {status = "ok", message = "Deleted: "..path})
        else
            sendResponse(id, {status = "error", message = "File not found: "..path})
        end

    elseif cmd == "ping" then
        sendResponse(id, {status = "pong"})
    else
        sendResponse(id, {status = "error", message = "Unknown command: "..tostring(cmd)})
    end
end

while true do
    local id, rawMsg = rednet.receive()
    local ok, msg = pcall(textutils.unserialise, rawMsg)
    if ok and type(msg) == "table" then
        handleRequest(id, msg)
    else
        sendResponse(id, {status = "error", message = "Invalid message format!"})
    end
end
