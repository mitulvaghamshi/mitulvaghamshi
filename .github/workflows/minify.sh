cat dankawala/index.html | while read line; do echo -n "$line" >> dankawala/temp.html; done;
mv -f dankawala/temp.html dankawala/index.html

cat tailormade/index.html | while read line; do echo -n "$line" >> tailormade/temp.html; done;
mv -f tailormade/temp.html tailormade/index.html

cat index.html | while read line; do echo -n "$line" >> temp.html; done;
mv -f temp.html index.html

cat policy.html | while read line; do echo -n "$line" >> temp.html; done;
mv -f temp.html policy.html
