# 빌드 에러

* 에러메세지 Library not found : library search path 확인할 것
* 에러메세지 Undefined symbol : Build phase > Link Binary With Library에 라이브러리가 추가되어 있는지 확인할 것

# XCode 빌드세팅 팁

* library나 framework, header search path 추가할때 hierarchy pane에 있는거 drag & drop으로 하면 편하다

# Value type vs Referrence type

> https://devmjun.github.io/archive/Swift-StructVSClass

```
class RefValue {
    var x: Int = 0
}

func changeRefValue(variable: RefValue) {
    var otherRefValue = variable
    otherRefValue.x = 100
    print(otherRefValue.x) // 100
}

var refValue: RefValue = RefValue() // #1-1 참조타입객체를 생성하고
print(refValue.x) // 0

changeRefValue(variable: refValue)  // #1-2 값을 변경하는 함수를 실행하면
print(refValue.x) // 100, #1-3 해당 값이 변경되었다.

// -> 함수의 stack Frema 속에서 참조된 refValue.x 의 값이 변경되었다.



struct ValValue {
    var x: Int = 0
}

func notChangeValValue(StructVariable variable: ValValue) {
    var otherValValue = variable // #2-3 값타입은 복사가 되므로 2-1에서 생성한 인스턴스와는 별개가 된다.
    otherValValue.x = 100
    print(otherValValue.x) // 100
}

var valValue: ValValue = ValValue() // #2-1 valValue를 생성하고
print(valValue.x) // 0

notChangeValValue(StructVariable: valValue) // #2-2 값을 변경하는 함수를 실행했지만
print(valValue.x) // 0

// -> 같은 형태(?)로 정의 했는데, 결과값이 다르게 나왔다. 간단하게 설명하면 struct는 인스턴스 생성시에 값을 복사해서 인자로 전달했고, class 는 인자로 전달될때 값이 아니라, 그 값의 주소값이 전달이 되어서 위와 같은 결과를 가져온다고 할수 있다
```

> https://soooprmx.com/archives/5355

* 값타입 사용
    * ==를 사용하여 인스턴스를 비교하는 것이 합당하다면
    * 독립적인 상태로 각각의 사본을 만들고자 한다면
    * 여러 스레드에서 사용될 데이터라면

* 참조타입 사용
    * ===를 사용하여 인스턴스(포인터)를 비교하는 것이 합당하다면
    * 공유된 상태, 변경이 가능한 상태를 원한다면

* Swift에서 Array, String, Dictionary는 모두 값 타입이다.
* 이는 C의 int 타입처럼 순수한 값처럼 동작한다.
* 특별히 명시적으로 구조 내부를 복사하는 코드를 만들 필요가 없으며, 뒷단에서 다른 코드에 데이터를 불지불식간에 변경하는 일도 없다.
* 특히 값타입은 동기화 없이 스레드 간에 데이터를 전달할 수 있다.
* 따라서 안정성을 높이는 관점에서 바라볼 때 이런 모델은 코드를 보다 더 예측가능하게 만들어 줄 것이다.


# Subscripts

* 콜렉션, 리스트, 시퀀스 안의 멤버 요소(member element)에 접근하기 위한 shortcut

> https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html\
> https://kka7.tistory.com/118

`좋은 기능인것 같은데... 어따쓰지?...`

```
// Define
struct Matrix {

    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns) // 기본값을 0.0으로 하는 칸들을 지정된 범위 만큼 생성
    }

    // subscript 요청시 들어온 값이 init시 지정한 범위안에 들어오는 확인
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            // 범위 밖의 값을 찾고자 하면 assert
            assert(indexIsValid(row: row, column: column), "Index out of range")
            // grid 배열에서 해당위치의 값을 찾아 리턴
            return grid[(row * columns) + column]
        }

        set {
            // 범위 밖의 값을 넣고자 하면 assert
            assert(indexIsValid(row: row, column: column), "Index out of range")
            // grid 배열에서 해당위치에 값을 할당
            grid[(row * columns) + column] = newValue
        }
    }
}

// Usage
var matrix = Matrix(rows: 2, columns: 2)    // 2*2 매트릭스 생성

// setter 호출
matrix[0, 1] = 1.5  // row 0, column 1에 1.5 할당
matrix[1, 0] = 3.2  // row 1, column 0에 3.2 할당

// getter 호출
let val1 = matrix[0, 1] // row 0, column 1의 값 출력
let val2 = matrix[1, 0] // row 1, column 0의 값 출력
```


* Type Subscripts

`static func을 쓰는것과 뭐가 다른지 알아봐야겠다. 일단은 호출할때 함수명을 안써도 되네. 좋은걸까?`

```
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
```

> http://blog.naver.com/PostView.nhn?blogId=hjleesm&logNo=221349109702

`난수 배열을 만들고 []으로 찾는 방법인데 이게 더 불편해 보이는데..??`


> https://wlaxhrl.tistory.com/45

아래 추가 설명을 보면 복수의 subscript가 가능하다.
단 ambigeous use 에러가 나지 않도록 오버로딩해야한다.

# XCode 11.4 release note 

> https://sungdoo.dev/programming/xcode-11-4-news/

* subsript가 default값 지정 가능해짐
```
struct Subscriptable {
    subscript(x: Int, y: Int = 0) {
        //...
    }
}

let s = Subscriptable()
print(s[0])
```

* Type선언부에 callAsFunction 메소드를 추가해서 타입을 함수처럼 쓸 수 있게 됨
```
struct Adder {
    var base: Int

    func callAsFunction(_ x: Int) -> Int {
      return x + base
    }
}

var adder = Adder(base: 3)
adder(10) // returns 13, same as adder.callAsFunction(10)
```

* simulator에 remote push notification 지원


</br>

---

## PROTOCOL

* optional protocol 만들기

> 출처: https://zeddios.tistory.com/347 [ZeddiOS]
    
```
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
```

</br></br></br></br>

# NEXT
* official doc에 아직 모르는게 많다... https://docs.swift.org/swift-book/LanguageGuide