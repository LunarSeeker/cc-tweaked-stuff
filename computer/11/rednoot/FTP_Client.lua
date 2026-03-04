local side = "bottom"
rednet.open(side)

local function sendRequest(serverID, data)
    rednet.send(serverID, textutils.serialise(data))
    local _, rawResponse = rednet.receive(3)
    if rawResponse then
        return textutils.unserialise(rawResponse)
    else
        return {status = "error", message = "No response from server!"}
    end
end

local function findServer()
    rednet.broadcast(textutils.serialise({cmd = "ping"}))
    local id, raw = rednet.receive(2)
    if id and raw then
        local data = textutils.unserialise(raw)
        if data.status == "pong" then
            return id
        end
    end
    return nil
end

local function getFile(serverID)
    write("Enter remote file path: ")
    local remotePath = read()
    local response = sendRequest(serverID, {cmd = "get", path = remotePath})

    if response.status == "ok" then
        write("Save As: ")
        local saveAs = read()
        local f = fs.open(saveAs, "w")
        f.write(response.data)
        f.close()
        print("File downloaded as: "..saveAs)
    else
        print("Error: ".. (response.message or "Unknown"))
    end
end

local function putFile(serverID)
    write("Enter local file path to upload: ")
    local localPath = read()
    if fs.exists(localPath) then
        local file = fs.open(localPath, "r")
        local content = file.readAll()
        file.close()
        local response = sendRequest(serverID, {cmd = "put", path = localPath, data = content})
        print(response.status == "ok" and "Upload successful." or "Error: "..response.message)
    else
        print("File not found.")
    end
end

local function listFiles(serverID)
    write("Enter directory (leave blank for root): ")
    local dir = read()
    local response = sendRequest(serverID, {cmd = "list", path = dir})

    if response.status == "ok" then
        print("Files: ")
        for _, file in ipairs(response.files) do
            print(" - "..file)
        end
    else
        print("Error: "..(response.message or "Unknown"))
    end
end

local function deleteFile(serverID)
    write("Enter file path to delete: ")
    local path = read()
    local response = sendRequest(serverID, {cmd = "delete", path = path})
    print(response.message or "Unknown")
end

print("Searching for FTP server...")
local serverID = findServer()

if not serverID then
    print("No server found!")
    return
end
print("Connected to server ID: "..serverID)

while true do
    print("\n1. Upload File")
    print("2. Download File")
    print("3. List Files")
    print("4. Delete File")
    print("5. Exit")
    write("> ")
    local choice = read()

    if choice == "1" then
        putFile(serverID)
    elseif choice == "2" then
        getFile(serverID)
    elseif choice == "3" then
        listFiles(serverID)
    elseif choice == "4" then
        deleteFile(serverID)
    elseif choice == "5" then
        break
    else
        print("Invalid choice! >:( )")
    end
end
