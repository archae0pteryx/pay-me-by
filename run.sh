#!/bin/bash

if [ ! -e ./.git ]; then
  echo "not a git repository"
elif [ ! -e "$1" ]; then
  echo "cant find index.html file"
fi

  # node ./script/index.js "$1" "$2"
NOW=$(eval "date +%s%3")
#TODO: dynamic date
THEN=2592000000
CHUNK=$(expr $THEN - $NOW / 100)
JS="<script>let now = Date.now();const chunk = ($THEN - now) / 100;let oValue = 0;while (now + chunk <= $THEN) {now +=chunk;oValue++;};document.body.style.opacity = oValue</script></body>"
#TODO: Dont replace whole file if it exists
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
echo "HOOK TEST!"
if grep -Fxq "$JS" "$1"; then
  echo "script found"
fi
sed -i '' -e "s|</body>|$JS|g" "$1"
EOF
chmod +x .git/hooks/pre-commit
