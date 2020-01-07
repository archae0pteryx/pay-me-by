#!/bin/bash

if [ ! -e ./.git ]; then
  echo "not a git repository"
elif [ ! -e "$1" ]; then
  echo "cant find index.html file"
elif [ ! "$2" ]; then
  echo "please supply a date"
else
  node ./script/index.js "$1" "$2"
fi

NOW=$(eval "date +%s%3")
#TODO: dynamic date
THEN=2592000000
CHUNK=$(expr $THEN - $NOW / 100)
JS="<script>let now = Date.now();const chunk = ($THEN - now) / 100;let oValue = 0;while (now + chunk <= $THEN) {now +=chunk;oValue++;};document.body.style.opacity = oValue</script></body>"
#TODO: Dont replace whole file if it exists
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
sed '/\<\/body\>/i $JS' "../../$1"
EOF

