function genHTML(then) {
  return `<script>let now = Date.now();const chunk = (${then} - now) / 100;let oValue = 0;while (now + chunk <= ${then}) {now +=chunk;oValue++;};document.body.style.opacity = oValue</script></body>`
}

function genBASH(then) {
  const js = genHTML(then)
  return `#!/bin/bash
    echo ${js} 
  `
}
module.exports = {
  genHTML,
  genBASH
}
