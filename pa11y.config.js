'use strict';
module.exports = {
    chromeLaunchConfig: {
        executablePath: process.env.CHROME_PATH,
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
    },
};
