sudo find -type f -name "*.java"| xargs grep 'http.*.com' | awk '{for(i=2;i<=NF;++i) printf $i "\t";printf "\n"}' | grep -Eo 'http.*?.com' | grep -v 'test' | sort | uniq -c |sort -k1,1nr
