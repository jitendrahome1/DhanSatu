import express from 'express'
import cors from 'cors'
import path from 'path'
import { fileURLToPath } from 'url'
import sqlite3 from 'sqlite3'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

const app = express()
app.use(cors())
app.use(express.json())

// Database setup
const dbPath = path.join(__dirname, 'data.sqlite')
const db = new sqlite3.Database(dbPath)

db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS stock_signals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    stockName TEXT NOT NULL,
    currentPrice REAL NOT NULL,
    profitPercent REAL NOT NULL,
    stopLoss REAL NOT NULL,
    target REAL NOT NULL,
    status TEXT NOT NULL,
    entryDate TEXT NOT NULL,
    createdAt TEXT NOT NULL,
    updatedAt TEXT NOT NULL
  )`)
})

// Helpers
function nowIso() { return new Date().toISOString() }

// CRUD endpoints
app.get('/api/signals', (req, res) => {
  db.all('SELECT * FROM stock_signals ORDER BY id DESC', [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message })
    res.json(rows)
  })
})

app.get('/api/signals/:id', (req, res) => {
  db.get('SELECT * FROM stock_signals WHERE id = ?', [req.params.id], (err, row) => {
    if (err) return res.status(500).json({ error: err.message })
    if (!row) return res.status(404).json({ error: 'Not found' })
    res.json(row)
  })
})

app.post('/api/signals', (req, res) => {
  const { stockName, currentPrice, profitPercent, stopLoss, target, status, entryDate } = req.body
  if (!stockName || currentPrice == null || profitPercent == null || stopLoss == null || target == null || !status || !entryDate) {
    return res.status(400).json({ error: 'Missing fields' })
  }
  const createdAt = nowIso(), updatedAt = createdAt
  const sql = 'INSERT INTO stock_signals (stockName, currentPrice, profitPercent, stopLoss, target, status, entryDate, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
  const params = [stockName, currentPrice, profitPercent, stopLoss, target, status, entryDate, createdAt, updatedAt]
  db.run(sql, params, function(err) {
    if (err) return res.status(500).json({ error: err.message })
    db.get('SELECT * FROM stock_signals WHERE id = ?', [this.lastID], (err2, row) => {
      if (err2) return res.status(500).json({ error: err2.message })
      res.status(201).json(row)
    })
  })
})

app.put('/api/signals/:id', (req, res) => {
  const { stockName, currentPrice, profitPercent, stopLoss, target, status, entryDate } = req.body
  const updatedAt = nowIso()
  const sql = `UPDATE stock_signals SET stockName=?, currentPrice=?, profitPercent=?, stopLoss=?, target=?, status=?, entryDate=?, updatedAt=? WHERE id=?`
  const params = [stockName, currentPrice, profitPercent, stopLoss, target, status, entryDate, updatedAt, req.params.id]
  db.run(sql, params, function(err) {
    if (err) return res.status(500).json({ error: err.message })
    if (this.changes === 0) return res.status(404).json({ error: 'Not found' })
    db.get('SELECT * FROM stock_signals WHERE id = ?', [req.params.id], (err2, row) => {
      if (err2) return res.status(500).json({ error: err2.message })
      res.json(row)
    })
  })
})

app.delete('/api/signals/:id', (req, res) => {
  db.run('DELETE FROM stock_signals WHERE id = ?', [req.params.id], function(err) {
    if (err) return res.status(500).json({ error: err.message })
    if (this.changes === 0) return res.status(404).json({ error: 'Not found' })
    res.status(204).end()
  })
})

// Minimal admin UI (static)
app.use('/admin', express.static(path.join(__dirname, 'public')))

// Root
app.get('/', (_req, res) => res.send('Dhansatu Admin Server running'))

const port = process.env.PORT || 3000
app.listen(port, () => console.log(`Admin server listening on http://localhost:${port}`))

