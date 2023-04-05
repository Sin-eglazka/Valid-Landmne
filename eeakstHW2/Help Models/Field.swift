//
//  Field.swift
//  eeakstHW3
//
//  Created by Kate on 05.03.2023.
//

class Field{
    private var field = [[Int]]()
    private var digitsNow = [[Int]]()
    private var visible = [[Int]]()
    private var flags = [[Int]]()
    private var formatCells = [[CellFormat]]()
    private var minesQuantity, lastMines, size, visibleQuantity: Int
    private var gameOver = false, win = true
    
    init(difficulty: Difficulty){
        visibleQuantity = 0
        switch(difficulty){
        case .easy:
            minesQuantity = 10
            size = 9
        case .normal:
            minesQuantity = 40
            size = 16
        case .hard:
            minesQuantity = 99
            size = 22
        }
        var temporary = [Int]()
        var temporaryFormat = [CellFormat]()
        for _ in 1...size{
            temporary.append(0)
            temporaryFormat.append(CellFormat.invisible)
        }
        for _ in 1...size{
            field.append(temporary)
            digitsNow.append(temporary)
            visible.append(temporary)
            flags.append(temporary)
            formatCells.append(temporaryFormat)
        }
        lastMines = minesQuantity
        
        
    }
    
    func createField(indexFirst: Int){
        var currentMines: Int = 0
        var index: Int = -1
        let bound:Int = size * size
        while currentMines < minesQuantity{
            index = Int.random(in: 0..<bound)
            if index == indexFirst{
                continue
            }
            if field[index/size][index%size] != -1{
                currentMines += 1
                field[index/size][index%size] = -1
                fillField(index: index)
            }
        }
    }
    
    func returnFormatByIndex(index: Int) -> CellFormat{
        return formatCells[index / size][index % size]
    }
    
    func returnFormats() -> [[CellFormat]]{
        return formatCells
    }
    
    private func fillField(index:Int){
        let i = index / size, j = index % size
        if i > 0{
            if field[i - 1][j] != -1{
                field[i - 1][j] += 1
            }
            if j > 0{
                if field[i - 1][j - 1] != -1{
                    field[i - 1][j - 1] += 1
                }
            }
            if j < size - 1{
                if field[i - 1][j + 1] != -1{
                    field[i - 1][j + 1] += 1
                }
            }
        }
        if i < size - 1{
            if field[i + 1][j] != -1{
                field[i + 1][j] += 1
            }
            if j > 0{
                if field[i + 1][j - 1] != -1{
                    field[i + 1][j - 1] += 1
                }
            }
            if j < size - 1{
                if field[i + 1][j + 1] != -1{
                    field[i + 1][j + 1] += 1
                }
            }
        }
        if j > 0{
            if field[i][j - 1] != -1{
                field[i][j - 1] += 1
            }
        }
        if j < size - 1{
            if field[i][j + 1] != -1{
                field[i][j + 1] += 1
            }
        }
    }
    
    func setFlag(index:Int) -> CellFormat {
        if visible[index / size][index % size] == 1{
            return formatCell(digit: field[index / size][index % size])
        }
        else{
            if (flags[index / size][index % size] == 1){
                return removeFlag(index: index)
            }
            else{
                flags[index / size][index % size] = 1
                lastMines -= 1
                formatCells[index / size][index % size] = .flag
                return CellFormat.flag
            }
        }
    }
    
    func removeFlag(index:Int) -> CellFormat {
        if flags[index / size][index % size] == 1{
            flags[index / size][index % size] = 0
            lastMines += 1
            return CellFormat.invisible
        }
        else{
            if visible[index / size][index % size] == 1{
                return formatCell(digit: field[index / size][index % size])
            }
            else{
                formatCells[index / size][index % size] = .invisible
                return CellFormat.invisible
            }
        }
    }
    
    func openCell(index:Int) -> Bool {
        if flags[index / size][index % size] == 1{
            formatCells[index / size][index % size] = .flag
            return false
        }
        if field[index / size][index % size] == -1{
            win = false
            gameOver = true
            formatCells[index / size][index % size] = .bomb
            return false
        }
        else{
            if visible[index / size][index % size] != 1{
                if (field[index / size][index % size] == 0){
                    openEmptyCells(index: index)
                    formatCells[index / size][index % size] = formatCell(digit: field[index / size][index % size])
                    return true
                }
                visibleQuantity += 1
                visible[index / size][index % size] = 1
            }
            formatCells[index / size][index % size] = formatCell(digit: field[index / size][index % size])
            
            return false
        }
    }
    
