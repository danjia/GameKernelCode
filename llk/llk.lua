
function checkInRow(pos1, pos2)
	if pos1[1] ~= pos2[1] then
		return false
	end
	local minCol = nil
	local maxCol = nil
	if pos1[2] > pos2[2] then
		minCol = pos2[2]
		maxCol = pos1[2]
	else
		minCol = pos1[2]
		maxCol = pos2[2]
	end

	local line = map[pos1[1]]
	for index = minCol+1, maxCol-1 do
		if 0 ~= line[index] then
			return false
		end
	end
	return true
end

function checkInCol(pos1, pos2)
	if pos1[2] ~= pos2[2] then
		return false
	end
	local minRow = nil
	local maxRow = nil
	if pos1[1] > pos2[1] then
		minRow = pos2[1]
		maxRow = pos1[1]
	else
		minRow = pos1[1]
		maxRow = pos2[1]
	end

	local col = pos1[2]
	for index = minRow+1, maxRow-1 do
		if 0 ~= map[index][col] then
			return false
		end
	end
	return true
end

function checkOneTurn(pos1, pos2)
	local centerPos = {}

	centerPos[1] = pos1[1]
	centerPos[2] = pos2[2]
	if checkInRow(pos1, centerPos) and checkInCol(centerPos, pos2) then
		return true
	end

	centerPos[1] = pos2[1]
	centerPos[2] = pos1[2]
	if checkInCol(pos1, centerPos) and checkInRow(centerPos, pos2) then
		return true
	end

	return false
end

function checkInTwoTurn(pos1, pos2)
	--left
	local row = pos1[1]
	local line = map[row]
	for col = pos1[2]-1, 1, -1 do
		if 0 ~= line[col] then
			break
		elseif checkOneTurn({row, col}, pos2) then
			return true
		end
	end

	--right
	for col = pos1[2]+1, #line do
		if 0 ~= line[col] then
			break
		elseif checkOneTurn({row, col}, pos2) then
			return true
		end
	end
	return false
end

function touch(pos1, pos2)
	if checkInRow(pos1, pos2) then
		print("same row")
	
	elseif checkInCol(pos1, pos2) then
		print("same col")

	elseif checkOneTurn(pos1, pos2) then
		print("one change ok")

	elseif checkInTwoTurn(pos1, pos2) then
		print("second change ok")

	else
		print("not found")
	end
end

map = {
   --1, 2, 3, 4, 5, 6
	{0, 2, 0, 0, 0, 0},--1
	{1, 1, 0, 0, 0, 0},--2
	{0, 1, 1, 0, 0, 1},--3
	{0, 0, 0, 1, 0, 0},--4
	{0, 0, 2, 0, 0, 0},--5
	{0, 0, 0, 0, 0, 0},--6
}


--pos{row, col}
-- touch({1, 2}, {1, 4})
-- touch({5, 4}, {1, 4})
-- touch( {1, 2}, {5, 3})
touch({2, 2}, {3, 6})

print("232323")