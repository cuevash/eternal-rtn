const https = require('https');

const options = {
  protocol: 'https:',
  hostname: 'api.harvestapp.com',
  path: 'v2/reports/time/projects?from=20220101&to=20220601',
  headers: {
    'User-Agent': 'Node.js Harvest API Sample',
    Authorization:
      'Bearer ' +
      '938268.pt.hTX4w_Xh_bG2x7MAX9E2QXxBwZm5IFFQGlkmVHA0O5L1CVy8gUv28G2ywv3VzVDEC87s-3pGEUG7Rk3KsPg7pQ',
    'Harvest-Account-ID': '607779',
  },
};

https
  .get(options, (res) => {
    const { statusCode } = res;

    if (statusCode !== 200) {
      console.error(`Request failed with status: ${statusCode}`);
      return;
    }

    res.setEncoding('utf8');
    let rawData = '';
    res.on('data', (chunk) => {
      rawData += chunk;
    });
    res.on('end', () => {
      try {
        const parsedData = JSON.parse(rawData);
        console.log(parsedData);
      } catch (e) {
        console.error(e.message);
      }
    });
  })
  .on('error', (e) => {
    console.error(`Got error: ${e.message}`);
  });