    func openEmptyCells(index: Int){
        let i = index / size, j = index % size
        if visible[i][j] == 1{
            return
        }
        visible[i][j] = 1
        visibleQuantity += 1
        if i > 0{
            formatCells[i - 1][j] = formatCell(digit: field[i - 1][j])
            if field[i - 1][j] == 0{
                openEmptyCells(index: (i-1) * size + j)
            }
            else{
                if (visible[i - 1][j] == 0){
                    visibleQuantity += 1
                    visible[i-1][j] = 1
                }
            }
            if j > 0{
                formatCells[i - 1][j - 1] = formatCell(digit: field[i - 1][j - 1])
                if field[i - 1][j - 1] == 0{
                    openEmptyCells(index: (i-1) * size + j - 1)
                }
                else{
                    if (visible[i - 1][j - 1] == 0){
                        visibleQuantity += 1
                        visible[i-1][j - 1] = 1
                    }
                }
            }
            if j < size - 1{
                formatCells[i - 1][j + 1] = formatCell(digit: field[i - 1][j + 1])
                if field[i - 1][j + 1] == 0{
                    openEmptyCells(index: (i-1) * size + j + 1)
                }
                else{
                    if (visible[i-1][j + 1] == 0){
                    visibleQuantity += 1
                    visible[i-1][j + 1] = 1
                    }
                }
            }
        }
        if i < size - 1{
            formatCells[i + 1][j] = formatCell(digit: field[i + 1][j])
            if field[i + 1][j] == 0{
                openEmptyCells(index: (i+1) * size + j)
            }
            else{
                if (visible[i+1][j] == 0){
                    visibleQuantity += 1
                    visible[i+1][j] = 1
                }
            }
            if j > 0{
                formatCells[i + 1][j - 1] = formatCell(digit: field[i + 1][j - 1])
                if field[i + 1][j - 1] == 0{
                    openEmptyCells(index: (i+1) * size + j - 1)
                }
                else{
                    if (visible[i+1][j - 1] == 0){
                        visibleQuantity += 1
                        visible[i+1][j - 1] = 1
                    }
                }
            }
            if j < size - 1{
                formatCells[i + 1][j + 1] = formatCell(digit: field[i + 1][j + 1])
                if field[i + 1][j + 1] == 0{
                    openEmptyCells(index: (i+1) * size + j + 1)
                }
                else{
                    if (visible[i+1][j + 1] == 0){
                        visibleQuantity += 1
                        visible[i+1][j+1] = 1
                    }
                }
            }
        }
        if j > 0{
            formatCells[i][j - 1] = formatCell(digit: field[i][j - 1])
            if field[i][j - 1] == 0{
                openEmptyCells(index: (i) * size + j - 1)
            }
            else{
                if (visible[i][j - 1] == 0){
                    visibleQuantity += 1
                    visible[i][j - 1] = 1
                }
            }
        }
        if j < size - 1{
            formatCells[i][j+1] = formatCell(digit: field[i][j+1])
            if field[i][j + 1] == 0{
                openEmptyCells(index: i * size + j + 1)
            }
            else{
                if (visible[i][j + 1] == 0){
                    visibleQuantity += 1
                    visible[i][j+1] = 1
                }
            }
        }
    }
    
    func isGameOver() -> Bool{
        if gameOver{
            return true
        }
        else{
            if visibleQuantity + minesQuantity == size * size{
                gameOver = true
                return true
            }
            else{
                return false
            }
        }
    }
    
    func isWin() -> Bool{
        if gameOver{
            return win
        }
        else{
            return false
        }
    }
    
    func getLastMines() -> Int{
        return lastMines
    }
    
    func formatCell(digit:Int) -> CellFormat {
        switch (digit){
        case 0:
            return CellFormat.empty
        case 1:
            return CellFormat.one
        case 2:
            return CellFormat.two
        case 3:
            return CellFormat.three
        case 4:
            return CellFormat.four
        case 5:
            return CellFormat.five
        case 6:
            return CellFormat.six
        case 7:
            return CellFormat.seven
        case 8:
            return CellFormat.eight
        default:
            return CellFormat.invisible
        }
    }
    
    func getSize() -> Int{
        return size
    }
    
    func getRandomCloseCell() -> Int{
        let isFound = false
        while !isFound{
            let index = Int.random(in: 0...size*size-1)
            if (visible[index / size][index % size] == 0) && (field[index / size][index % size] != -1){
                return index
            }
        }
    }
    
