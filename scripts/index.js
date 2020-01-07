const fs = require('fs')
const { genHTML, genBASH } = require('./generate')
const injectHTML = require('./injectHTML')
const injectHook = require('./injectHook')
async function run () {
  try {
    const [ indexFile, date ] = parseArgs()
    const dateInMS = Date.parse(date)
    const html = genHTML(dateInMS)
    const bash = genBASH(dateInMS)
    writeIndex(indexFile, html)
    // writeBash(bash)

  } catch (e) {
    throw new Error(e)
  }
}

function parseArgs() {
  const [ ,, indexFile, date ] = process.argv
  if (!indexFile) {
    throw new Error('Missing indexFile')
  } else if (indexFile.indexOf('.html') === -1) {
    throw new Error('indexFile must have .html extension')
  }else if (!fs.existsSync(indexFile)) {
    throw new Error('cant find provided index file')
  }
  return [ indexFile, date ]
}

function writeIndex(file, string) {
  fs.readFileSync(file, 'utf8', (err, data) => {
    if (err) throw new Error(err)
    const result = data.replace(/\<\/body\>/g, string);
    fs.writeFileSync(file, result, 'utf8', console.error);
  })
  return true
}

function writeBash(bash) {
  fs.writeFileSync('./.git/hooks/pre-commit', bash)
}

run()
