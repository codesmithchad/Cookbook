# Assosciation Type

> ref: https://zeddios.tistory.com/382

* 프로토콜에서 사용한다.
* 정의되지 않은 임시타입을 나타낸다.
* 사용할 때 값타입을 지정해야 한다.
* Generic의 개념

---

### 1. 프로토콜에 associationtype형의 프로퍼티 정의
```
protocol someProtocol {
    associationtype MyType
    var name: MyType { get }
}
```

### 2. someProtocol을 conform하는 구조체 정의
* name 프로퍼티를 Int 타입으로 사용
    ```
   struct intPropStruct: someProtocol {
       var name: Int {
           return 100
       }
   } 
    ```
* name 프로퍼티를 String 타입으로 사용
    ```
    struct strPropStruct: someProtocol {
       var name: String {
           return "some text"
       }
   } 
    ```



### 3. (Additional) associationtype에 제약사항 추가
* Equatable 제약을 가진 associationtype
    ```
    protocol restrictedProtocol {
        associationtype MyType: Equatable
        var name: MyType { get }
    }
    ```
* 제약을 따르지 않았으므로 아래 코드는 에러가 발생함
    ```
    class SomeClass {}
    ```
    ```
    struct restrictedStruct: restrictedProtocol {
        var name: SomeClass {   // SomeClass는 restrictedProtocol을 conform 하지 않으므로 ERROR
            return name
        }
    }
    ```