    func isHasSolution() -> (Bool, Int){
        for i in 0...size-1{
            for j in 0...size-1{
                if (flags[i][j] == 1 && field[i][j] != -1){
                    return (true,i * size + j)
                }
            }
        }
        var slau = [[Double]]()
        var temporary = [Double]()
        for i in 0...size*size{
            temporary.append(0)
        }
        slau.append(temporary)
        for i in 0...size*size-1{
            if visible[i / size][i % size] != 1 && flags[i / size][i % size] != 1{
                slau[0][i] = 1
            }
            
        }
        slau[0][size*size] = Double(lastMines)

        var currentIndex = 0
        for i in 0...size-1{
            for j in 0...size-1{
                if (visible[i][j] == 1){
                    var nearCell = 0, nearFlags = 0
                    slau.append(temporary)
                    if i > 0{
                        if flags[i - 1][j] == 1{
                            nearFlags += 1
                        }
                        else{
                            if visible[i - 1][j] != 1{
                                nearCell += 1
                                slau[currentIndex + 1][(i - 1) * size + j] = 1
                            }
                        }
                        if j > 0{
                            if flags[i - 1][j - 1] == 1{
                                nearFlags += 1
                            }
                            else{
                                if visible[i - 1][j - 1] != 1{
                                    nearCell += 1
                                    slau[currentIndex + 1][(i - 1) * size + j - 1] = 1
                                }
                            }
                        }
                        if j < size - 1{
                            if flags[i - 1][j + 1] == 1{
                                nearFlags += 1
                            }
                            else{
                                if visible[i - 1][j + 1] != 1{
                                    nearCell += 1
                                    slau[currentIndex + 1][(i - 1) * size + j + 1] = 1
                                }
                            }
                        }
                    }
                    if i < size - 1{
                        if flags[i + 1][j] == 1{
                            nearFlags += 1
                        }
                        else{
                            if visible[i + 1][j] != 1{
                                nearCell += 1
                                slau[currentIndex + 1][(i + 1) * size + j] = 1
                            }
                        }
                        if j > 0{
                            if flags[i + 1][j - 1] == 1{
                                nearFlags += 1
                            }
                            else{
                                if visible[i + 1][j - 1] != 1{
                                    nearCell += 1
                                    slau[currentIndex + 1][(i + 1) * size + j - 1] = 1
                                }
                            }
                        }
                        if j < size - 1{
                            if flags[i + 1][j + 1] == 1{
                                nearFlags += 1
                            }
                            else{
                                if visible[i + 1][j + 1] != 1{
                                    nearCell += 1
                                    slau[currentIndex + 1][(i + 1) * size + j + 1] = 1
                                }
                            }
                        }
                    }
                    if j > 0{
                        if flags[i][j - 1] == 1{
                            nearFlags += 1
                        }
                        else{
                            if visible[i][j - 1] != 1{
                                nearCell += 1
                                slau[currentIndex + 1][(i) * size + j - 1] = 1
                            }
                        }
                    }
                    if j < size - 1{
                        if flags[i][j + 1] == 1{
                            nearFlags += 1
                        }
                        else{
                            if visible[i][j + 1] != 1{
                                nearCell += 1
                                slau[currentIndex + 1][(i) * size + j + 1] = 1
                            }
                        }
                    }
                    if nearCell == 0{
                        slau.remove(at: currentIndex + 1)
                    }
                    else{
                        slau[currentIndex + 1][size*size] = Double(field[i][j] - nearFlags)
                        currentIndex += 1
                    }
                }
            }
        }
        
        return gauss(slau: &slau, currentSize: currentIndex)
    }

    func gauss( slau: inout [[Double]], currentSize: Int) -> (Bool, Int){
        var currentColumn = 0
        for i in 0...currentSize{
            var firstIndex = -1
            while firstIndex == -1 && currentColumn < size*size{
                for j in i...currentSize{
                    if slau[j][currentColumn] != 0{
                        firstIndex = j
                        break
                    }
                }
                if firstIndex == -1{
                    currentColumn += 1
                }
            }
            if firstIndex != -1{
                slau.swapAt(i, firstIndex)
                if slau[i][currentColumn] != 1{
                    for j in currentColumn+1...size*size{
                        slau[i][j] /= slau[i][currentColumn]
                    }
                    slau[i][currentColumn] = 1
                }
                for j in 0...currentSize{
                    if j != i && slau[j][currentColumn] != 0{
                        for l in currentColumn+1...size*size{
                            slau[j][l] -= slau[j][currentColumn] * slau[i][l]
                        }
                        slau[j][currentColumn] = 0
                    }
                }
            }
        }
        for i in 0...currentSize{
            var currentIndexes = 0, column = -1, positive = 0, negative = 0
            for j in 0...size*size-1{
                if slau[i][j] != 0{
                    currentIndexes += 1
                    if column == -1 || slau[i][j] > 0{
                        column = j
                    }
                    if slau[i][j] > 0{
                        positive += 1
                    }
                    if slau[i][j] < 0{
                        negative += 1
                    }
                }
            }
            if currentIndexes == 1 || Double(positive) == slau[i][size*size]{
                return (true, column)
            }
        }
        return (false, getRandomCloseCell())
    }
}
