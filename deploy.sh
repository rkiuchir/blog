# 公開ファイルの生成
hugo

# リポジトリへのpush
git add -A
msg="Update: `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push -f origin master
