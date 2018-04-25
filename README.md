#이 저장소는 git bash 실습을 위해 사용한 repository이다.
#Pro git 1,2,3장을 읽고, 후일 까먹을 때를 대비해 내게 당장 필요할 것 같은 명령어들만 정리해두었다.
#매트랩 파일은 그냥 작년에 구현한 mean-shift tracking 알고리즘 구현체이다.



# git config --global user.name "[name]"
# git config --global user.email "[email]"
기본 사용자 변수를 전역으로 설정

# git config --global alias.[단축키 명] [명령어]
전역 단축키 설정

# git init
해당 폴더에 git repository 생성






# git status
파일이 tackle인지 untackle인지 (애초에 추적대상인지 아닌지)
파일이 추가되거나 삭제되었는지
파일이 변경되었는지 
파일이 Merge중에 충돌을 일으켰는지 알려줌
--cached 혹은 --staged를 추가하면 이미 add되어 스테이지에 있는 파일을 대상으로 변화를 알려줌 

# git diff 
파일 내부의 변화까지 보여줌

# git add "[file name]" 
파일을 stage(혹은 index)에 추가
# git add . 
파일 전부 추가

# git commit
스테이지에 있는 파일들을 커밋함. 
vim편집기 창으로 가는데 변경사항을 "큰 따옴표"없이 입력하고 esc누르고 :wq를 입력하면 된다. (:w는 저장, :q는편집기 종료)

# git commit -a
걍 git add . 와 git commit을 합친거라고 보면 됨.
add와 commit을 한번에

# git commit -m "[commit message]"
메세지를 vim편집기 창으로 가지 않고 인라인으로 한번에 적어서 처리.

# git rm "[file name]"
파일 삭제. 파일을 Working Directory에서만 지우면 git status했을 때 unstage되었다고 하면서 계속 찾는다.
따라서 git rm 해줘서 git 내에서도 지워줘야 함.

# git rm -f "[file name]"
이미 파일을 수정했거나 Index에 추가했을 경우 강제 삭제

# git rm --cached "[file name]"
stage에서만 제거하고 Working Directory에 있는 파일은 지우지 않고 남겨두고 싶은 경우 (--staged도 사용가능)

#사용 예 : git rm log/\*.log
* 앞에 \ 을 사용한 것을 기억하자. 파일명 확장 기능은 쉘에만 있는 것이 아니라 Git 자체에도 있기 때문에 필요하다. 이 명령은 log/ 디렉토리에 있는 .log 파일을 모두 삭제한다.

#사용 예2 : $ git rm \*~
이 명령은 ~ 로 끝나는 파일을 모두 삭제한다.

# git mv "[file_from]" "[file_to]"
파일명 변경. 
사실
# mv README.md README
# git rm README.md
# git add README
와 똑같다.

# git log
히스토리 조회하는 명령어지만, 그냥 리모트 브랜치들에 대해서만 깃허브 웹사이트의 GUI를 이용하는게 내 수준에서 현명해보인다.

# git commit --amend
새 커밋을 만들지 않고 현재 커밋에서 되돌리기
# git reset HEAD "[file name]"
HEAD는 현재 작업중인 stage의 포인터를 말하는 것 같다. 이미 stage에 올라간 파일을 unstage한다.
# git checkout -- "[file name]"
modified된 파일을 현재 커밋에 있는 데이터로 되돌린다.
#####위 방법들을 쓰는 것 보다 그냥 Branch를 이용하는 것이 낫다.









# git tag
tag들 조회
# git tag "[tag name]" -m "[tag message]"
tag 붙이기
# git checkout -b "[branch name]" "[tag name]"
tag가 붙여진 특정 커밋기반의 브랜치 생성. 이 브랜치에서 작업한다고 해서 우리가 가져온 태그의 커밋이 바뀌는 것은 아니다. 
해당 커밋을 복사한 아예 새로운 브랜치와 커밋을 생성한다 보면 됨.






# git remote add "[remote name]" "[repository URL]"
Remote Repository(리모트 저장소)의 포인터를 추가

