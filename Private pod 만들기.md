# Private pod note

* ref links
    - 전반적인 가이드
        - https://medium.com/@hacky12/private-cocoa-pods-%EB%A7%8C%EB%93%A4%EA%B8%B0-cd1a89695ab
    - 오피셜 도큐먼트
        - https://guides.cocoapods.org/making/private-cocoapods.html
    - Cocoapods 유용한 정보 모음    
        - https://github.com/ClintJang/cocoapods-tips
    - 선학님이 준 링크.. 별 도움 안됨
        - https://github.com/CocoaPods/Specs/blob/master/Specs/5/9/a/Google-Mobile-Ads-SDK/7.58.0/Google-Mobile-Ads-SDK.podspec.json
    - 'Unable to find a specification for' case 관련 쓰레드.. 도움 안됨
        - https://github.com/CocoaPods/CocoaPods/issues/3877?source=post_page---------------------------
    - Podspec Syntax Reference
        - https://guides.cocoapods.org/syntax/podspec.html

    </br>
    - 확인 전
        - https://benoitpasquier.com/create-your-private-cocoapod-library/
        - https://hmhv.info/2015/02/add-library-to-cocoapods-k/
        - https://medium.com/@shahabejaz/create-and-distribute-private-libraries-with-cocoapods-5b6507b57a03
        - https://blog.autsoft.hu/maintaining-a-private-cocoa-pod/

        
* Command 정리
    * repo 목록
        > $ pod repo list

    * repo 추가
        > $ pod repo add [REPO_NAME] [SOURCE_URL]
        > ex: $ pod repo add sttrackmobile-specs https://gitlab.stunitas.com/tutor/sttrackmobile-specs.git

    * repo 제거
        > $ pod repo remove [REPO_NAME]
        > ex: $ pod repo remove sttrackmobile-specs


--- 

> old note

1. 기존 pod spec repository (https://gitlab.stunitas.com/c2c-mobile/stpods-specs.git) 에 pod spec을 넣으려 했으나 살패
`remote: GitLab: You are not allowed to push code to protected branches on this project.`        
`To https://gitlab.stunitas.com/c2c-mobile/stpods-specs.git`
` ! [remote rejected] HEAD -> master (pre-receive hook declined)`
`error: failed to push some refs to 'https://gitlab.stunitas.com/c2c-mobile/stpods-specs.git'`

2. 새 repository 생성하여 재시도 (https://gitlab.stunitas.com/ajiaco/sttrackmobile-specs.git)
    1. pod repo 등록
        $ pod repo add sttrackmobile-specs https://gitlab.stunitas.com/ajiaco/sttrackmobile-specs.git
        $ pod repo lint .
    2. pod repo push
        $ cd ~/.cocoapods/repos/sttrackmobile-specs
        $ pod repo push sttrackmobile-specs ~/Documents/Workspace/STTrackMobile/sttrackmobile-ios/STTrackMobile.podspec
        * specific does not validate. 라고 나온다면 
        $ pod repo push --allow-warnings sttrackmobile-specs ~/Documents/Workspace/STTrackMobile/sttrackmobile-ios/STTrackMobile.podspec
    3. 푸시까지는 일단 성공

3. 실제 프로젝트에 적용
    1. GDNY의 Podfile에 source 추가
        source 'https://gitlab.stunitas.com/ajiaco/sttrackmobile-specs.git'

> https://gitlab.stunitas.com/tutor/sttrackmobile-specs.git 로 경로 변경
source 'https://gitlab.stunitas.com/tutor/sttrackmobile-specs.git'




1. git 푸시
2. spec repo
    pod repo add [REPO_NAME] [GIT_ADDRESS]
3. cocoapods repo로 이동한 뒤 생성한 라이브러리 폴더로 이동
    cd ~/.cocoapods/repos
    cd [생성한_라이브러리]
4. podspec 푸시
    pod repo push [REPO_NAME] [아까 바탕화면에서 만들었던 라이브러리 폴더 안에있는 .podspec경로] --allow-warnings
        /Users/tprs/Desktop/pr_pod/STTrackMobile/STTrackMobile.podspec