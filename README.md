git config --global user.name "[name]"
git config --global user.email "[email]"
#기본 사용자 변수를 전역으로 설정

git init
#해당 폴더에 git repository 생성

git remote add "[remote name]" "[repository URL]"
#Remote Repository(리모트 저장소)의 포인터를 추가

git fetch
#리모트 저장소의 데이터를 로컬로 가져오기

get merge "[remote name]"
#fetch로 가져온 리모트 저장소의 모든 Remote Branch(리모트 브랜치)의 Commit(커밋)을 연결된 Local Branch(로컬 브랜치)의 커밋에 Merge 

git push "[remote name]" "[remote branch name]"
#local에서 stage에 있는 commit을 Remote Branch로 Merge
#자신과 연결된 리모트 브랜치로만 Merge되는 것 같다.

git remote로 리모트 저장소 확인

혹은 아예 먼저 리모트 저장소를 만들고 나서 클로닝 한 뒤 작업을 해나가거나 작업물을 Push하거나 할 수도 있음.




도움을 받은 페이지
:[Pro Git](https://git-scm.com/book/ko/v2)
