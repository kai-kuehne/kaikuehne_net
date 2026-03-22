'use strict';
// Prints the Chrome executable path resolved by puppeteer (reads .puppeteerrc.cjs).
process.stdout.write(require('puppeteer').executablePath());
