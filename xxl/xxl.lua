



local nRow  = nil
local nCol  = nil

local dir = {{0, 1}, {1, 0}}
local g_opportDir = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
DIR_RIGHT = 1
DIR_DOWN  = 2
DIR_LEFT  = 3
DIR_UP    = 4




local mapData = {
	data = {
		-- --1, 2, 3, 4, 5, 6, 7
		-- {0, 0, 0, 0, 0, 0, 0},--1
		-- {0, 0, 0, 1, 0, 0, 0},--2
		-- {0, 1, 1, 1, 0, 0, 0},--3
		-- {0, 0, 0, 1, 0, 0, 0},--4
		-- {0, 0, 0, 0, 0, 0, 0},--5
		-- {0, 0, 0, 0, 0, 0, 0},--6
		-- {0, 0, 0, 0, 0, 0, 0},--7

	   --1, 2, 3, 4, 5, 6, 7
		{1, 1, 0, 0, 0, 1, 0},--1
		{0, 0, 0, 1, 1, 0, 0},--2
		{0, 0, 0, 0, 0, 0, 0},--3
		{0, 0, 0, 0, 0, 0, 0},--4
		{0, 0, 0, 0, 0, 0, 0},--5
		{0, 0, 0, 0, 0, 0, 0},--6
		{0, 0, 0, 0, 0, 0, 0},--7
	},
	visit = {
		--horizontal
		[1] = {
			--1,      2,     3,     4,     5,     6,     7
			{false, false, false, false, false, false, false},--1
			{false, false, false, false, false, false, false},--2
			{false, false, false, false, false, false, false},--3
			{false, false, false, false, false, false, false},--4
			{false, false, false, false, false, false, false},--5
			{false, false, false, false, false, false, false},--6
			{false, false, false, false, false, false, false},--7
		},
		--vertical
		[2] = {
			--1,      2,     3,     4,     5,     6,     7
			{false, false, false, false, false, false, false},--1
			{false, false, false, false, false, false, false},--2
			{false, false, false, false, false, false, false},--3
			{false, false, false, false, false, false, false},--4
			{false, false, false, false, false, false, false},--5
			{false, false, false, false, false, false, false},--6
			{false, false, false, false, false, false, false},--7
		},
	}
}




function dfs(row, col, lastDir, cnt)
	-- print("dfs:", lastDir.."_:", "("..row..","..col..")", "cnt= "..cnt)
	local visit = mapData["visit"]
	for d = 1, #dir do
		newRow = row + dir[d][1]
		newCol = col + dir[d][2]
		-- print(newRow, newCol, 
		-- 	"mapData:", mapData["data"][row][col], mapData["data"][newRow][newCol],
		-- 	"visit:", visit[d][newRow][newCol])
		if newRow >= 1 and newRow <= nRow and
			newCol >= 1 and newCol <= nCol and
			0 ~= mapData["data"][row][col] and
			mapData["data"][row][col] == mapData["data"][newRow][newCol] and
			false == visit[d][newRow][newCol] then

			visit[d][newRow][newCol] = true
			if d ~= lastDir then
				cnt = 1
			end
			if dfs(newRow, newCol, d, cnt+1) then
				print("row, col:", row, col)
				return true
			else
				visit[d][newRow][newCol] = false
				return false
			end
		else
			if cnt >= 3 then
				print("find it")
				print("row, col:", row, col)
				return true
			end
		end
	end
	return false
end

local g_checkRight = {DIR_UP,   DIR_RIGHT, DIR_DOWN}
local g_checkLeft  = {DIR_UP,   DIR_LEFT,  DIR_DOWN}
local g_checkUp    = {DIR_UP,   DIR_LEFT,  DIR_RIGHT}
local g_checkDown  = {DIR_DOWN, DIR_LEFT,  DIR_RIGHT}

function checkOpportunity(row, col, dir, value)
	print("checkOpportunity", row, col, dir, value)
	local newRow = nil
	local newCol = nil
	local result = nil
	local data   = mapData["data"]

	local function checkFunc(t)
		for _, d in ipairs(t) do
			newRow = row + g_opportDir[d][1]
			newCol = col + g_opportDir[d][2]
			if newRow >= 1 and newCol <= nRow and
				data[newRow][newCol] == value then
				return {newRow, newCol}
			end
		end
	end
	if DIR_RIGHT == dir then
		-- print("right")
		col = col + 1
		result = checkFunc(g_checkRight) 
		if result then
			return result
		end
		-- print("left")
		col = col - 2
		result = checkFunc(g_checkLeft)
		if result then
			return result
		end
		  
	elseif DIR_DOWN == dir then
		row = row + 1
		result = checkFunc(g_checkDown) 
		if result then
			return result
		end
		row = row - 2
		result = checkFunc(g_checkUp)
		if result then
			return result
		end
	else
		error("not direction")
	end
end

function findTips(row, col, lastDir, cnt)
	-- print("findTips:", lastDir.."_:", "("..row..","..col..")", "cnt= "..cnt)
	local visit = mapData["visit"]
	for d = 1, #dir do
		newRow = row + dir[d][1]
		newCol = col + dir[d][2]
		-- print("("..newRow..","..newCol..")",
		-- 	"mapData:", mapData["data"][row][col], mapData["data"][newRow][newCol],
		-- 	"visit:", visit[d][newRow][newCol])
		if newRow >= 1 and newRow <= nRow and
			newCol >= 1 and newCol <= nCol and
			0 ~= mapData["data"][row][col] and
			mapData["data"][row][col] == mapData["data"][newRow][newCol] and
			false == visit[d][newRow][newCol] then
			-- print("in", d, lastDir, "new:", newRow, newCol)
			visit[d][newRow][newCol] = true
			if d ~= lastDir then
				cnt = 1
			end
			if findTips(newRow, newCol, d, cnt+1) then
				print("row, col:", row, col)
				return true
			else
				visit[d][newRow][newCol] = false
				return false
			end
		else
			if cnt >= 2 then
				print("find tip, dir:", lastDir)
				
				local result = checkOpportunity(row, col, lastDir, mapData["data"][row][col])
				if result then
					print(result[1], result[2])
				end
				print("row, col:", row, col)
				return true
			end
		end
	end
	return false
end

function initData()
	nRow = #mapData["data"]
	nCol = #mapData["data"][1]
end

function clearVisit()
	local visit_h = mapData["visit"][1]
	local visit_v = mapData["visit"][2]
	for row = 1, nRow do
		for col = 1, nCol do
			visit_h[row][col] = false
			visit_v[row][col] = false
		end
	end
end


function startToMark()
	local visit = mapData["visit"]
	for row = 1, nRow do
		for col = 1, nCol do
			for d = 1, #dir do
				if false == visit[d][row][col] then
					visit[d][row][col] = true
					if dfs(row, col, d, 1) then
						-- print("row, col:", row, col)
					end
				end
			end
		end
	end
end


function helpToDelete()
	local visit = mapData["visit"]
	for row = 1, nRow do
		for col = 1, nCol do
			for d = 1, #dir do
				if false == visit[d][row][col] then
					visit[d][row][col] = true
					if findTips(row, col, d, 1) then
						
					end
				end
			end
		end
	end
end



--===================
--      run
--===================
initData()

-- startToMark()

helpToDelete()


clearVisit()


local function _encode(str)
	print("str:", str, string.byte(str))
    return string.format("%%%02X",string.byte(str))
end

function emailEncode(str)
    return string.gsub(str,"([^%w_@.])",_encode)
end

print(emailEncode("dna#jia@163.com"))