# 🍎 안전신문고 iOS
35기 AND SOPT 합동세미나 iOS 9팀 Alpha (fe)male

## ☕️ Developers

| [이지훈](https://github.com/hooni0918) | [김유림](https://github.com/yurim830) | [김희은](https://github.com/HEHEEUN) | [김한열](https://github.com/OneTen19) |
| --- | --- | --- | --- |
| <img src="https://avatars.githubusercontent.com/u/109647045?v=4" width="250"/> | <img src="https://avatars.githubusercontent.com/u/157277372?v=4" width="250"/> | <img src="https://avatars.githubusercontent.com/u/105585135?v=4" width="250"/> | <img src="https://avatars.githubusercontent.com/u/63261054?v=4" width="250"/> | 


## ☕️ 사용 기술 및 라이브러리
| 라이브러리(Library) | 목적(Purpose)            | 버전(Version)                                                |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| Alamofire           | 간결한 네트워크 요청과 구조화된 관리 방식으로 코드 가독성과 유지보수성 향상        | ![Alamofire](https://img.shields.io/badge/Alamofire-5.10.1-orange)|
| SnapKit             | Auto Layout의 간결한 작성 및 가독성 향상| ![Kingfisher](https://img.shields.io/badge/SnapKit-5.7.1-black) |
| Then                | 간결한 코드 처리 및 가독성 향상        | ![Kingfisher](https://img.shields.io/badge/Then-3.0.0-white) |
| Kingfisher           | 효율적인 이미지 다운로드 및 캐싱을 통해 네트워크 이미지 로딩 성능 향상 | ![Kingfisher](https://img.shields.io/badge/Kingfisher-8.11.0-yellow) |
<br>

## ☕️ 브랜치 전략
### 💩 Label

|태그|사용하는 부분|
|:-----:|:-----:|
|[Feat]|기능 구현 시 사용합니다.|
|[Style]|UI 구현 시 사용합니다.|
|[Add]|사진 등 에셋이나 라이브러리 추가 시 사용합니다.|
|[Fix]|버그나 오류 해결 시 사용합니다.|
|[Docs]|리드미, 템플릿 등 문서 수정 및 주석 추가 시 사용합니다.|
|[Refactor]|기존 코드를 성능 개선 등의 이유로 리팩토링했을 때 사용합니다.|
|[Delete]|기존 코드나 파일을 삭제했을 때 사용합니다.|
|[Setting]|프로젝트 관련 설정 변경 시 사용합니다.|
|[Chore]| 짬통.|


### 💩 Branch Naming Rule
- `Feat/#이슈번호-이슈명`

<br>

<details>
<summary>
  🧄 전체 플로우 요약
</summary>


````


이슈를 파고 - 이슈 번호 생긴거 그대로 브랜치를 파고 - 작업할 브랜치로 이동해서 - 브랜치에서 작업후 커밋을 하고 푸시를 하고 - 메인 `yurim`에 머지를 한다.

💡 이슈를 파고

→ `Feat: withdrawAPI`


💡 이슈 번호 생긴거 그대로 브랜치를 파고

→ `Feat/#123-withdrawAPI`


작업할 브랜치로 이동해서 

브랜치에서 작업후 커밋을 하고 푸시를 하고 

머지하기

````

</details>

<br>
<br>

### 💩 Git Covention
1.  무조건 첫글자 대문자
2.  카멜케이스 쓰기
3.  깃모지 없고
4.  대괄호는 다 없고.

<details>
        
<summary>
  🧄 깃 컨벤션 자세하게
</summary>

    코드 컨벤션을 사용하는 이유는 모든 코드가 한사람이 작성한것같은 코드가 되어야 한다. 그래야 유지보수가 쉽고 이해도 빨라짐.
    
    [GitHub - StyleShare/swift-style-guide: StyleShare에서 작성한 Swift 한국어 스타일 가이드](https://github.com/StyleShare/swift-style-guide)
    
    들여쓰기 → 탭 
    
    줄바꿈 100자 → text editing 에서 넘어가면 **control M** 눌러서 개행.
    
    **빈 줄**
    
    - 빈 줄에는 공백이 포함되지 않도록 합니다.
    - 모든 파일은 빈 줄로 끝나도록 합니다.
    - MARK 구문 위와 아래에는 공백이 필요합니다.
    
    **임포트**
    
    모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.
    
    ```swift
    import UIKit
    
    import SwiftyColor
    import SwiftyImage
    import Then
    import URLNavigator
    ```
    
    **클래스와 구조체**
    
    - 클래스와 구조체의 이름에는 UpperCamelCase를 사용합니다.
    - 클래스 이름에는 접두사Prefix를 붙이지 않습니다.
        
        **좋은 예:**
        
        ```swift
        class SomeClass {
          // class definition goes here
        }
        
        struct SomeStructure {
          // structure definition goes here
        }
        ```
        
        **나쁜 예:**
        
        ```swift
        class someClass {
        // class definition goes here
        }
        
        struct someStructure {
        // structure definition goes here
        }
        ```
        
    
    **함수**
    
    - 함수 이름에는 lowerCamelCase를 사용합니다.
    - 함수 이름 앞에는 되도록이면 `get`을 붙이지 않습니다.
        
        **좋은 예:**
        
        ```swift
        func name(for user: User) -> String?
        ```
        
        **나쁜 예:**
        
        ```swift
        func getName(for user: User) -> String?
        ```
        
    
    함수이름
    
    버튼 누르는거면
    
    `nextButtonTapped`
    
    명사 동사 순으로 결정
    
    **변수**
    
    - 변수 이름에는 lowerCamelCase를 사용합니다.
    
    **상수**
    
    - 상수 이름에는 lowerCamelCase를 사용합니다.
        
        **좋은 예:**
        
        ```
        let maximumNumberOfLines = 3
        ```
        
        **나쁜 예:**
        
        `let MaximumNumberOfLines = 3
        let MAX_LINES = 3`
        
    
    본 문서는 [크리에이티브 커먼즈 저작자표시 4.0 국제 라이센스](http://creativecommons.org/licenses/by/4.0/)에 따라 이용할 수 있으며, 저작권은 [전수열](https://github.com/devxoul)과 [StyleShare](https://stylesha.re/)에게 있습니다.
    
    **라이센스**
    
    - 프로토콜을 적용할 때에는 extension을 만들어서 관련된 메서드를 모아둡니다.
        
        **좋은 예**:
        
        ```swift
        final class MyViewController: UIViewController {
          // ...
        }
        
        // MARK: - UITableViewDataSource
        
        extension MyViewController: UITableViewDataSource {
          // ...
        }
        
        // MARK: - UITableViewDelegate
        
        extension MyViewController: UITableViewDelegate {
          // ...
        }
        ```
        
        **나쁜 예**:
        
        ```
        final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
          // ...
        }
        ```
        
    
    - 더이상 상속이 발생하지 않는 클래스는 항상 `final` 키워드로 선언합니다.
    
    - 가능하다면 변수를 정의할 때 함께 초기화하도록 합니다. [Then](https://github.com/devxoul/Then)을 사용하면 초기화와 함께 속성을 지정할 수 있습니다.
        
        ```swift
        let label = UILabel().then {
          $0.textAlignment = .center
          $0.textColor = .black
          $0.text = "Hello, World!"
        }
        ```
        
    
    **프로그래밍 권장사항**
    
    - `// MARK:`를 사용해서 연관된 코드를 구분짓습니다.
        
        Objective-C에서 제공하는 `#pragma mark`와 같은 기능으로, 연관된 코드와 그렇지 않은 코드를 구분할 때 사용합니다.
        
        간격은 위에 두줄, 아래 한줄
        
        ```
        // MARK: - 
          
        override init(frame: CGRect) {
          // doSomething()
        }
        
        deinit {
          // doSomething()
        }
        
        // MARK: - Layout
        
        override func layoutSubviews() {
          // doSomething()
        }
        
        // MARK: - Actions
        
        override func menuButtonDidTap() {
          // doSomething()
        }
        ```
        
    
    - `///`를 사용해서 문서화에 사용되는 주석을 남깁니다.
        
        ```
        /// 사용자 프로필을 그려주는 뷰
        class ProfileView: UIView {
        
          /// 사용자 닉네임을 그려주는 라벨
          var nameLabel: UILabel!
        }
        ```
        
    
    **주석**
    
    - 구조체를 생성할 때에는 Swift 구조체 생성자를 사용합니다.
        
        **좋은 예:**
        
        ```
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        ```
        
        **나쁜 예:**
        
        ```
        let frame = CGRectMake(0, 0, 100, 100)
        ```
        
    - 클래스와 구조체 내부에서는 `self`를 명시적으로 사용합니다.
    
    **클래스와 구조체**
    
    - 파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.
        
        **좋은 예:**
        
        ```swift
        let completionBlock: (() -> Void)?
        ```
        
        **나쁜 예:**
        
        ```swift
        let completionBlock: (() -> ())?let completionBlock: ((Void) -> (Void))?
        ```
        
    
    **클로저**
    
    - Delegate 메서드는 프로토콜명으로 네임스페이스를 구분합니다.
        
        **좋은 예:**
        
        ```swift
        protocol UserCellDelegate {
          func userCellDidSetProfileImage(_ cell: UserCell)
          func userCell(_ cell: UserCell, didTapFollowButtonWith user: User)
        }
        ```
        
        **나쁜 예:**
        
        ```swift
        protocol UserCellDelegate {
          func didSetProfileImage()
          func followPressed(user: User)
        
          // `UserCell`이라는 클래스가 존재할 경우 컴파일 에러 발생
          func UserCell(_ cell: UserCell, didTapFollowButtonWith user: User)
        }
        ```
        
    
    **Delegate**
    
    - 약어로 시작하는 경우 소문자로 표기하고, 그 외의 경우에는 항상 대문자로 표기합니다.
        
        **좋은 예:**
        
        ```swift
          let userID: Int?
          let html: String?
          let websiteURL: URL?
          let urlString: String?
        
        ```
        
        **나쁜 예:**
        
        ```swift
          let userId: Int?
          let HTML: String?
          let websiteUrl: NSURL?
          let URLString: String?
        
        ```
        
    
    **약어**
    
    ```swift
    protocol SomeProtocol {
      // protocol definition goes here
    }
    
    struct SomeStructure: SomeProtocol, AnotherProtocol {
      // structure definition goes here
    }
    
    class SomeClass: SomeSuperclass, SomeProtocol, AnotherProtocol {
        // class definition goes here
    }
    
    extension UIViewController: SomeProtocol, AnotherProtocol {
      // doSomething()
    }`
    ```
    
    **좋은 예:**
    
    - extension을 통해 채택할 때도 동일하게 적용됩니다.
    - 구조체나 클래스에서 프로토콜을 채택할 때는 콜론과 빈칸을 넣어 구분하여 명시합니다.
    - 프로토콜의 이름에는 UpperCamelCase를 사용합니다.
    
    **프로토콜**
    
    - enum의 각 case에는 lowerCamelCase를 사용합니다.
        
        **좋은 예:**
        
        ```swift
        enum Result {
          case .success
          case .failure
        }
        ```
        
        **나쁜 예:**
        
        ```swift
        enum Result {
          case .Success
          case .Failure
        }
        
        enum result {
          case .Success
          case .Failure
        }
        ```
        
    - enum의 이름에는 UpperCamelCase를 사용합니다.


</details>

<br>
<br>

## ☕️ 폴더링 구조
```
📁 Project
├── AppDelegate
├── SceneDelegate
├── 📁 Source
│   ├── 🗂️ Onboarding
│   │   ├── 🗂️ Model
│   │   ├── 🗂️ View
│   │   ├── 🗂️ ViewController
│   ├── 🗂️ Home
│   ├── 🗂️ User
│   ├── 🗂️ Core
│   │   ├── TabBar
│   │   ├── View
│   │   ├── Cell
├── 📁 Resource
|   ├── 🗂️ Extension
|   |   ├── UIFont+
|   |   ├── UIImage+
|   ├── 🗂️ Font
|   |   ├── .ttf
|   ├── Asset.xcassets
│   ├── Info.plist
├── 📁 Network
│   ├── NetworkManager
│   ├── 추후논의

```


## 시연영상

