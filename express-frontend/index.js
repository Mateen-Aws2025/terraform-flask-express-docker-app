const express = require('express');
const bodyParser = require('body-parser');
const fetch = require('node-fetch');
const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(express.static('public'));

app.post('/submit', async (req, res) => {
    const formData = req.body;
    try {
        const response = await fetch('http://flask-backend:5000/submit', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(formData)
        });
        const data = await response.json();
        res.json(data);
    } catch (err) {
        res.status(500).json({ error: 'Backend not reachable' });
    }
});

app.listen(PORT, () => console.log(`Frontend running on port ${PORT}`));

