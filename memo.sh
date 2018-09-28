# 送る
scp  ./minrevi01_kakuyasu.pro.sql servername:/tmp/filename
scp  /tmp/minrevi01_kakuyasu.pro.sql daisuke-fukuda@servername:/tmp/filename

# 取得
scp  daisuke-fukuda@servername:/tmp/20171127_minrevi01_kakuyasu.sql /tmp/
scp  servername:/tmp/20171127_minrevi01_kakuyasu.sql ~/Downloads


ローカルからリモート
rsync -ahv ./src/ username@servername:/virtual/minrevi/public_html/ --max-size=10M

リモートからローカル
rsync -ahvn username@servername:/virtual/minrevi/public_html/dev-simplelife.minrevi.co.jp/ ./src/  --max-size=10M


find ./ -type f -print | xargs grep 'hoge'

cat logfile | awk -F'\t' '{if ($5 != "status:200") print $1}' | cut -c 1-15 |sort -n |  uniq -c
cat  logfile | awk -F'\t' '{if ($5 != "status:200") print $4}' | sort  | uniq | sed -e 's/req:GET//g' | sed -e 's/ HTTP\/1.1//g'
cat   logfile | awk -F'\t' '{if ($5 != "status:200" && $5 != "status:302") print $4}' | sort  | uniq | sed -e 's/req:GET//g' | sed -e 's/ HTTP\/1.1//g'

クエリパラメータ削除
sed 's/\(?[^?]*$\)//'


for i in $(seq 0 4184) ; do cat cacheList.txt | sed -n 'i*10,'  head dig -t TXT domain-hoge-${i}.com ; done
