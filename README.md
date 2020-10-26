# SwiftUI_Study


# SwiftUI sizing algo
```swift
import UIKit


//1. The parent view determines the available frame at its disposal.
//본인이 제공가능한 view size 계산해서
//2. The parent view proposes a size to the child view.
// 그걸 child 에게 제안한다.
//3. Based on the proposal from the parent, the child view chooses its size.
// 그 제안에 따라서 child 가 size 결정한다.
//4. The parent view sizes itself such that it contains its child view.
// parent 가 그 사이즈에 맞게 본인 사이즈를 바꾼다.
//This process is recursive, starting at the root view, down to the last leaf view in the view hierarchy.


// view 를 2차원 배열로 나타냄
// 0은 사용가능 한 view
// 0아닌 정수는 (1,2,3,4...) 각각의 다른 view 를 뜻함
// 이미 0,1 과 7,8에 view 가 있다고 가정
var parent : [Int] = [1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]

//스크린 출력
func printScreen(_ layout : [Int]) {
    for item in layout {
        print(item, terminator : "")
    }
    print("")
}

//입력된 view 에 대한 가능한 size 정보반환
func returnAvailableSize(_ layout : [Int])  -> [[Int]] {
    var availablePos : [[Int]] = [[]]
    var state = false
    var tmp : [Int] = []
    
    for i in 0..<layout.count {
        if layout[i] == 0 {
            state = true
            tmp.append(i)
        }else {
            state = false
        }
        if i == layout.count-1 {
            state = false
        }
        
        if state == false && tmp.count != 0 {
            availablePos.append(tmp)
            tmp.removeAll()
        }
    }
    //배치 가능한 index 배열을 준다.
    availablePos.removeFirst()
    return availablePos
}

//가증한 size에서 랜덤으로 child 에게 제시할 size 를 반환 (start, end)
func proposeView(_ layout : [[Int]] ) -> (Int, Int){
    let sizepick = layout.randomElement()!
    var startIndex = sizepick.randomElement()!
    var endIndex = sizepick.randomElement()!
    startIndex = min(startIndex,endIndex)
    endIndex = max(startIndex,endIndex)
    return (startIndex,endIndex)
}

//child 가 제시된 size에서 본인이 moreSize만큼 필요하면 더 size를 요구함
//more size는 0에서 10사이 랜덤값
func pickSize(_ tuple : (Int,Int),_ moreSize : Int) -> (Int,Int) {
    let start = Int.random(in: tuple.0...tuple.1 + moreSize)
    let end = Int.random(in: tuple.0...tuple.1 + moreSize)
    return (min(start,end),max(start,end))
}

//해당 child 가 요구한 view 를 parent에게 반영, 더 큰 size를 요구하면 parent 의 size를 수정
func addSubView(_ subView : (Int,Int),_ viewID : Int){
    let parentSize = parent.count
    print("addSubView")
    if subView.0 > parentSize-1 || subView.1 > parentSize-1 {
        print("parentView resized")
        //child 가 parent 보다 더큰 size 를 원한다면
        let diff = subView.1 -  parentSize + 1
        print("need more size for child : \(diff)")
        //차이만큼 size를 parent 에 추가
        for _ in 0..<diff {
            parent.insert(0, at: subView.0)
        }
    }
    //해당 childview 를 parent 에 addsubView
    for i in subView.0...subView.1 {
        parent[i] = viewID
    }
}



for i in 2..<9 {
    print("parent view")
    printScreen(parent)
    print("available size")
    print(returnAvailableSize(parent))
    let tuple = proposeView(returnAvailableSize(parent))
    print("proposed size")
    print(tuple)
    print("child picked size")
    let childSize = pickSize(tuple,Int.random(in: 0...10))
    print(childSize)
    print("child add subView")
    addSubView(childSize, i)
    print("loop \(i) endeed")
    printScreen(parent)
    print("-------------------------------------------------------------------------------")
}


```