# git remote
연결된 리모트 저장소 확인
# git remote show "[remote name]"
연결된 리모트 저장소의 구체적인 정보 확인
# git remote rename "[Before]" "[After]"
로컬에 저장된 리모트 저장소 이름 변경
# git remote rm "[remote name]"
로컬에서 리모트 저장소 포인터 삭제

# git fetch
리모트 저장소의 데이터를 로컬로 가져오기

# get merge "[remote name]"
fetch로 가져온 리모트 저장소의 모든 Remote Branch(리모트 브랜치)의 Commit(커밋)을 연결된 Local Branch(로컬 브랜치)의 커밋에 Merge 
특정 리모트 브랜치에서만 Merge할거면
# get merge "[remote name]"/"[remote branch]"
# git pull
위 두 과정을 동시에


# git push "[remote name]" "[local branch name]"
# local에서 stage에 있는 commit을 Remote Branch로 Merge
자신과 같은 이름의 리모트 브랜치로만 Push된다. (로컬의 브랜치와 리모트 브랜치의 이름이 같아야 함)
다를 경우엔
# git push "[remote name]" "[local branch name]":"[remote branch name]":
이렇게 사용하라.


혹은 아예 먼저 리모트 저장소를 만들고 나서 클로닝 한 뒤 작업을 해나가거나 작업물을 Push하거나 할 수도 있음.
# git clone "[repository URL]" "[remote name]"




# git branch
현재 있는 브랜치 확인 *표시에 색들어온게 현재 브랜치*

# git branch --vv
현재 있는 브랜치들과 각각에 연결된 리모트 브랜치 확인

# git branch "[branch name]"
브랜치 생성

# git checkout "[branch name]"
브랜치 이동!

# git checkout -b "[branch name]"
브랜치 생성하면서 이동!

# git merge "[branch name]"
브랜치끼리 합치기

# git branch -d "[branch name]"
브랜치 삭제

Merge하다 충돌났을땐, 수동으로 충돌난거 수정해주고, 다시 add후 커밋.

# git branch --merged
# git branch --no-merged
Merge여부 확인할 때.







# git ls-remote "[remote name]"
모든 리모트의 브랜치, 태그 등등 조회








# git rebase "[branch name]"
자신이 해당 브랜치의 패치파일화 됨

#사용 예 :
#git checkout experiment
#git rebase master
#it checkout master
#git merge experiment
#Merge하지 않고 Fast-Forward로 처리 가능함. 
##########(단 이미 리모트 저장소에 Push한 커밋에 대해서는 절대 하지 말 것 !!!!!!!!!!!!!!!!!!!!)############






# git fetch
리모트 브랜치(리모트 트래킹 브랜치)들을 내려받은 뒤, Merge하지 않고 아예 해당 브랜치의 커밋에 해당하는 새 브런치를 만들려면
# git checkout -b "[branch name]" "[remote name]"/"[remote branch]"

해당 로컬 브랜치와 연결된 리모트 브랜치를 변경하려면
# git branch -u "[remote name]"/"[remote branch]"
혹은
# git branch --set-upstream-to "[remote name]"/"[remote branch]"

# git branch -vv
로컬 브랜치들과 각각에 연결된 리모트 브랜치들과 커밋의 앞서거나 뒤쳐지는 상황등을 다 보여줌
##########(단 현재 fetch된 리모트에 대한 정보이기 때문에 최신 정보를 확인하려면 당연히 
# git fetch; git branch -vv
처럼하여야 할 것임!!!!!!!)

# git push "[remote name]" --delete "[remote branch]"
리모트 브랜치 삭제.

로컬에 있는 리모트 저장소 포인터를 제거하는
#git remote rm "[remote name]"와는 다르게 아예 리모트 서버에 있는 리모트 브랜치를 제거해버린다.
그냥 깃허브웹에서 제공하는 GUI를 이용하는 것이 나아보임.




도움을 받은 페이지
:[Pro Git](https://git-scm.com/book/ko/v2)
