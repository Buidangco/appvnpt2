const express = require('express');
const cors = require('cors');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 8787;
const ASMX_BASE = 'https://hungyentourism.com.vn/api/home.asmx';

// Credentials are injected by the proxy — never sent from the Flutter client.
// This keeps secrets out of the compiled JS bundle.
const ASMX_USER = process.env.ASMX_USER || 'VNPT@manhbeo123';
const ASMX_PASS = process.env.ASMX_PASS || 'Manhbeo@123@9897';

app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.get('/health', (_req, res) => {
  res.json({ ok: true, service: 'hungyen-asmx-proxy' });
});

// Image proxy — forwards images from hungyentourism.com.vn with CORS headers.
// Flutter Web calls: http://localhost:8787/img/<path>
app.get('/img/*', async (req, res) => {
  const imgPath = req.params[0];
  const targetUrl = `https://hungyentourism.com.vn/${imgPath}`;
  try {
    const response = await axios.get(targetUrl, {
      responseType: 'arraybuffer',
      timeout: 15000,
    });
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Content-Type', response.headers['content-type'] || 'image/jpeg');
    res.set('Cache-Control', 'public, max-age=86400');
    res.send(response.data);
  } catch (error) {
    res.status(404).json({ error: 'image_not_found', url: targetUrl });
  }
});

app.get('/api/home.asmx', async (req, res) => {
  try {
    const response = await axios.get(ASMX_BASE, {
      params: req.query,
      timeout: 15000,
      responseType: 'text',
    });
    res.status(response.status);
    res.set('content-type', response.headers['content-type'] || 'text/plain; charset=utf-8');
    res.send(response.data);
  } catch (error) {
    const status = error.response?.status || 502;
    res.status(status).json({
      error: 'proxy_get_failed',
      message: error.message,
      upstreamStatus: error.response?.status || null,
    });
  }
});

app.post('/api/home.asmx/:method', async (req, res) => {
  const method = req.params.method;
  const target = `${ASMX_BASE}/${method}`;

  try {
    // Inject credentials server-side — override whatever the client sent.
    const bodyWithCreds = {
      ...req.body,
      uservn: ASMX_USER,
      passvn: ASMX_PASS,
    };
    const body = new URLSearchParams(bodyWithCreds).toString();
    const response = await axios.post(target, body, {
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      timeout: 20000,
      responseType: 'text', // ASMX returns XML, not JSON
    });

    // ASMX returns XML like: <string xmlns="...">{"data": ...}</string>
    // Extract JSON from XML
    const xmlData = response.data;
    const jsonMatch = xmlData.match(/<string[^>]*>(.*?)<\/string>/s);
    
    if (jsonMatch && jsonMatch[1]) {
      try {
        // Parse the JSON string inside XML
        const jsonData = JSON.parse(jsonMatch[1]);
        res.status(response.status).json(jsonData);
      } catch (parseError) {
        // If JSON parse fails, return the raw string
        res.status(response.status).json({ data: jsonMatch[1] });
      }
    } else {
      // If no JSON found in XML, return raw XML
      res.status(response.status).send(xmlData);
    }
  } catch (error) {
    const status = error.response?.status || 502;
    res.status(status).json({
      error: 'proxy_post_failed',
      method,
      message: error.message,
      upstreamStatus: error.response?.status || null,
      upstreamData: error.response?.data || null,
    });
  }
});

app.listen(PORT, () => {
  console.log(`Proxy running at http://localhost:${PORT}`);
  console.log(`Forwarding to ${ASMX_BASE}`);
  console.log(`Credentials: uservn=${ASMX_USER.substring(0, 4)}... (injected server-side)`);
});
