const express = require('express');
const bodyParser = require('body-parser');
const fetch = require('node-fetch');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(express.static('public'));

app.get("/", (req, res) => {
  res.send("Frontend is running");
});

app.post('/submit', async (req, res) => {
  try {
    const response = await fetch('http://localhost/submit', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(req.body)
    });
    const data = await response.json();
    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Backend not reachable' });
  }
});

app.listen(PORT, "0.0.0.0", () =>
  console.log(`Frontend running on port ${PORT}`)
);

